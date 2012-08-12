//
//  CalenderMonthSelectorView
//  DelMe
//
//  Created by Pete Callaway on 09/08/2012.
//  Copyright 2012 Pete Callaway. All rights reserved.
//


@interface CalenderMonthSelectorView : UIView

@property (nonatomic, weak) IBOutlet UIButton *backButton;
@property (nonatomic, weak) IBOutlet UIButton *forwardButton;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) IBOutletCollection(UILabel) NSArray *dayLabels;

// Designated initialiser
+ (id)view;

@end
