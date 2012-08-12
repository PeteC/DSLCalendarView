//
//  CalendarView.h
//  DelMe
//
//  Created by Pete Callaway on 09/08/2012.
//  Copyright 2012 Pete Callaway. All rights reserved.
//

#import "CalendarRange.h"


@interface CalendarView : UIView

@property (nonatomic, strong) NSDateComponents *visibleMonth;
@property (nonatomic, strong) CalendarRange *selectedRange;

@end
