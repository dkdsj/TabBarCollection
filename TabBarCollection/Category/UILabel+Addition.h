//
//  UILabel+Addition.h
//  GreenTomato
//
//  Created by liuxudong on 14-6-23.
//  Copyright (c) 2014年 Jan Lion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Addition)

/**
 *  UILable + NSString calc size with font
 */
- (CGSize)na_labelSizeOfNSString;

- (CGSize)boundingRectWithSize:(CGSize)limitSize;

- (CGSize)getSize;

/**
 *  行距
 */
- (void)lineSpace:(CGFloat)space;

/**
 *  行距 在设置text后调用
 */
- (void)lineSpace;

/**
 sizeThatFits
 
 1行：设置的参数的无效 返回最合适的size
 n行：设置的width有效 返回共n行 width下的size，多余n行的文字不显示height也不算在内
 */

- (CGSize)labelSizeFit:(CGSize)maxSize;

/**
 boundingRectWithSize 需要用ceil来调整size
 
 @param maxSize CGSizeMake(width, height) width/height某个=0 表示其不限制
 */
- (CGSize)labelBoundingRect:(CGSize)maxSize;

@end
