//
//  CalendarRange.h
//  DelMe
//
//  Created by Pete Callaway on 12/08/2012.
//  Copyright 2012 Pete Callaway. All rights reserved.
//


@interface CalendarRange : NSObject

@property (nonatomic, copy) NSDateComponents *startDay;
@property (nonatomic, copy) NSDateComponents *endDay;

// Designated initialiser
- (id)initWithStartDay:(NSDateComponents*)start endDay:(NSDateComponents*)end;

- (BOOL)containsDay:(NSDateComponents*)day;

@end
