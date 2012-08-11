//
//  CalendarView.m
//  DelMe
//
//  Created by Pete Callaway on 09/08/2012.
//  Copyright 2012 Pete Callaway. All rights reserved.
//

#import "CalenderMonthSelectorView.h"
#import "CalendarView.h"


@interface CalendarView ()

@property (nonatomic, copy) NSDictionary *dayViews;
@property (nonatomic, strong) CalenderMonthSelectorView *monthSelectorView;

@end


@implementation CalendarView


#pragma mark - Memory management

- (void)dealloc {
}


#pragma mark - Initialisation

// Designated initialisers

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        [self commonInit];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self commonInit];
    }

    return self;
}

- (void)commonInit {
    self.dayViews = [NSDictionary dictionary];
    
    self.visibleMonth = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:[NSDate date]];
    self.visibleMonth.calendar = [NSCalendar currentCalendar];
    
    self.monthSelectorView = [CalenderMonthSelectorView view];
    [self addSubview:self.monthSelectorView];
    
    [self.monthSelectorView.backButton addTarget:self action:@selector(didTapMonthBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.monthSelectorView.forwardButton addTarget:self action:@selector(didTapMonthForward:) forControlEvents:UIControlEventTouchUpInside];
    
    [self updateMonthLabelMonth:self.visibleMonth];
    [self positionDayViewsForMonth:self.visibleMonth animated:NO];
}


#pragma mark - Events

- (void)didTapMonthBack:(id)sender {
    [self.visibleMonth setMonth:self.visibleMonth.month - 1];
    [self updateMonthLabelMonth:self.visibleMonth];
}

- (void)didTapMonthForward:(id)sender {
    [self.visibleMonth setMonth:self.visibleMonth.month + 1];
    [self updateMonthLabelMonth:self.visibleMonth];
}


#pragma mark - 

- (void)updateMonthLabelMonth:(NSDateComponents*)month {
    [self firstVisiblealendarDayForMonth:month];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MMMM yyyy";
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateFromComponents:month];
    
    self.monthSelectorView.titleLabel.text = [formatter stringFromDate:date];
}

- (NSString*)dayViewKeyForDay:(NSDateComponents*)day {
    return [NSString stringWithFormat:@"%d.%d.%d", day.year, day.month, day.day];
}

- (NSDateComponents*)firstVisiblealendarDayForMonth:(NSDateComponents*)month {
    NSDateComponents *firstDay = [[NSDateComponents alloc] init];

    firstDay.calendar = month.calendar;
    firstDay.day = 1;
    firstDay.month = month.month;
    firstDay.year = month.year;
    NSDate *firstDate = [firstDay.calendar dateFromComponents:firstDay];
    
    firstDay = [firstDay.calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:firstDate];
    firstDay.day -= firstDay.weekday - firstDay.calendar.firstWeekday;

    return firstDay;
}

- (void)positionDayViewsForMonth:(NSDateComponents*)month animated:(BOOL)animated {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d";
    
    NSMutableDictionary *activeDayViews = [NSMutableDictionary dictionary];
    CGSize dayViewSize = CGSizeMake(floorf(self.bounds.size.width / 7.0), 30);
    
    CGFloat duration = animated ? 0.5 : 0.0;
    
    [UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationCurveEaseInOut animations:^{
        NSDateComponents *day = [self firstVisiblealendarDayForMonth:month];
        CGPoint nextDayViewOrigin = CGPointMake(0, CGRectGetMaxY(self.monthSelectorView.frame));

        do {
            for (NSInteger column = 0; column < 7; column++) {
                CGRect dayFrame = CGRectZero;
                dayFrame.origin = nextDayViewOrigin;
                dayFrame.size = dayViewSize;
                
                NSString *dayViewKey = [self dayViewKeyForDay:day];
                UIView *dayView = [self.dayViews objectForKey:dayViewKey];
                if (dayView == nil) {
                    dayView = [[UILabel alloc] initWithFrame:dayFrame];
                    [self addSubview:dayView];
                    
                    [(UILabel*)dayView setText:[formatter stringFromDate:day.date]];
                    [(UILabel*)dayView setTextAlignment:UITextAlignmentCenter];
                }
                else {
                    dayView.frame = dayFrame;
                }
                
                [activeDayViews setObject:dayView forKey:dayViewKey];
                
                day.day = day.day + 1;
                day = [day.calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSCalendarCalendarUnit fromDate:day.date];
                
                nextDayViewOrigin.x += dayViewSize.width;
            }
            
            nextDayViewOrigin.x = 0;
            nextDayViewOrigin.y += dayViewSize.height;
        } while (day.month == month.month);
        
        self.dayViews = activeDayViews;
    } completion:^(BOOL finished) {
    }];
}

@end
