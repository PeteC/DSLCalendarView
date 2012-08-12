//
//  CalenderMonthSelectorView
//  DelMe
//
//  Created by Pete Callaway on 09/08/2012.
//  Copyright 2012 Pete Callaway. All rights reserved.
//

#import "DSLCalenderMonthSelectorView.h"


@interface DSLCalenderMonthSelectorView ()

@end


@implementation DSLCalenderMonthSelectorView


#pragma mark - Memory management

- (void)dealloc {
}


#pragma mark - Initialisation

// Designated initialiser
+ (id)view {
    static UINib *nib;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    });
    
    NSArray *nibObjects = [nib instantiateWithOwner:nil options:nil];
    for (id object in nibObjects) {
        if ([object isKindOfClass:[self class]]) {
            return object;
        }
    }
    
    return nil;
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        // Initialise properties
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    // Get a dictionary of localised day names
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit fromDate:[NSDate date]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE";
    NSMutableDictionary *dayNames = [[NSMutableDictionary alloc] init];
    
    for (NSInteger index = 0; index < 7; index++) {
        NSInteger weekday = dateComponents.weekday - [dateComponents.calendar firstWeekday];
        if (weekday < 0) weekday += 7;
        [dayNames setObject:[formatter stringFromDate:dateComponents.date] forKey:@(weekday)];
        
        dateComponents.day = dateComponents.day + 1;
        dateComponents = [dateComponents.calendar components:NSCalendarCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit fromDate:dateComponents.date];
    }
    
    // Set the day name label texts to localised day names
    for (UILabel *label in self.dayLabels) {
        label.text = [[dayNames objectForKey:@(label.tag)] uppercaseString];
    }
}

@end
