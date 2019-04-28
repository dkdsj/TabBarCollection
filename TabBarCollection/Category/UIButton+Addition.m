//
//  UIButton+Addition.m
//  
//
//  Created by 韩保玉 on 15/6/28.
//  Copyright (c) 2015年 韩保玉. All rights reserved.
//

#import "UIButton+Addition.h"
#import <objc/runtime.h>

static NSString *BlockAddrKey = @"ButtonBlockKey";

@interface UIButton ()

@property (nonatomic, copy) void(^block)(NSInteger tag);

@end

@implementation UIButton (Addition)

- (void)btnTextLeftOrRight:(TextImageStyle)style inset:(CGFloat)inset {
    //文字右对齐 图片左对齐
    if (style==TextImageStyleImageLeftTextRight) {
        //button文字的偏移量
        self.titleEdgeInsets = UIEdgeInsetsMake(0,  0, 0, -(self.frame.size.width - self.titleLabel.frame.origin.x -self.titleLabel.frame.size.width)+inset);
        //button图片的偏移量
        self.imageEdgeInsets = UIEdgeInsetsMake(0, -(self.imageView.frame.origin.x), 0, self.imageView.frame.origin.x);
    } else if (style==TextImageStyleImageRightTextLeft) {
        self.titleEdgeInsets = UIEdgeInsetsMake(0,  -(self.titleLabel.frame.origin.x+20), 0, 0);
        
        self.imageEdgeInsets = UIEdgeInsetsMake(0, (self.frame.size.width - self.imageView.frame.origin.x - self.imageView.frame.size.width+inset), 0, -(self.frame.size.width - self.imageView.frame.origin.x - self.imageView.frame.size.width+inset));
    }
}

/**
图片在上
 */
- (void)btnLayoutEdgeInsetsStyleDefault {
    [self btnLayoutEdgeInsetsStyle:ButtonEdgeInsetsStyleImageOnTop];
}

/**
 @param style 图片在左右/上下
 */
- (void)btnLayoutEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style {
    [self btnLayoutEdgeInsetsStyle:style imageTitlespace:5];
}

/**
 @param style 图片在左右/上下
 @param space space
 */
- (void)btnLayoutEdgeInsetsStyle:(ButtonEdgeInsetsStyle)style imageTitlespace:(CGFloat)space {
    CGFloat imageViewWidth = CGRectGetWidth(self.imageView.frame);
    CGFloat labelWidth = CGRectGetWidth(self.titleLabel.frame);
    
    if (labelWidth == 0) {
        CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
        labelWidth  = titleSize.width;
    }
    
    CGFloat imageInsetsTop = 0.0f;
    CGFloat imageInsetsLeft = 0.0f;
    CGFloat imageInsetsBottom = 0.0f;
    CGFloat imageInsetsRight = 0.0f;
    
    CGFloat titleInsetsTop = 0.0f;
    CGFloat titleInsetsLeft = 0.0f;
    CGFloat titleInsetsBottom = 0.0f;
    CGFloat titleInsetsRight = 0.0f;
    
    switch (style) {
        case ButtonEdgeInsetsStyleImageOnRight:
        {
            space = space * 0.5;

            imageInsetsLeft = labelWidth + space;
            imageInsetsRight = -imageInsetsLeft;
            
            titleInsetsLeft = - (imageViewWidth + space);
            titleInsetsRight = -titleInsetsLeft;
        }
            break;
            
        case ButtonEdgeInsetsStyleImageOnLeft:
        {
            space = space * 0.5;

            imageInsetsLeft = -space;
            imageInsetsRight = -imageInsetsLeft;
            
            titleInsetsLeft = space;
            titleInsetsRight = -titleInsetsLeft;
        }
            break;
        case ButtonEdgeInsetsStyleImageOnBottom:
        {
            CGFloat imageHeight = CGRectGetHeight(self.imageView.frame);
            CGFloat labelHeight = CGRectGetHeight(self.titleLabel.frame);
            CGFloat buttonHeight = CGRectGetHeight(self.frame);
            CGFloat boundsCentery = (imageHeight + space + labelHeight) * 0.5;
            
            CGFloat centerX_button = CGRectGetMidX(self.bounds); // bounds
            CGFloat centerX_titleLabel = CGRectGetMidX(self.titleLabel.frame);
            CGFloat centerX_image = CGRectGetMidX(self.imageView.frame);
            
            CGFloat imageBottomY = CGRectGetMaxY(self.imageView.frame);
            CGFloat titleTopY = CGRectGetMinY(self.titleLabel.frame);
            
            imageInsetsTop = buttonHeight - (buttonHeight * 0.5 - boundsCentery) - imageBottomY;
            imageInsetsLeft = centerX_button - centerX_image;
            imageInsetsRight = - imageInsetsLeft;
            imageInsetsBottom = - imageInsetsTop;
            
            titleInsetsTop = (buttonHeight * 0.5 - boundsCentery) - titleTopY;
            titleInsetsLeft = -(centerX_titleLabel - centerX_button);
            titleInsetsRight = - titleInsetsLeft;
            titleInsetsBottom = - titleInsetsTop;
            
        }
            break;
            case ButtonEdgeInsetsStyleImageOnTop:
        {
            CGFloat imageHeight = CGRectGetHeight(self.imageView.frame);
            CGFloat labelHeight = CGRectGetHeight(self.titleLabel.frame);
            CGFloat buttonHeight = CGRectGetHeight(self.frame);
            CGFloat boundsCentery = (imageHeight + space + labelHeight) * 0.5;
            
            CGFloat centerX_button = CGRectGetMidX(self.bounds); // bounds
            CGFloat centerX_titleLabel = CGRectGetMidX(self.titleLabel.frame);
            CGFloat centerX_image = CGRectGetMidX(self.imageView.frame);
            
            CGFloat imageTopY = CGRectGetMinY(self.imageView.frame);
            CGFloat titleBottom = CGRectGetMaxY(self.titleLabel.frame);
            
            imageInsetsTop = (buttonHeight * 0.5 - boundsCentery) - imageTopY;
            imageInsetsLeft = centerX_button - centerX_image;
            imageInsetsRight = - imageInsetsLeft;
            imageInsetsBottom = - imageInsetsTop;
            
            titleInsetsTop = buttonHeight - (buttonHeight * 0.5 - boundsCentery) - titleBottom;
            titleInsetsLeft = -(centerX_titleLabel - centerX_button);
            titleInsetsRight = - titleInsetsLeft;
            titleInsetsBottom = - titleInsetsTop;
        }
            break;
            
        default:
            break;
    }
    
    self.imageEdgeInsets = UIEdgeInsetsMake(imageInsetsTop, imageInsetsLeft, imageInsetsBottom, imageInsetsRight);
    self.titleEdgeInsets = UIEdgeInsetsMake(titleInsetsTop, titleInsetsLeft, titleInsetsBottom, titleInsetsRight);
}


- (void (^)(NSInteger))block {
    return objc_getAssociatedObject(self, &BlockAddrKey);
}

- (void)setBlock:(void (^)(NSInteger))block {
    objc_setAssociatedObject(self, &BlockAddrKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//1.0 block方式添加点击事件
- (void)addAction:(void(^)(NSInteger tag))block {
    
    self.block = block;
    [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonAction:(UIButton *)bt {
    self.block(bt.tag);
}

//--------------------------增加按钮的点击范围--------------------------------
static const NSString *KEY_HIT_TEST_EDGE_INSETS = @"HitTestEdgeInsets";

- (void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS);
    if(value) {
        UIEdgeInsets edgeInsets; [value getValue:&edgeInsets]; return edgeInsets;
    }else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if(UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero) ||       !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);
    
    return CGRectContainsPoint(hitFrame, point);
}

/**
 btn 设置title后计算宽度 inset:img与title的间距
 */
- (CGFloat)na_widthFortitle:(NSString *)title imageW:(CGFloat)imgW inset:(NSInteger)inset {
    return [title na_sizeOfNSStringWithFont:self.titleLabel.font].width+imgW+inset;
}

/**
 btn 设置title后计算宽度 inset:img与title的间距
 */
- (CGFloat)na_widthWithInset:(NSInteger)inset imageW:(CGFloat)imgW {
    return [self.titleLabel.text na_sizeOfNSStringWithFont:self.titleLabel.font].width+inset+imgW;
}

@end
