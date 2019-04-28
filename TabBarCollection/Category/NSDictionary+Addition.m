//
//  NSDictionary+Addition.m
//  GreenTomato
//
//  Created by dong on 14-5-27.
//  Copyright (c) 2014年 Jan Lion. All rights reserved.
//

#import "NSDictionary+Addition.h"

@implementation NSDictionary (Addition)

- (NSString *)safeForKey:(NSString *)keyName {
    if ([NSNull null] == [self objectForKey:keyName]) {
        return @"";
    }
    
    NSString *safeString = [self objectForKey:keyName]?[NSString stringWithFormat:@"%@", [self objectForKey:keyName]]:@"";
    return [NSString stringWithFormat:@"%@", safeString];
}

@end
