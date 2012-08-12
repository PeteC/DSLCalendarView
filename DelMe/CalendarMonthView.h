//
//  CalendarMonthView.h
//  DelMe
//
//  Created by Pete Callaway on 11/08/2012.
//  Copyright 2012 Pete Callaway. All rights reserved.
//

@class CalendarDayView;


@interface CalendarMonthView : UIView

@property (nonatomic, copy, readonly) NSDateComponents *month;
@property (nonatomic, strong, readonly) NSSet *dayViews;

// Designated initialiser
- (id)initWithMonth:(NSDateComponents*)month dayViewSize:(CGSize)dayViewSize;

- (CalendarDayView*)dayViewForDay:(NSDateComponents*)day;

@end

