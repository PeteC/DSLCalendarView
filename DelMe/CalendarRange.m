//
//  CalendarRange.m
//  DelMe
//
//  Created by Pete Callaway on 12/08/2012.
//  Copyright 2012 Pete Callaway. All rights reserved.
//

#import "CalendarRange.h"


@interface CalendarRange ()

@end


@implementation CalendarRange


#pragma mark - Memory management

- (void)dealloc {
}


#pragma mark - Initialisation

// Designated initialiser
- (id)initWithStartDay:(NSDateComponents *)start endDay:(NSDateComponents *)end {
    NSParameterAssert(start);
    NSParameterAssert(end);
    
    self = [super init];
    if (self != nil) {
        // Initialise properties
        _startDay = [start copy];
        _endDay = [end copy];
    }

    return self;
}


#pragma mark - Properties

- (void)setStartDay:(NSDateComponents *)startDay {
    NSParameterAssert(startDay);
    _startDay = [startDay copy];
}

- (void)setEndDay:(NSDateComponents *)endDay {
    NSParameterAssert(endDay);
    _endDay = [endDay copy];
}


#pragma mark

- (BOOL)containsDay:(NSDateComponents*)day {
    NSDate *dayDate = day.date;

    if ([self.startDay.date compare:dayDate] == NSOrderedDescending) {
        return NO;
    }
    else if ([self.endDay.date compare:dayDate] == NSOrderedAscending) {
        return NO;
    }
    
    return YES;
}

@end
