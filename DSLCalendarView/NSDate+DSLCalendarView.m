//
//  NSDate+DSLCalendarView.m
//  DSLCalendarViewExample
//
//  Created by Pete Callaway on 16/08/2012.
//  Copyright 2012 Pete Callaway. All rights reserved.
//

#import "NSDate+DSLCalendarView.h"


@implementation NSDate (DSLCalendarView)

- (NSDateComponents*)dslCalendarView_dayWithCalendar:(NSCalendar*)calendar {
    return [calendar components:NSCalendarCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit fromDate:self];
}

- (NSDateComponents*)dslCalendarView_monthWithCalendar:(NSCalendar*)calendar {
    return [calendar components:NSCalendarCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
}

@end
