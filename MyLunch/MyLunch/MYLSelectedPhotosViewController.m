//
//  MYLSelectedPhotosViewController.m
//  MyLunch
//
//  Created by James Reichley on 2/26/15.
//  Copyright (c) 2015 RadReichley. All rights reserved.
//

#import "MYLSelectedPhotosViewController.h"


static NSString * const kCellIdentifier = @"cell";
static const CGSize kCellSize = {165, 110};
static const NSUInteger kTargetNumberOfRowsDisplayed = 2;


#pragma mark = MYLSelectedPhotosView

@interface MYLSelectedPhotosView : UIView

@property (nonatomic, weak) UICollectionView *collectionView;

@end


@implementation MYLSelectedPhotosView

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
{
  if ( self = [super init] )
  {
    [self addSubview:collectionView];
    _collectionView = collectionView;
  }
  
  return self;
}

- (CGSize)sizeThatFits:(CGSize)size
{
  NSInteger numItems = [_collectionView numberOfItemsInSection:0];
  if ( !numItems )
    return CGSizeZero;
  
  UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
  
  CGFloat widthForCurrentNumberOfCells = kCellSize.width * numItems + (numItems - 1) * layout.minimumInteritemSpacing;
  
  CGFloat idealHeight = 0;
  
  if ( widthForCurrentNumberOfCells <= size.width )
  {
    // NOTE(jpr): tightly bound if we only have 1 row...
    idealHeight = kCellSize.height;
  }
  else
  {
    // NOTE(jpr): ... otherwise, bound to the required height for target number of rows
    CGFloat heightForTargetNumberOfRows = kCellSize.height * kTargetNumberOfRowsDisplayed + (kTargetNumberOfRowsDisplayed - 1) * layout.minimumLineSpacing;
    idealHeight = heightForTargetNumberOfRows;
  }
  
  idealHeight = MIN(size.height, idealHeight);
  return CGSizeMake(size.width, idealHeight);
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  self.collectionView.frame = self.bounds;
}

@end


#pragma mark = MYLSelectedPhotosViewController

@interface MYLSelectedPhotosViewController () <UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewController *collectionVC;

@end


@implementation MYLSelectedPhotosViewController

- (instancetype)initWithPhotos:(NSArray *)photos
{
  if ( self = [super init] )
  {
    _photos = photos;
  }
  
  return self;
}

- (void)loadView
{
  UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
  layout.scrollDirection = UICollectionViewScrollDirectionVertical;
  layout.itemSize = kCellSize;
  
  self.collectionVC = [[UICollectionViewController alloc] initWithCollectionViewLayout:layout];
  self.collectionVC.collectionView.backgroundColor = [UIColor clearColor];
  self.collectionVC.collectionView.allowsSelection = YES;
  self.collectionVC.collectionView.dataSource = self;
  [self.collectionVC.collectionView registerClass:[UICollectionViewCell class]
                       forCellWithReuseIdentifier:kCellIdentifier];
  MYLSelectedPhotosView *view = [[MYLSelectedPhotosView alloc] initWithCollectionView:self.collectionVC.collectionView];
  
  self.view = view;
}

- (void)setPhotos:(NSArray *)photos
{
  _photos = [photos mutableCopy];
  [self.collectionVC.collectionView reloadData];
  [self.view setNeedsLayout];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return [self.photos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  UIImage *photo = self.photos[indexPath.row];
  
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier
                                                                         forIndexPath:indexPath];
  UIImageView *iv = [[UIImageView alloc] initWithImage:photo];
  iv.contentMode = UIViewContentModeScaleAspectFill;
  iv.clipsToBounds = YES;
  cell.backgroundView = iv;
  
  return cell;
}

@end
