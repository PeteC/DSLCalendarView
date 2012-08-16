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
            _backgroundView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, 1, 1)];
            _backgroundView.backgroundColor = [UIColor colorWithWhite:245.0/255.0 alpha:1.0];
            _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [self addSubview:_backgroundView];
            
            _dimmedBackgroundView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, 1, 1)];
            _dimmedBackgroundView.backgroundColor = [UIColor colorWithWhite:225.0/255.0 alpha:1.0];
            _dimmedBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [self addSubview:_dimmedBackgroundView];
            
            _selectedBackgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
            [self addSubview:_selectedBackgroundView];

            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width - 1, self.bounds.size.height)];
            label.textColor = [UIColor blackColor];
            label.shadowColor = [UIColor whiteColor];
            label.shadowOffset = CGSizeMake(0, 1.5);
            label.backgroundColor = [UIColor clearColor];
            label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            label.textAlignment = UITextAlignmentCenter;
            _contentView = label;
            [self addSubview:_contentView];
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
        UILabel *label = nil;
        if ([self.contentView isKindOfClass:[UILabel class]]) {
            label = (UILabel*)self.contentView;
        }
        label.textColor = [UIColor whiteColor];
        label.shadowOffset = CGSizeZero;

        UIImageView *selectionImageView = nil;
        if ([self.selectedBackgroundView isKindOfClass:[UIImageView class]]) {
            selectionImageView = (UIImageView*)self.selectedBackgroundView;
        }
    
        switch (selectionState) {
            case DSLCalendarDayViewNotSelected:
                label.textColor = [UIColor blackColor];
                label.shadowOffset = CGSizeMake(0, 1.5);
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
        if ([self.contentView isKindOfClass:[UILabel class]]) {
            [(UILabel*)self.contentView setText:[NSString stringWithFormat:@"%d", day.day]];
        }
    }
}

- (void)setInCurrentMonth:(BOOL)inCurrentMonth {
    _inCurrentMonth = inCurrentMonth;
    self.dimmedBackgroundView.alpha = inCurrentMonth ? 0.0 : 1.0;
}


#pragma mark - UIView methods

- (void)drawRect:(CGRect)rect {
    if ([self isMemberOfClass:[DSLCalendarDayView class]]) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetLineWidth(context, 1.0);
        
        CGContextSaveGState(context);
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:255.0/255.0 alpha:1.0].CGColor);
        CGContextMoveToPoint(context, 0.5, self.bounds.size.height - 0.5);
        CGContextAddLineToPoint(context, 0.5, 0.5);
        CGContextAddLineToPoint(context, self.bounds.size.width - 0.5, 0.5);
        CGContextStrokePath(context);
        CGContextRestoreGState(context);

        CGContextSaveGState(context);
        if (self.isInCurrentMonth) {
            CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:205.0/255.0 alpha:1.0].CGColor);
        }
        else {
            CGContextSetStrokeColorWithColor(context, [UIColor colorWithWhite:185.0/255.0 alpha:1.0].CGColor);
        }
        CGContextMoveToPoint(context, self.bounds.size.width - 0.5, 0.0);
        CGContextAddLineToPoint(context, self.bounds.size.width - 0.5, self.bounds.size.height - 0.5);
        CGContextAddLineToPoint(context, 0.0, self.bounds.size.height - 0.5);
        CGContextStrokePath(context);
        CGContextRestoreGState(context);
    }
}

@end
