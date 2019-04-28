//
//  UIImage+Addition.h
//  Living
//
//  Created by 戴杨杨 on 2018/9/4.
//  Copyright © 2018年 sx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Addition)

- (UIImage *)originImageScaleToSize:(CGSize)size;

/**
  颜色转换为图片
 */
+ (UIImage *)imageWithColor:(UIColor*)color;

/**
 view转换为图片
 */
+ (UIImage *)convertViewToImage:(UIView*)v;

/**
 *  更改图片颜色
 */
- (UIImage *)imageChangeColor:(UIColor *)color;

@end
