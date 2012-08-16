//
//  DSLCalenderDayCalloutView.m
//  DSLCalendarViewExample
//
//  Created by Pete Callaway on 16/08/2012.
//  Copyright 2012 Pete Callaway. All rights reserved.
//

#import "DSLCalendarDayCalloutView.h"


@interface DSLCalendarDayCalloutView ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end


@implementation DSLCalendarDayCalloutView

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

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        
    }
    
    return self;
}

- (void)configureForDay:(NSDateComponents*)day {
    self.titleLabel.text = [NSString stringWithFormat:@"%d", day.day];
}

@end
