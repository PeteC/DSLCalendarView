//
//  CalendarDayView.m
//  DelMe
//
//  Created by Pete Callaway on 12/08/2012.
//  Copyright 2012 Pete Callaway. All rights reserved.
//

#import "CalendarDayView.h"


@interface CalendarDayView ()

@end


@implementation CalendarDayView


#pragma mark - Memory management

- (void)dealloc {
}


#pragma mark - Initialisation

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}


#pragma mark - Properties

- (void)setSelected:(BOOL)selected {
    if (selected != _selected) {
        _selected = selected;
        [self setNeedsDisplay];
    }
}


#pragma mark -

- (void)drawRect:(CGRect)rect {
    if (self.isSelected) {
        [[UIColor yellowColor] setFill];
    }
    else {
        [self.backgroundColor setFill];
    }
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setFill];
    [self.text drawInRect:self.bounds withFont:[UIFont systemFontOfSize:17] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
}

@end
