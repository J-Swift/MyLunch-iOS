//
//  MYLDetailViewController.h
//  MyLunch
//
//  Created by James Reichley on 2/25/15.
//  Copyright (c) 2015 RadReichley. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYLLunchModel;

@interface MYLDetailViewController : UIViewController

@property (nonatomic, strong, readonly) MYLLunchModel *model;

- (instancetype)initWithLunchModel:(MYLLunchModel *)model;

@end
