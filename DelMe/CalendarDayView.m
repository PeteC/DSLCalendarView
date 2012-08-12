//
//  CalendarDayView.m
//  DelMe
//
//  Created by Pete Callaway on 12/08/2012.
//  Copyright 2012 Pete Callaway. All rights reserved.
//

#import "CalendarDayView.h"


@interface CalendarDayView ()

@property (nonatomic, strong) UIView *adjacentMonthView;
@property (nonatomic, strong) UIView *selectedView;
@property (nonatomic, strong) UILabel *label;

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
        
        _adjacentMonthView = [[UIView alloc] initWithFrame:self.bounds];
        _adjacentMonthView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        [self addSubview:_adjacentMonthView];
        
        _selectedView = [[UIView alloc] initWithFrame:self.bounds];
        _selectedView.backgroundColor = [UIColor yellowColor];
        [self addSubview:_selectedView];

        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.backgroundColor = [UIColor clearColor];
        _label.textAlignment = UITextAlignmentCenter;
        [self addSubview:_label];
    }
    
    return self;
}


#pragma mark - Properties

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    self.selectedView.hidden = !selected;
}

- (NSString*)text {
    return self.label.text;
}

- (void)setText:(NSString *)text {
    self.label.text = text;
}

- (void)setInCurrentMonth:(BOOL)inCurrentMonth {
    _inCurrentMonth = inCurrentMonth;
    self.adjacentMonthView.alpha = inCurrentMonth ? 0.0 : 1.0;
}

@end
