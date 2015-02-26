//
//  MYLLunchModel.h
//  MyLunch
//
//  Created by James Reichley on 2/25/15.
//  Copyright (c) 2015 RadReichley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYLLunchModel : NSObject

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *foodDescription;
@property (nonatomic, copy, readonly) NSArray *images; // UIImage


- (instancetype)initWithName:(NSString *)name foodDescription:(NSString *)foodDescription NS_DESIGNATED_INITIALIZER;

- (BOOL)associateImages:(NSArray *)images; // UIImage

@end
