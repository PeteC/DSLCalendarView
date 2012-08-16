//
//  DSLCalenderDayCalloutView.m
//  DSLCalendarViewExample
//
//  Created by Pete Callaway on 16/08/2012.
//  Copyright 2012 Pete Callaway. All rights reserved.
//

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
