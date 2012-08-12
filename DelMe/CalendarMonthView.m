//
//  CalendarMonthView.m
//  DelMe
//
//  Created by Pete Callaway on 11/08/2012.
//  Copyright 2012 Pete Callaway. All rights reserved.
//

#import "CalendarMonthView.h"


@interface CalendarMonthView ()

@end


@implementation CalendarMonthView {
    CGSize _dayViewSize;
}


#pragma mark - Memory management

- (void)dealloc {
}


#pragma mark - Initialisation

// Designated initialiser
- (id)initWithMonth:(NSDateComponents *)month dayViewSize:(CGSize)dayViewSize {
    self = [super init];
    if (self != nil) {
        // Initialise properties
        _month = [month copy];
        _dayViewSize = dayViewSize;
        
        [self createDayViews];
    }

    return self;
}

- (void)createDayViews {
    NSInteger const numberOfDaysPerWeek = 7;
    
    NSDateComponents *day = [[NSDateComponents alloc] init];
    day.calendar = self.month.calendar;
    day.day = 1;
    day.month = self.month.month;
    day.year = self.month.year;

    NSDate *firstDate = [day.calendar dateFromComponents:day];
    day = [day.calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSCalendarCalendarUnit fromDate:firstDate];

    NSInteger startColumn = day.weekday - day.calendar.firstWeekday;
    if (startColumn < 0) {
        startColumn += numberOfDaysPerWeek;
    }
    CGPoint nextDayViewOrigin = CGPointZero;
    nextDayViewOrigin.x = _dayViewSize.width * startColumn;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"d";

    do {
        for (NSInteger column = startColumn; column < numberOfDaysPerWeek; column++) {
            if (day.month == self.month.month) {
                CGRect dayFrame = CGRectZero;
                dayFrame.origin = nextDayViewOrigin;
                dayFrame.size = _dayViewSize;
                
                UILabel *dayView = [[UILabel alloc] initWithFrame:dayFrame];
                [self addSubview:dayView];
                [dayView setText:[formatter stringFromDate:day.date]];
                [dayView setTextAlignment:UITextAlignmentCenter];
            }
            
            day.day = day.day + 1;
            day = [day.calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSCalendarCalendarUnit fromDate:day.date];
            
            nextDayViewOrigin.x += _dayViewSize.width;
        }
        
        nextDayViewOrigin.x = 0;
        nextDayViewOrigin.y += _dayViewSize.height;
        startColumn = 0;
    } while (day.month == self.month.month);
    
    self.frame = CGRectMake(0, 0, self.bounds.size.width, nextDayViewOrigin.y);
}

@end
