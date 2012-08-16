//
//  DSLCalenderDayCalloutView.h
//  DSLCalendarViewExample
//
//  Created by Pete Callaway on 16/08/2012.
//  Copyright 2012 Pete Callaway. All rights reserved.
//


@interface DSLCalendarDayCalloutView : UIView

// Designated initialisers
+ (id)view;
- (id)initWithFrame:(CGRect)frame;

- (void)configureForDay:(NSDateComponents*)day;

@end
