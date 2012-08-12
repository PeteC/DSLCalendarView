//
//  CalendarMonthView.h
//  DelMe
//
//  Created by Pete Callaway on 11/08/2012.
//  Copyright 2012 Pete Callaway. All rights reserved.
//


@interface CalendarMonthView : UIView

@property (nonatomic, copy, readonly) NSDateComponents *month;

// Designated initialiser
- (id)initWithMonth:(NSDateComponents*)month dayViewSize:(CGSize)dayViewSize;

@end

