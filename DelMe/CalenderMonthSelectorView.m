//
//  CalenderMonthSelectorView
//  DelMe
//
//  Created by Pete Callaway on 09/08/2012.
//  Copyright 2012 Pete Callaway. All rights reserved.
//

#import "CalenderMonthSelectorView.h"


@interface CalenderMonthSelectorView ()

@end


@implementation CalenderMonthSelectorView


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


- (id)init {
    self = [super init];
    if (self != nil) {
        // Initialise properties
    }

    return self;
}

@end
