//
//  NSArray+Addition.m
//  pmb
//
//  Created by 金槌IOS开发 on 15/12/12.
//  Copyright © 2015年 zz. All rights reserved.
//

#import "NSArray+Addition.h"

@implementation NSArray (Addition)

/**
 *  数组去重复元素
 */
- (NSMutableArray *)arrayWithMemberIsOnly {
    NSMutableArray *categoryArray = [NSMutableArray array];
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![categoryArray containsObject:obj]) {
            [categoryArray addObject:obj];
        }
    }];
    
    return categoryArray;
}

@end
