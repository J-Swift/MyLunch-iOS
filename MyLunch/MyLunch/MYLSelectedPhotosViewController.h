//
//  MYLSelectedPhotosViewController.h
//  MyLunch
//
//  Created by James Reichley on 2/26/15.
//  Copyright (c) 2015 RadReichley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYLSelectedPhotosViewController : UIViewController

@property (nonatomic, copy) NSArray *photos;

- (instancetype)initWithPhotos:(NSArray *)photos; // UIImage

@end
