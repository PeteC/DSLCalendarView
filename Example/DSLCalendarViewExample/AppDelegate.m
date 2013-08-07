//
//  AppDelegate.m
//  DSLCalendarViewExample
//
//  Created by Pete Callaway on 12/08/2012.
//  Copyright (c) 2012 Pete Callaway. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil]];
    
    [self.window makeKeyAndVisible];

    return YES;
}

@end
