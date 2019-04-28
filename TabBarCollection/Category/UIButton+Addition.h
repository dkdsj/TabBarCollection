//
//  UIButton+Addition.h
//  
//
//  Created by 韩保玉 on 15/6/28.
//  Copyright (c) 2015年 韩保玉. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ButtonEdgeInsetsStyle) {
    ButtonEdgeInsetsStyleImageOnLeft,
    ButtonEdgeInsetsStyleImageOnRight,
    ButtonEdgeInsetsStyleImageOnTop,
    ButtonEdgeInsetsStyleImageOnBottom
};

typedef NS_ENUM(NSUInteger, TextImageStyle) {
    TextImageStyleImageLeftTextRight,
    TextImageStyleImageRightTextLeft
};

@interface UIButton (Addition) 

/**
 @param style 图片在左(右)文字在右(左)
 */
- (void)btnTextLeftOrRight:(TextImageStyle)style inset:(CGFloat)inset;

/**
 @param style 图片在左右/上下
 @param space space
 */
- (void)btnLayoutEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style imageTitlespace:(CGFloat)space;

/**
 @param style 图片在左右/上下
 */
- (void)btnLayoutEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style;

/**
图片在上
 */
- (void)btnLayoutEdgeInsetsStyleDefault;



//
- (void)addAction:(void(^)(NSInteger tag))block;

- (void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets;


/**
 btn 设置title后计算宽度 inset:img与title的间距
 */
- (CGFloat)na_widthFortitle:(NSString *)title imageW:(CGFloat)imgW inset:(NSInteger)inset;
/**
 btn 设置title后计算宽度 inset:img与title的间距
 */
- (CGFloat)na_widthWithInset:(NSInteger)inset imageW:(CGFloat)imgW;


@end
