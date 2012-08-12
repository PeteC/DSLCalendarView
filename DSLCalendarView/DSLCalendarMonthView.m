/*
 DSLCalendarMonthView.m
 
 Copyright (c) 2012 Dative Studios. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 * Neither the name of the author nor the names of its contributors may be used
 to endorse or promote products derived from this software without specific
 prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


#import "DSLCalendarDayView.h"
#import "DSLCalendarMonthView.h"
#import "DSLCalendarRange.h"


@interface DSLCalendarMonthView ()

@property (nonatomic, strong) NSMutableDictionary *dayViewsDictionary;

@end


@implementation DSLCalendarMonthView {
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
        _dayViewsDictionary = [[NSMutableDictionary alloc] init];
        
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
                
                DSLCalendarDayView *dayView = [[DSLCalendarDayView alloc] initWithFrame:dayFrame];
                dayView.day = day;
                [self.dayViewsDictionary setObject:dayView forKey:[self dayViewKeyForDay:day]];
                [self addSubview:dayView];
                 
                [dayView setText:[formatter stringFromDate:day.date]];
            }
            
            day.day = day.day + 1;
            day = [day.calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSCalendarCalendarUnit fromDate:day.date];
            
            nextDayViewOrigin.x += _dayViewSize.width;
        }
        
        nextDayViewOrigin.x = 0;
        nextDayViewOrigin.y += _dayViewSize.height;
        startColumn = 0;
    } while (day.month == self.month.month);
    
    self.frame = CGRectMake(0, 0, _dayViewSize.width * numberOfDaysPerWeek, nextDayViewOrigin.y);
}

- (void)updateDaySelectionStatesForRange:(DSLCalendarRange*)range {
    for (DSLCalendarDayView *dayView in self.dayViews) {
        if ([range containsDay:dayView.day]) {
            BOOL isStartOfRange = [range.startDay isEqual:dayView.day];
            BOOL isEndOfRange = [range.endDay isEqual:dayView.day];
            
            if (isStartOfRange && isEndOfRange) {
                dayView.selectionState = DSLCalendarDayViewWholeSelection;
            }
            else if (isStartOfRange) {
                dayView.selectionState = DSLCalendarDayViewStartOfSelection;
            }
            else if (isEndOfRange) {
                dayView.selectionState = DSLCalendarDayViewEndOfSelection;
            }
            else {
                dayView.selectionState = DSLCalendarDayViewWithinSelection;
            }
        }
        else {
            dayView.selectionState = DSLCalendarDayViewNotSelected;
        }
    }
}

#pragma mark - Properties

- (NSSet*)dayViews {
    return [NSSet setWithArray:self.dayViewsDictionary.allValues];
}

- (NSString*)dayViewKeyForDay:(NSDateComponents*)day {
    day = [day.calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:day.date];
    return [NSString stringWithFormat:@"%d.%d.%d", day.year, day.month, day.day];
}

- (DSLCalendarDayView*)dayViewForDay:(NSDateComponents*)day {
    return [self.dayViewsDictionary objectForKey:[self dayViewKeyForDay:day]];
}

@end
