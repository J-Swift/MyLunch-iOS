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
  CGFloat width = CGRectGetWidth(bounds) - 2*[MYLStyleHelper viewHMargin];
  
  
  CGRect frame = self.nameLabel.frame;
  frame.size = [self.nameLabel sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
  frame.origin = CGPointMake([MYLStyleHelper viewHMargin], [MYLStyleHelper viewVMargin]);
  self.nameLabel.frame = frame;
  
  frame = self.nameInput.frame;
  frame.size = CGSizeMake(width, self.nameInput.font.lineHeight + 10);
  frame.origin = CGPointMake([MYLStyleHelper viewHMargin],
                             CGRectGetMaxY(self.nameLabel.frame) + [MYLStyleHelper itemVSpacer]);
  self.nameInput.frame = frame;
  
  
  frame = self.descriptionLabel.frame;
  frame.size = [self.descriptionLabel sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
  frame.origin = CGPointMake([MYLStyleHelper viewHMargin],
                             CGRectGetMaxY(self.nameInput.frame) + [MYLStyleHelper sectionVSpacer]);
  self.descriptionLabel.frame = frame;
  
  frame = self.descriptionInput.frame;
  frame.size = CGSizeMake(width, 220);
  frame.origin = CGPointMake([MYLStyleHelper viewHMargin],
                             CGRectGetMaxY(self.descriptionLabel.frame) + [MYLStyleHelper itemVSpacer]);
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
  
  MYLLunchModel *model = [[MYLLunchModel alloc] initWithName:self.nameInput.text
                                             foodDescription:self.descriptionInput.text];
  if ( !model )
  {
    // TODO(jpr): popup alert
    return;
  }
  
  UIViewController *vc = [[MYLSelectPhotosViewController alloc] initWithLunchModel:model];
  [self.navigationController pushViewController:vc animated:YES];
}

@end
