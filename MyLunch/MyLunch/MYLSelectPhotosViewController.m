//
//  MYLSelectPhotosViewController.m
//  MyLunch
//
//  Created by James Reichley on 2/25/15.
//  Copyright (c) 2015 RadReichley. All rights reserved.
//

#import "MYLSelectPhotosViewController.h"

#import "MYLDetailViewController.h"

@implementation MYLSelectPhotosViewController

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
  label.text = @"Screen 2";
  label.textAlignment = NSTextAlignmentCenter;
  label.backgroundColor = [UIColor greenColor];
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                         target:self
                                                                                         action:@selector(donePressed)];
  self.view = label;
}

- (NSString *)title
{
  return @"Add Photos";
}

#pragma mark - Helpers

- (void)donePressed
{
  // TODO(jpr): error handling
  UIViewController *vc = [[MYLDetailViewController alloc] initWithLunchModel:self.model];
  [self.navigationController pushViewController:vc animated:YES];
}

@end
