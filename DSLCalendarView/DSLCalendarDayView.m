/*
 DSLCalendarDayView.h
 
 Copyright (c) 2012 Dative Studios. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 * Neither the name of the author nor the names of its contributors may be used
 to endorse or promote products derived from this software without specific
 prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


#import "DSLCalendarDayView.h"


@interface DSLCalendarDayView ()

@property (nonatomic, strong) UILabel *label;

@end


@implementation DSLCalendarDayView


#pragma mark - Memory management

- (void)dealloc {
}


#pragma mark - Initialisation

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.backgroundColor = [UIColor whiteColor];
        _positionInWeek = DSLCalendarDayViewMidWeek;
        
        // If this isn't a subclass, setup some defaults
        if ([self isMemberOfClass:[DSLCalendarDayView class]]) {
            _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
            _backgroundView.backgroundColor = [UIColor whiteColor];
            [self addSubview:_backgroundView];
            
            _dimmedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
            _dimmedBackgroundView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
            [self addSubview:_dimmedBackgroundView];
            
            _selectedBackgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
            [self addSubview:_selectedBackgroundView];

            _label = [[UILabel alloc] initWithFrame:self.bounds];
            _label.backgroundColor = [UIColor clearColor];
            _label.textAlignment = UITextAlignmentCenter;
            [self addSubview:_label];
        }
    }
    
    return self;
}


#pragma mark - Properties

- (void)setSelectionState:(DSLCalendarDayViewSelectionState)selectionState {
    _selectionState = selectionState;
    self.selectedBackgroundView.hidden = (selectionState == DSLCalendarDayViewNotSelected);

    // If this isn't a subclass, use the default images
    if ([self isMemberOfClass:[DSLCalendarDayView class]]) {
        self.label.textColor = [UIColor whiteColor];

        UIImageView *selectionImageView = nil;
        if ([self.selectedBackgroundView isKindOfClass:[UIImageView class]]) {
            selectionImageView = (UIImageView*)self.selectedBackgroundView;
        }
    
        switch (selectionState) {
            case DSLCalendarDayViewNotSelected:
                self.label.textColor = [UIColor blackColor];
                break;
                
            case DSLCalendarDayViewStartOfSelection:
                if (selectionImageView != nil) {
                    selectionImageView.image = [[UIImage imageNamed:@"DSLCalendarDaySelection-left"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
                }
                break;
                
            case DSLCalendarDayViewEndOfSelection:
                if (selectionImageView != nil) {
                    selectionImageView.image = [[UIImage imageNamed:@"DSLCalendarDaySelection-right"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
                }
                break;
                
            case DSLCalendarDayViewWithinSelection:
                if (selectionImageView != nil) {
                    selectionImageView.image = [[UIImage imageNamed:@"DSLCalendarDaySelection-middle"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
                }
                break;
                
            case DSLCalendarDayViewWholeSelection:
                if (selectionImageView != nil) {
                    selectionImageView.image = [[UIImage imageNamed:@"DSLCalendarDaySelection"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
                }
                break;
        }
    }
}

- (void)setDay:(NSDateComponents *)day {
    _day = [day copy];

    // If this isn't a subclass, set the label
    if ([self isMemberOfClass:[DSLCalendarDayView class]]) {
        self.label.text = [NSString stringWithFormat:@"%d", day.day];
    }
}

- (void)setInCurrentMonth:(BOOL)inCurrentMonth {
    _inCurrentMonth = inCurrentMonth;
    self.dimmedBackgroundView.alpha = inCurrentMonth ? 0.0 : 1.0;
}

@end
