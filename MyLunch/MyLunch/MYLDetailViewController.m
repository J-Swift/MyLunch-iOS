//
//  MYLDetailViewController.m
//  MyLunch
//
//  Created by James Reichley on 2/25/15.
//  Copyright (c) 2015 RadReichley. All rights reserved.
//

#import "MYLDetailViewController.h"

#import "MYLLunchModel.h"

@implementation MYLDetailViewController

- (instancetype)initWithLunchModel:(MYLLunchModel *)model
{
  if ( self = [super init] )
  {
    NSParameterAssert(model);
    _model = model;
  }
  
  return self;
}

- (void)loadView
{
  UILabel *label = [UILabel new];
  label.text = self.model.name;
  label.textAlignment = NSTextAlignmentCenter;
  label.backgroundColor = [UIColor blueColor];
  self.view = label;
}

- (NSString *)title
{
  return @"My Lunch";
}

@end
