//
//  CalendarMonthView.h
//  DelMe
//
//  Created by Pete Callaway on 11/08/2012.
//  Copyright 2012 Pete Callaway. All rights reserved.
//

@class DSLCalendarDayView;


@interface DSLCalendarMonthView : UIView

@property (nonatomic, copy, readonly) NSDateComponents *month;
@property (nonatomic, strong, readonly) NSSet *dayViews;

// Designated initialiser
- (id)initWithMonth:(NSDateComponents*)month dayViewSize:(CGSize)dayViewSize;

- (DSLCalendarDayView*)dayViewForDay:(NSDateComponents*)day;

@end

