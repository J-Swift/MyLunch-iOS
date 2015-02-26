//
//  MYLDetailViewController.m
//  MyLunch
//
//  Created by James Reichley on 2/25/15.
//  Copyright (c) 2015 RadReichley. All rights reserved.
//

#import "MYLDetailViewController.h"

#import "MYLSelectedPhotosViewController.h"
#import "MYLLunchModel.h"


static const CGFloat kViewMargin = 10.0f;
static const CGFloat kSectionVSpacer = 20.0f;


@interface MYLDetailViewController ()

@property (nonatomic, strong) MYLSelectedPhotosViewController *selectedPhotosVC;

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *descriptionLabel;

@end


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
  self.view = [UIView new];
  self.view.backgroundColor = [UIColor whiteColor];
  
  UILabel *nameLabel = [UILabel new];
  nameLabel.text = self.model.name;
  nameLabel.numberOfLines = 0;
  [self.view addSubview:nameLabel];
  _nameLabel = nameLabel;
  
  UILabel *descriptionLabel = [UILabel new];
  descriptionLabel.text = self.model.foodDescription;
  descriptionLabel.numberOfLines = 0;
  [self.view addSubview:descriptionLabel];
  _descriptionLabel = descriptionLabel;
  
  self.selectedPhotosVC = [[MYLSelectedPhotosViewController alloc] initWithPhotos:self.model.photos];
  [self addChildViewController:self.selectedPhotosVC];
  [self.view addSubview:self.selectedPhotosVC.view];
  [self.selectedPhotosVC didMoveToParentViewController:self];
}

- (void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];
  
  CGRect bounds = self.view.bounds;
  CGFloat width = CGRectGetWidth(bounds) - 2*kViewMargin;
  
  
  CGRect frame = self.nameLabel.frame;
  frame.size = [self.nameLabel sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
  frame.origin = CGPointMake(kViewMargin, kViewMargin);
  self.nameLabel.frame = frame;
  
  frame = self.selectedPhotosVC.view.frame;
  frame.size = [self.selectedPhotosVC.view sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
  frame.origin = CGPointMake(kViewMargin, CGRectGetMaxY(self.nameLabel.frame) + kViewMargin);
  self.selectedPhotosVC.view.frame = frame;
  
  frame = self.descriptionLabel.frame;
  frame.size = [self.descriptionLabel sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
  frame.origin = CGPointMake(kViewMargin,
                             CGRectGetMaxY(self.selectedPhotosVC.view.frame) + kSectionVSpacer);
  self.descriptionLabel.frame = frame;
}

- (NSString *)title
{
  return @"My Lunch";
}

@end
