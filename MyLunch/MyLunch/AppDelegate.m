//
//  AppDelegate.m
//  MyLunch
//
//  Created by James Reichley on 2/25/15.
//  Copyright (c) 2015 RadReichley. All rights reserved.
//

#import "AppDelegate.h"

#import "MYLTextInputViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  UIViewController *vc = [MYLTextInputViewController new];
  UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:vc];
  navVC.navigationBar.translucent = NO;
 
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.rootViewController = navVC;
  [self.window makeKeyAndVisible];
  
  return YES;
}

@end
