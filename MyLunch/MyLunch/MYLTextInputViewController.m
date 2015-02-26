//
//  MYLTextInputViewController
//  MyLunch
//
//  Created by James Reichley on 2/25/15.
//  Copyright (c) 2015 RadReichley. All rights reserved.
//

#import "MYLTextInputViewController.h"

#import "MYLSelectPhotosViewController.h"

@implementation MYLTextInputViewController

- (void)loadView
{
  UILabel *label = [UILabel new];
  label.text = @"Screen 1";
  label.textAlignment = NSTextAlignmentCenter;
  label.backgroundColor = [UIColor yellowColor];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                         target:self
                                                                                         action:@selector(donePressed)];
  self.view = label;
}

- (NSString *)title
{
  return @"My Lunch";
}

#pragma mark - Helpers

- (void)donePressed
{
  UIViewController *vc = [MYLSelectPhotosViewController new];
  [self.navigationController pushViewController:vc animated:YES];
}

@end
