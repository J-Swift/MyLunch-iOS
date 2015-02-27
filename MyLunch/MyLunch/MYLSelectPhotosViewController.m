//
//  MYLSelectPhotosViewController.m
//  MyLunch
//
//  Created by James Reichley on 2/25/15.
//  Copyright (c) 2015 RadReichley. All rights reserved.
//

#import "MYLSelectPhotosViewController.h"

#import "MYLSelectedPhotosViewController.h"
#import "MYLDetailViewController.h"
#import "MYLLunchModel.h"

#import <ELCImagePickerController/ELCImagePickerController.h>


@interface MYLSelectPhotosViewController () <ELCImagePickerControllerDelegate>

@property (nonatomic, strong) MYLSelectedPhotosViewController *selectedPhotosVC;

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
  self.view = view;
  view.backgroundColor = [UIColor whiteColor];
  
  UITapGestureRecognizer *onTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(beginSelectingPhotos)];
  [view addGestureRecognizer:onTap];
  
  UILabel *instructionLabel = [UILabel new];
  instructionLabel.text = @"Tap here to add photos to your lunch (optional)";
  instructionLabel.numberOfLines = 0;
  [view addSubview:instructionLabel];
  _instructionLabel = instructionLabel;
  
  self.selectedPhotosVC = [[MYLSelectedPhotosViewController alloc] initWithPhotos:self.model.photos];
  [self addChildViewController:self.selectedPhotosVC];
  [self.view addSubview:self.selectedPhotosVC.view];
  [self.selectedPhotosVC didMoveToParentViewController:self];
  
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Continue"
                                                           style:UIBarButtonItemStylePlain
                                                          target:self
                                                          action:@selector(continuePressed)];
  self.navigationItem.rightBarButtonItem = item;
}

- (void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];
  
  CGRect bounds = self.view.bounds;
  CGFloat width = CGRectGetWidth(bounds) - 2*[MYLStyleHelper viewHMargin];
  
  CGRect frame = self.instructionLabel.frame;
  frame.size = [self.instructionLabel sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
  frame.origin = CGPointMake([MYLStyleHelper viewHMargin], [MYLStyleHelper viewVMargin]);
  self.instructionLabel.frame = frame;
  
  frame = self.selectedPhotosVC.view.frame;
  frame.size = [self.selectedPhotosVC.view sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
  frame.origin = CGPointMake([MYLStyleHelper viewHMargin],
                             CGRectGetMaxY(self.instructionLabel.frame) + [MYLStyleHelper sectionVSpacer]);
  self.selectedPhotosVC.view.frame = frame;
}

- (NSString *)title
{
  return @"Add Photos";
}

#pragma mark - ELCImagePickerControllerDelegate

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
  NSMutableArray *photos = [NSMutableArray array];
  [info enumerateObjectsUsingBlock:^(NSDictionary *imageInfo, NSUInteger idx, BOOL *stop) {
    UIImage *photo = imageInfo[@"UIImagePickerControllerOriginalImage"];
    [photos addObject:photo];
  }];
  self.selectedPhotosVC.photos = photos;
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

- (void)continuePressed
{
  [self.model associatePhotos:self.selectedPhotosVC.photos];
  UIViewController *vc = [[MYLDetailViewController alloc] initWithLunchModel:self.model];
  [self.navigationController pushViewController:vc animated:YES];
}

@end
