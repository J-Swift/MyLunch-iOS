//
//  MYLDetailViewController.m
//  MyLunch
//
//  Created by James Reichley on 2/25/15.
//  Copyright (c) 2015 RadReichley. All rights reserved.
//

#import "MYLDetailViewController.h"

@implementation MYLDetailViewController

- (void)loadView
{
  UILabel *label = [UILabel new];
  label.text = @"Screen 3";
  label.textAlignment = NSTextAlignmentCenter;
  label.backgroundColor = [UIColor blueColor];
  self.view = label;
}

- (NSString *)title
{
  return @"My Lunch";
}

@end
