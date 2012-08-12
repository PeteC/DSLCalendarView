//
//  ViewController.m
//  DelMe
//
//  Created by Pete Callaway on 07/08/2012.
//  Copyright (c) 2012 Pete Callaway. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIView *calendarView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)didTapTest:(id)sender {
    [self.calendarView removeFromSuperview];
    self.calendarView = nil;
}


//- (void)viewDidAppear:(BOOL)animated {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//        
//        NSDate *startTime = [NSDate date];
//        __block NSInteger itemCount = 0;
//        
//        [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//            if (group != nil) {
//                NSNumber *type = [group valueForProperty:ALAssetsGroupPropertyType];
//                switch ((ALAssetsGroupType)type.integerValue) {
//                    case ALAssetsGroupAll:
//                        NSLog(@"All");
//                        break;
//                        
//                    case ALAssetsGroupAlbum:
//                        NSLog(@"Album");
//                        break;
//                        
//                    case ALAssetsGroupEvent:
//                        NSLog(@"Event");
//                        break;
//                        
//                    case ALAssetsGroupFaces:
//                        NSLog(@"Faces");
//                        break;
//                        
//                    case ALAssetsGroupLibrary:
//                        NSLog(@"Library");
//                        break;
//                        
//                    case ALAssetsGroupPhotoStream:
//                        NSLog(@"Stream");
//                        break;
//                }
//                
//                [group setAssetsFilter:[ALAssetsFilter allPhotos]];
//                
//                [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop) {
//                    NSDate *dateTaken = [asset valueForProperty:ALAssetPropertyDate];
//                    dateTaken = nil;
//                }];
//
//                itemCount += [group numberOfAssets];
//            }
//            else {
//                NSLog(@"%d items in %.3f seconds", itemCount, -[startTime timeIntervalSinceNow]);
//            }
//        } failureBlock:^(NSError *error) {
//            NSLog(@"%@", error);
//        }];
//    });
//}

@end
