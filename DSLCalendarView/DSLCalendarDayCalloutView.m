/*
 DSLCalendarDayCalloutView.m
 
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


#import "DSLCalendarDayCalloutView.h"


@interface DSLCalendarDayCalloutView ()

@property (nonatomic, strong) UIImageView *imageView;
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
    if (self.imageView == nil) {
        UIImage *calloutImage = [UIImage imageNamed:@"DSLCalendarDayCallout"];

        self.imageView = [[UIImageView alloc] initWithImage:[calloutImage resizableImageWithCapInsets:UIEdgeInsetsMake(14.0, 36.0, 60.0, 36.0)]];
        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.imageView.frame = self.bounds;
        [self insertSubview:self.imageView atIndex:0];
    }
    
    self.titleLabel.text = [NSString stringWithFormat:@"%d", day.day];

    CGFloat const imagePadding = 15.0;
    CGRect frame = self.frame;
    frame.origin.x -= imagePadding;
    frame.size.width += 2 * imagePadding;
    
    CGFloat const imageHeight = 99.0;
    if (frame.size.height < imageHeight) {
        frame.origin.y -= imageHeight - frame.size.height;
        frame.size.height = imageHeight;
    }
    
    self.frame = frame;
}

@end
