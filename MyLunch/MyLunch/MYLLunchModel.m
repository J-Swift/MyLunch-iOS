//
//  MYLLunchModel.m
//  MyLunch
//
//  Created by James Reichley on 2/25/15.
//  Copyright (c) 2015 RadReichley. All rights reserved.
//

#import "MYLLunchModel.h"

@implementation MYLLunchModel

- (instancetype)init
{
  return [self initWithName:nil foodDescription:nil];
}

- (instancetype)initWithName:(NSString *)name foodDescription:(NSString *)foodDescription
{
  name = [name myl_trim];
  foodDescription = [foodDescription myl_trim];
  
  if ( ![name length] || ![foodDescription length] )
    return nil;
  
  if ( self = [super init] )
  {
    _name = name;
    _foodDescription = foodDescription;
    _images = [NSArray array];
  }
  
  return self;
}

- (BOOL)associateImages:(NSArray *)images
{
  BOOL result = NO;
  
  if ( images )
  {
    _images = images;
    result = YES;
  }
  
  return result;
}

@end
