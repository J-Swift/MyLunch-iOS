//
//  MYLSelectPhotosViewController.m
//  MyLunch
//
//  Created by James Reichley on 2/25/15.
//  Copyright (c) 2015 RadReichley. All rights reserved.
//

#import "MYLSelectPhotosViewController.h"

#import "MYLDetailViewController.h"


static const CGFloat kViewMargin = 10.0f;
static const CGFloat kSectionVSpacer = 20.0f;
static const CGFloat kItemVSpacer = 5.0f;


@interface MYLSelectPhotosViewController ()

@property (nonatomic, weak) UILabel *instructionLabel;

@end


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
  UIView *view = [UIView new];
  view.backgroundColor = [UIColor whiteColor];
  
  UILabel *instructionLabel = [UILabel new];
  instructionLabel.text = @"Add photos to your lunch (optional)";
  instructionLabel.numberOfLines = 0;
  [view addSubview:instructionLabel];
  _instructionLabel = instructionLabel;
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                         target:self
                                                                                         action:@selector(donePressed)];
  self.view = view;
}

- (void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];
  
  CGRect bounds = self.view.bounds;
  CGFloat width = CGRectGetWidth(bounds) - 2*kViewMargin;
  
  CGRect frame = self.instructionLabel.frame;
  frame.size = [self.instructionLabel sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
  frame.origin = CGPointMake(kViewMargin, kViewMargin);
  self.instructionLabel.frame = frame;
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
