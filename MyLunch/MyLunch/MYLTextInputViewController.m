//
//  MYLTextInputViewController
//  MyLunch
//
//  Created by James Reichley on 2/25/15.
//  Copyright (c) 2015 RadReichley. All rights reserved.
//

#import "MYLTextInputViewController.h"

#import "MYLSelectPhotosViewController.h"
#import "MYLLunchModel.h"


static const CGFloat kViewMargin = 10.0f;
static const CGFloat kSectionVSpacer = 20.0f;
static const CGFloat kItemVSpacer = 5.0f;


@interface MYLTextInputViewController ()

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UITextField *nameInput;

@property (nonatomic, weak) UILabel *descriptionLabel;
@property (nonatomic, weak) UITextView *descriptionInput;

@end


@implementation MYLTextInputViewController

- (void)loadView
{
  UIView *view = [UIView new];
  view.backgroundColor = [UIColor whiteColor];
  
  UILabel *nameLabel = [UILabel new];
  nameLabel.text = @"Name of Food I Ate for Lunch";
  nameLabel.numberOfLines = 0;
  [view addSubview:nameLabel];
  _nameLabel = nameLabel;
  
  // TODO(jpr): delegate methods
  UITextField *nameInput = [UITextField new];
  nameInput.borderStyle = UITextBorderStyleRoundedRect;
  [view addSubview:nameInput];
  _nameInput = nameInput;
  
  UILabel *descriptionLabel = [UILabel new];
  descriptionLabel.text = @"Description";
  descriptionLabel.numberOfLines = 0;
  [view addSubview:descriptionLabel];
  _descriptionLabel = descriptionLabel;
  
  // TODO(jpr): delegate methods
  UITextView *descriptionInput = [UITextView new];
  // NOTE(jpr): attempt mimic UITextField styling
  descriptionInput.layer.borderColor = [UIColor colorWithWhite:0.8275f alpha:1.0f].CGColor;
  descriptionInput.layer.borderWidth = 1.0f;
  descriptionInput.layer.cornerRadius = 5.0f;
  descriptionInput.font = nameInput.font;
  [view addSubview:descriptionInput];
  _descriptionInput = descriptionInput;
  
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
  
  
  CGRect frame = self.nameLabel.frame;
  frame.size = [self.nameLabel sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
  frame.origin = CGPointMake(kViewMargin, kViewMargin);
  self.nameLabel.frame = frame;
  
  frame = self.nameInput.frame;
  frame.size = CGSizeMake(width, self.nameInput.font.lineHeight + 10);
  frame.origin = CGPointMake(kViewMargin,
                             CGRectGetMaxY(self.nameLabel.frame) + kItemVSpacer);
  self.nameInput.frame = frame;
  
  
  frame = self.descriptionLabel.frame;
  frame.size = [self.descriptionLabel sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
  frame.origin = CGPointMake(kViewMargin,
                             CGRectGetMaxY(self.nameInput.frame) + kSectionVSpacer);
  self.descriptionLabel.frame = frame;
  
  frame = self.descriptionInput.frame;
  frame.size = CGSizeMake(width, 220);
  frame.origin = CGPointMake(kViewMargin,
                             CGRectGetMaxY(self.descriptionLabel.frame) + kItemVSpacer);
  self.descriptionInput.frame = frame;
}

- (NSString *)title
{
  return @"My Lunch";
}

#pragma mark - Helpers

- (void)donePressed
{
  [self.nameInput resignFirstResponder];
  [self.descriptionInput resignFirstResponder];
  
  // TODO(jpr): error handling
  MYLLunchModel *model = [[MYLLunchModel alloc] initWithName:self.nameInput.text
                                             foodDescription:self.descriptionInput.text];
  UIViewController *vc = [[MYLSelectPhotosViewController alloc] initWithLunchModel:model];
  [self.navigationController pushViewController:vc animated:YES];
}

@end
