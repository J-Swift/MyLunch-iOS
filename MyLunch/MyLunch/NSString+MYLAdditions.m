//
//  NSString+MYLAdditions.m
//  MyLunch
//
//  Created by James Reichley on 2/25/15.
//  Copyright (c) 2015 RadReichley. All rights reserved.
//

#import "NSString+MYLAdditions.h"

@implementation NSString (MYLAdditions)

- (NSString *)myl_trim
{
  return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
