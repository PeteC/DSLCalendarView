//
//  CalendarView.h
//  DelMe
//
//  Created by Pete Callaway on 09/08/2012.
//  Copyright 2012 Pete Callaway. All rights reserved.
//

#import "DSLCalendarRange.h"


@interface DSLCalendarView : UIView

@property (nonatomic, strong) NSDateComponents *visibleMonth;
@property (nonatomic, strong) DSLCalendarRange *selectedRange;

@end
