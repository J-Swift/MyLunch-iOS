//
//  MYLSelectPhotosViewController.m
//  MyLunch
//
//  Created by James Reichley on 2/25/15.
//  Copyright (c) 2015 RadReichley. All rights reserved.
//

#import "MYLSelectPhotosViewController.h"

#import "MYLDetailViewController.h"
#import "MYLLunchModel.h"

#import <ELCImagePickerController/ELCImagePickerController.h>


static const CGFloat kViewMargin = 10.0f;
static const CGFloat kSectionVSpacer = 20.0f;
static const CGFloat kItemVSpacer = 5.0f;


@interface MYLSelectPhotosViewController () <ELCImagePickerControllerDelegate>

@property (nonatomic, weak) UILabel *instructionLabel;
@property (nonatomic, weak) UILabel *debugLabel;

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
  instructionLabel.text = @"Tap to add photos to your lunch (optional)";
  instructionLabel.numberOfLines = 0;
  [view addSubview:instructionLabel];
  _instructionLabel = instructionLabel;
  
  UILabel *debugLabel = [UILabel new];
  debugLabel.text = @"";
  debugLabel.numberOfLines = 0;
  [view addSubview:debugLabel];
  _debugLabel = debugLabel;
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                         target:self
                                                                                         action:@selector(donePressed)];
  
  [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                     action:@selector(beginSelectingPhotos)]];
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
  
  self.debugLabel.text = [NSString stringWithFormat:@"%@ images", @([self.model.images count])];
  frame = self.debugLabel.frame;
  frame.size = [self.debugLabel sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
  frame.origin = CGPointMake(kViewMargin, CGRectGetMaxY(self.instructionLabel.frame) + kSectionVSpacer);
  self.debugLabel.frame = frame;
}

- (NSString *)title
{
  return @"Add Photos";
}

#pragma mark - ELCImagePickerControllerDelegate

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
  NSMutableArray *images = [NSMutableArray array];
  [info enumerateObjectsUsingBlock:^(NSDictionary *imageInfo, NSUInteger idx, BOOL *stop) {
    UIImage *image = imageInfo[@"UIImagePickerControllerOriginalImage"];
    [images addObject:image];
  }];
  [self.model associateImages:images];
  
  [self.view setNeedsLayout];
  [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
  [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Helpers

- (void)beginSelectingPhotos
{
  ELCImagePickerController *imagePickerVC = [ELCImagePickerController new];
  imagePickerVC.maximumImagesCount = 4;
  imagePickerVC.imagePickerDelegate = self;
  [self presentViewController:imagePickerVC animated:YES completion:NULL];
}

- (void)donePressed
{
  // TODO(jpr): error handling
  UIViewController *vc = [[MYLDetailViewController alloc] initWithLunchModel:self.model];
  [self.navigationController pushViewController:vc animated:YES];
}

@end
