//
//  UIFont+Addition.m
//  BearShop
//
//  Created by zz on 2019/1/22.
//  Copyright © 2019 zz. All rights reserved.
//

#import "UIFont+Addition.h"
#import <objc/runtime.h>

@implementation UIFont (Addition)

#warning font need change
#if 0
+ (void)load {
    // 获取替换后的类方法
    Method newMethod = class_getClassMethod([self class], @selector(adjustFont:));
    // 获取替换前的类方法
    Method method = class_getClassMethod([self class], @selector(systemFontOfSize:));
    // 然后交换类方法，交换两个方法的IMP指针，(IMP代表了方法的具体的实现）
    method_exchangeImplementations(newMethod, method);
    
    //bold
    // 获取替换后的类方法
    Method boldNMethod = class_getClassMethod([self class], @selector(adjustFontBold:));
    // 获取替换前的类方法
    Method boldmethod = class_getClassMethod([self class], @selector(boldSystemFontOfSize:));
    // 然后交换类方法，交换两个方法的IMP指针，(IMP代表了方法的具体的实现）
    method_exchangeImplementations(boldNMethod, boldmethod);
}

+ (UIFont *)adjustFont:(CGFloat)fontSize {
    UIFont *newFont = nil;
    newFont = [UIFont adjustFont:fontSize * [UIScreen mainScreen].bounds.size.width/375.0];
    return newFont;
}

//https://www.jianshu.com/p/7a6106f952d3

+ (UIFont *)adjustFontBold:(CGFloat)fontSize {
    UIFont *newFont = nil;
    newFont = [UIFont adjustFontBold:fontSize * [UIScreen mainScreen].bounds.size.width/375.0];
    return newFont;
}
#endif

@end
