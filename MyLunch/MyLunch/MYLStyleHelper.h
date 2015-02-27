//
//  MYLStyleHelper.h
//  MyLunch
//
//  Created by James Reichley on 2/26/15.
//  Copyright (c) 2015 RadReichley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MYLStyleHelper : NSObject

// NOTE(jpr): window horizontal inset
+ (CGFloat)viewHMargin;
// NOTE(jpr): window vertical inset
+ (CGFloat)viewVMargin;

// NOTE(jpr): vertical space between UI sections
+ (CGFloat)sectionVSpacer;

// NOTE(jpr): vertical space between UI elements within a section
+ (CGFloat)itemVSpacer;

@end
