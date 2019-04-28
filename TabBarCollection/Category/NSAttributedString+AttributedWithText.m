//
//  NSAttributedString+AttributedWithText.m
//  project-newApp
//
//  Created by 金槌IOS开发 on 15/7/15.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "NSAttributedString+AttributedWithText.h"

@implementation NSAttributedString (AttributedWithText)

/**
 默认key用右边的设置
 */
+ (NSAttributedString *)na_attributedText:(NSString *)string
                                  keyword:(NSString *)key
                                leftColor:(UIColor *)leftColor
                               rightColor:(UIColor *)rightColor {
    return [self na_attributedText:string
                           keyword:key
                         leftColor:leftColor
                        rightColor:rightColor
                          leftFont:[UIFont systemFontOfSize:15]
                         rightFont:[UIFont systemFontOfSize:15]
                          isInLeft:NO];
}

/**
 *  isIn 是否包括key 左边
 */
+ (NSAttributedString *)na_attributedText:(NSString *)string
                                  keyword:(NSString *)key
                                leftColor:(UIColor *)leftColor
                               rightColor:(UIColor *)rightColor
                                 leftFont:(UIFont *)leftFont
                                rightFont:(UIFont *)rightFont
                                 isInLeft:(BOOL)isInLeft {
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:string];

    NSDictionary *attributeL = @{NSFontAttributeName:leftFont,
                                 NSForegroundColorAttributeName:leftColor};
    NSDictionary *attributeR = @{NSFontAttributeName:rightFont,
                                 NSForegroundColorAttributeName:rightColor};
    
    NSRange rangeK = [string rangeOfString:key];
    NSUInteger location = rangeK.location;
    
    if (location==NSNotFound) {
        //left
        NSRange lRange = NSMakeRange(0, 0);
        [result setAttributes:attributeL range:lRange];
        
        //right
        NSRange rRange = NSMakeRange(0, string.length);
        [result setAttributes:attributeR range:rRange];
        
    } else {
        //left
        NSRange lRange = NSMakeRange(0, location+(isInLeft?1:0));
        [result setAttributes:attributeL range:lRange];
        
        //right
        NSRange rRange = NSMakeRange(location+(isInLeft?1:0), string.length-(location+(isInLeft?1:0)));
        [result setAttributes:attributeR range:rRange];
    }

    // 返回已经设置好了的带有样式的文字
    return [[NSAttributedString alloc] initWithAttributedString:result];
}

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
                               rangeColor:(UIColor *)rangeColor {
    return [self na_attributedText:string fontSize:fontSize color:color key1:key1 key2:key2 rangeFontSize:rangeFontSize rangeColor:rangeColor isOpen:NO];
}

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
                                   isOpen:(BOOL)isOpen {
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSDictionary *attributeStr = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],
                                   NSForegroundColorAttributeName:color};
    NSDictionary *attributeRange = @{NSFontAttributeName:[UIFont systemFontOfSize:rangeFontSize],
                                     NSForegroundColorAttributeName:rangeColor};
    
    NSUInteger location1, location2;
    NSRange range1, range2;
    
    //
    range1 = [string rangeOfString:key1];
    range2 = [string rangeOfString:key2];
    
    location1 = range1.location;
    location2 = range2.location;
    
    //整个str设置颜色 字体
    NSRange allRange = NSMakeRange(0, string.length);
    [result setAttributes:attributeStr range:allRange];
    
    //范围内的str设置颜色 字体
    NSRange rangeRange;
    
    if (range1.location==NSNotFound) {
        location1 = 0;
    } else {
        location1 += (isOpen?0:1);
    }
    
    if (location2==NSNotFound) {
        location2 = string.length;
    } else {
        location2 += (isOpen?1:0);
    }
    
    rangeRange.location = location1;
    rangeRange.length = ABS(location2-location1);
    
    [result setAttributes:attributeRange range:rangeRange];
    
    // 返回已经设置好了的带有样式的文字
    return [[NSAttributedString alloc] initWithAttributedString:result];
}

@end
