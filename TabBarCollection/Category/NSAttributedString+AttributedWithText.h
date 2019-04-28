//
//  NSAttributedString+AttributedWithText.h
//  project-newApp
//
//  Created by 金槌IOS开发 on 15/7/15.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (AttributedWithText)

/**
 默认key用右边的设置
 */
+ (NSAttributedString *)na_attributedText:(NSString *)string
                                  keyword:(NSString *)key
                                leftColor:(UIColor *)leftColor
                               rightColor:(UIColor *)rightColor;

/**
 *  isIn 左边是否包括key
 */
+ (NSAttributedString *)na_attributedText:(NSString *)string
                                  keyword:(NSString *)key
                                leftColor:(UIColor *)leftColor
                               rightColor:(UIColor *)rightColor
                                 leftFont:(UIFont *)leftFont
                                rightFont:(UIFont *)rightFont
                                 isInLeft:(BOOL)isInLeft;

/**
 开区间
 rangeFontSize rangeColor 区间内的字体颜色
 fontSize color 整个str的字体颜色
 */
+ (NSAttributedString *)na_attributedText:(NSString *)string
                                 fontSize:(CGFloat)fontSize
                                    color:(UIColor *)color
                                     key1:(NSString *)key1
                                     key2:(NSString *)key2
                            rangeFontSize:(CGFloat)rangeFontSize
                               rangeColor:(UIColor *)rangeColor;
/**
 rangeFontSize rangeColor 区间内的字体颜色
 fontSize color 整个str的字体颜色
 isOpen:YES开区间 key不包括
        NO闭区间 key包括
 */
+ (NSAttributedString *)na_attributedText:(NSString *)string
                                 fontSize:(CGFloat)fontSize
                                    color:(UIColor *)color
                                     key1:(NSString *)key1
                                     key2:(NSString *)key2
                            rangeFontSize:(CGFloat)rangeFontSize
                               rangeColor:(UIColor *)rangeColor
                                   isOpen:(BOOL)isOpen;

@end
