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
    _photos = [NSArray array];
  }
  
  return self;
}

- (BOOL)associatePhotos:(NSArray *)photos
{
  BOOL result = NO;
  
  if ( photos )
  {
    _photos = photos;
    result = YES;
  }
  
  return result;
}

@end
