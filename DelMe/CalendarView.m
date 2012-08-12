//
//  CalendarView.m
//  DelMe
//
//  Created by Pete Callaway on 09/08/2012.
//  Copyright 2012 Pete Callaway. All rights reserved.
//

#import "CalenderMonthSelectorView.h"
#import "CalendarMonthView.h"
#import "CalendarView.h"


@interface CalendarView ()

@property (nonatomic, strong) NSMutableDictionary *monthViews;
@property (nonatomic, strong) UIScrollView *monthContainerView;
@property (nonatomic, strong) CalenderMonthSelectorView *monthSelectorView;

@end


@implementation CalendarView {
    CGSize _dayViewSize;
}


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
    _dayViewSize = CGSizeMake(floorf(self.bounds.size.width / 7.0), 40);
    
    self.visibleMonth = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:[NSDate date]];
    self.visibleMonth.day = 1;
    
    self.monthSelectorView = [CalenderMonthSelectorView view];
    self.monthSelectorView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.monthSelectorView];
    
    [self.monthSelectorView.backButton addTarget:self action:@selector(didTapMonthBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.monthSelectorView.forwardButton addTarget:self action:@selector(didTapMonthForward:) forControlEvents:UIControlEventTouchUpInside];

    CGRect frame = self.bounds;
    frame.origin.y = CGRectGetMaxY(self.monthSelectorView.frame);
    frame.size.height -= frame.origin.y;
    self.monthContainerView = [[UIScrollView alloc] initWithFrame:frame];
    self.monthContainerView.clipsToBounds = YES;
    self.monthContainerView.backgroundColor = [UIColor redColor];
    self.monthContainerView.panGestureRecognizer.enabled = NO;
    [self addSubview:self.monthContainerView];
    
    self.monthViews = [[NSMutableDictionary alloc] init];

    [self updateMonthLabelMonth:self.visibleMonth];
    [self positionDayViewsForMonth:self.visibleMonth fromMonth:self.visibleMonth];
}


#pragma mark - Events

- (void)didTapMonthBack:(id)sender {
    NSDateComponents *fromMonth = [self.visibleMonth copy];
    [self.visibleMonth setMonth:self.visibleMonth.month - 1];
    
    [self updateMonthLabelMonth:self.visibleMonth];
    [self positionDayViewsForMonth:self.visibleMonth fromMonth:fromMonth];
}

- (void)didTapMonthForward:(id)sender {
    NSDateComponents *fromMonth = [self.visibleMonth copy];
    [self.visibleMonth setMonth:self.visibleMonth.month + 1];

    [self updateMonthLabelMonth:self.visibleMonth];
    [self positionDayViewsForMonth:self.visibleMonth fromMonth:fromMonth];
}


#pragma mark - 

- (void)updateMonthLabelMonth:(NSDateComponents*)month {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MMMM yyyy";
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateFromComponents:month];
    
    self.monthSelectorView.titleLabel.text = [formatter stringFromDate:date];
}

- (NSString*)monthViewKeyForMonth:(NSDateComponents*)month {
    month = [month.calendar components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:month.date];
    return [NSString stringWithFormat:@"%d.%d", month.year, month.month];
}

- (CalendarMonthView*)cachedOrCreatedMonthViewForMonth:(NSDateComponents*)month {
    month = [month.calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:month.date];

    NSString *monthViewKey = [self monthViewKeyForMonth:month];
    CalendarMonthView *monthView = [self.monthViews objectForKey:monthViewKey];
    if (monthView == nil) {
        monthView = [[CalendarMonthView alloc] initWithMonth:month dayViewSize:_dayViewSize];
        [self.monthViews setObject:monthView forKey:monthViewKey];
        [self.monthContainerView addSubview:monthView];
    }
    
    return monthView;
}

- (void)positionDayViewsForMonth:(NSDateComponents*)month fromMonth:(NSDateComponents*)fromMonth {
    fromMonth = [fromMonth copy];
    month = [month copy];
    
    CGFloat nextVerticalPosition = 0;
    CGFloat startingVerticalPostion = 0;
    CGFloat restingVerticalPosition = 0;
    CGFloat restingHeight = 0;
    NSComparisonResult monthComparisonResult = [month.date compare:fromMonth.date];
    NSTimeInterval animationDuration = (monthComparisonResult == NSOrderedSame) ? 0.0 : 0.5;
    
    NSMutableArray *activeMonthViews = [[NSMutableArray alloc] init];
    
    for (NSInteger monthOffset = -2; monthOffset <= 2; monthOffset += 1) {
        NSDateComponents *offsetMonth = [month copy];
        offsetMonth.month = offsetMonth.month + monthOffset;
        offsetMonth = [offsetMonth.calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:offsetMonth.date];
        
        // Check if this month should overlap the previous month
        if (monthOffset > -2 && offsetMonth.weekday - offsetMonth.calendar.firstWeekday != 0) {
            nextVerticalPosition -= _dayViewSize.height;
        }
        
        CalendarMonthView *monthView = [self cachedOrCreatedMonthViewForMonth:offsetMonth];
        [activeMonthViews addObject:monthView];
        
        CGRect frame = monthView.frame;
        frame.origin.y = nextVerticalPosition;
        nextVerticalPosition += frame.size.height;
        monthView.frame = frame;

        if (monthOffset == 0) {
            restingVerticalPosition = monthView.frame.origin.y;
            restingHeight = monthView.bounds.size.height;
        }
        else if (monthOffset == 1 && monthComparisonResult == NSOrderedAscending) {
            startingVerticalPostion = monthView.frame.origin.y;
        }
        else if (monthOffset == -1 && monthComparisonResult == NSOrderedDescending) {
            startingVerticalPostion = monthView.frame.origin.y;
        }
    }
    
    self.monthContainerView.contentSize = CGSizeMake(self.monthContainerView.bounds.size.width, nextVerticalPosition);
    
    NSArray *monthViewKeyes = self.monthViews.allKeys;
    for (NSString *key in monthViewKeyes) {
        UIView *monthView = [self.monthViews objectForKey:key];
        if (![activeMonthViews containsObject:monthView]) {
            [monthView removeFromSuperview];
            [self.monthViews removeObjectForKey:key];
        }
    }
    
    if (monthComparisonResult != NSOrderedSame) {
        [self.monthContainerView setContentOffset:CGPointMake(0, startingVerticalPostion) animated:NO];
    }
    
    [UIView animateWithDuration:animationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.monthContainerView.contentOffset = CGPointMake(0, restingVerticalPosition);
        
        CGRect frame = self.monthContainerView.frame;
        frame.size.height = restingHeight;
        self.monthContainerView.frame = frame;
        
        frame = self.frame;
        frame.size.height = CGRectGetMaxY(self.monthContainerView.frame);
        self.frame = frame;
    } completion:^(BOOL finished) {
    }];
}

@end
