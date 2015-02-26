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
  if ( self = [super init] )
  {
    _name = [name myl_trim];
    _foodDescription = [foodDescription myl_trim];
    
    NSParameterAssert([_name length] && [_foodDescription length]);
  }
  
  return self;
}

- (BOOL)associateImages:(NSArray *)images
{
  BOOL result = NO;
  
  // TODO(jpr): set self.images
  
  return result;
}

@end
