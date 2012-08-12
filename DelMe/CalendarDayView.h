//
//  CalendarDayView.h
//  DelMe
//
//  Created by Pete Callaway on 12/08/2012.
//  Copyright 2012 Pete Callaway. All rights reserved.
//


@interface CalendarDayView : UIView

@property (nonatomic, copy) NSDateComponents *day;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign, getter = isSelected) BOOL selected;
@property (nonatomic, assign, getter = isInCurrentMonth) BOOL inCurrentMonth;

@end
