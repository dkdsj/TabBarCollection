//
//  UIView+Addition.m
//  BearShop
//
//  Created by zz on 2019/2/28.
//  Copyright © 2019 zz. All rights reserved.
//

#import "UIView+Addition.h"
#import <objc/runtime.h>

@implementation UIView (Addition)

/**
 view圆角
 */
- (void)na_viewCornerRadius:(CGFloat)cornerRadius {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    maskLayer.frame = self.bounds;
    self.layer.mask = maskLayer;
}

/**
 view圆角
 @param round UIRectCornerAllCorners
 */
- (void)na_viewCornerRadius:(CGFloat)cornerRadius round:(NSInteger)round {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:round cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = maskPath.CGPath;
    maskLayer.frame = self.bounds;
    self.layer.mask = maskLayer;
}

/*
 周边加阴影，并且同时圆角
 */
- (void)na_viewAddShadowDefaultCornerRadius:(CGFloat)cornerRadius {
    [self na_viewAddShadowOpacity:.5 shadowRadius:3 andCornerRadius:cornerRadius];
}

/*
 周边加阴影，并且同时圆角
 */
- (void)na_viewAddShadowOpacity:(float)shadowOpacity
                   shadowRadius:(CGFloat)shadowRadius
                andCornerRadius:(CGFloat)cornerRadius {
    //////// shadow /////////
    CALayer *shadowLayer = [CALayer layer];
    shadowLayer.frame = self.layer.frame;
    
    shadowLayer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
    shadowLayer.shadowOffset = CGSizeMake(0, 0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    shadowLayer.shadowOpacity = shadowOpacity;//0.8;//阴影透明度，默认0
    shadowLayer.shadowRadius = shadowRadius;//8;//阴影半径，默认3
    
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float width = shadowLayer.bounds.size.width;
    float height = shadowLayer.bounds.size.height;
    float x = shadowLayer.bounds.origin.x;
    float y = shadowLayer.bounds.origin.y;
    
    CGPoint topLeft      = shadowLayer.bounds.origin;
    CGPoint topRight     = CGPointMake(x + width, y);
    CGPoint bottomRight  = CGPointMake(x + width, y + height);
    CGPoint bottomLeft   = CGPointMake(x, y + height);
    
    CGFloat offset = -1.f;
    [path moveToPoint:CGPointMake(topLeft.x - offset, topLeft.y + cornerRadius)];
    [path addArcWithCenter:CGPointMake(topLeft.x + cornerRadius, topLeft.y + cornerRadius) radius:(cornerRadius + offset) startAngle:M_PI endAngle:M_PI_2 * 3 clockwise:YES];
    [path addLineToPoint:CGPointMake(topRight.x - cornerRadius, topRight.y - offset)];
    [path addArcWithCenter:CGPointMake(topRight.x - cornerRadius, topRight.y + cornerRadius) radius:(cornerRadius + offset) startAngle:M_PI_2 * 3 endAngle:M_PI * 2 clockwise:YES];
    [path addLineToPoint:CGPointMake(bottomRight.x + offset, bottomRight.y - cornerRadius)];
    [path addArcWithCenter:CGPointMake(bottomRight.x - cornerRadius, bottomRight.y - cornerRadius) radius:(cornerRadius + offset) startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [path addLineToPoint:CGPointMake(bottomLeft.x + cornerRadius, bottomLeft.y + offset)];
    [path addArcWithCenter:CGPointMake(bottomLeft.x + cornerRadius, bottomLeft.y - cornerRadius) radius:(cornerRadius + offset) startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    [path addLineToPoint:CGPointMake(topLeft.x - offset, topLeft.y + cornerRadius)];
    
    //设置阴影路径
    shadowLayer.shadowPath = path.CGPath;
    
    //////// cornerRadius /////////
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    [self.superview.layer insertSublayer:shadowLayer below:self.layer];
}

/**
 hRadio:弧线的高度 圆弧向上 默认向下
 */
- (void)na_viewUpBottonRadioHeight:(CGFloat)hRadio {
    [self na_viewUpBottonRadioHeight:hRadio locationUp:NO fillColor:kColorCustom];
}

- (void)na_viewUpBottonRadioHeight:(CGFloat)hRadio locationUp:(BOOL)locationUp fillColor:(UIColor *)fillColor {
    [self na_viewRemoveLayers];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    
    if (locationUp) {
        [bezier moveToPoint:CGPointMake(0, hRadio)];
        [bezier addLineToPoint:CGPointMake(0, self.height)];
        [bezier addLineToPoint:CGPointMake(self.width, self.height)];
        [bezier addLineToPoint:CGPointMake(self.width, hRadio)];
        [bezier addQuadCurveToPoint:CGPointMake(0, hRadio) controlPoint:CGPointMake(self.width/2, -hRadio)];
    } else {
        [bezier moveToPoint:CGPointMake(0, self.height - hRadio)];
        [bezier addLineToPoint:CGPointMake(0, 0)];
        [bezier addLineToPoint:CGPointMake(self.width, 0)];
        [bezier addLineToPoint:CGPointMake(self.width, self.height - hRadio)];
        [bezier addQuadCurveToPoint:CGPointMake(0, self.height - hRadio) controlPoint:CGPointMake(self.width/2, self.height+hRadio)];
    }
    
    layer.path = bezier.CGPath;
    layer.fillColor = fillColor.CGColor;
    
    self.backgroundColor = kColorBg;
    [self.layer addSublayer:layer];
}

- (void)na_viewRemoveLayers {
    NSArray<CALayer *> *subLayers = self.layer.sublayers;
    NSArray<CAShapeLayer *> *removedLayers = (NSArray<CAShapeLayer *> *)[subLayers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isKindOfClass:[CAShapeLayer class]];
    }]];
    
    [removedLayers enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull layer, NSUInteger idx, BOOL * _Nonnull stop) {
        [layer removeFromSuperlayer];
    }];
}

- (void)na_viewAdjustLayerColor:(UIColor *)color {
    NSArray<CALayer *> *subLayers = self.layer.sublayers;
    NSArray<CAShapeLayer *> *removedLayers = (NSArray<CAShapeLayer *> *)[subLayers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isKindOfClass:[CAShapeLayer class]];
    }]];
    
    [removedLayers enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull layer, NSUInteger idx, BOOL * _Nonnull stop) {
        //[layer removeFromSuperlayer];
        layer.fillColor = color.CGColor;
    }];
}

#pragma mark - 渐变色
+ (Class)layerClass {
    return [CAGradientLayer class];
}

+ (UIView *)na_gradientViewWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    UIView *view = [[self alloc] init];
    [view na_setGradientBackgroundWithColors:colors locations:locations startPoint:startPoint endPoint:endPoint];
    return view;
}

- (void)na_setGradientBackgroundWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    NSMutableArray *colorsM = [NSMutableArray array];
    for (UIColor *color in colors) {
        [colorsM addObject:(__bridge id)color.CGColor];
    }
    self.na_colors = [colorsM copy];
    self.na_locations = locations;
    self.na_endPoint = endPoint;
    self.na_startPoint = startPoint;
}

#pragma mark- Getter&Setter

- (NSArray *)na_colors {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setNa_colors:(NSArray *)colors {
    objc_setAssociatedObject(self, @selector(na_colors), colors, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setColors:self.na_colors];
    }
}

- (NSArray<NSNumber *> *)na_locations {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setNa_locations:(NSArray<NSNumber *> *)locations {
    objc_setAssociatedObject(self, @selector(na_locations), locations, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setLocations:self.na_locations];
    }
}

- (CGPoint)na_startPoint {
    return [objc_getAssociatedObject(self, _cmd) CGPointValue];
}

- (void)setNa_startPoint:(CGPoint)startPoint {
    objc_setAssociatedObject(self, @selector(na_startPoint), [NSValue valueWithCGPoint:startPoint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setStartPoint:self.na_startPoint];
    }
}

- (CGPoint)na_endPoint {
    return [objc_getAssociatedObject(self, _cmd) CGPointValue];
}

- (void)setNa_endPoint:(CGPoint)endPoint {
    objc_setAssociatedObject(self, @selector(na_endPoint), [NSValue valueWithCGPoint:endPoint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setEndPoint:self.na_endPoint];
    }
}

- (UIView *)na_subViewOfClassName:(NSString *)className {
    for (UIView *subView in self.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
        }
        
        UIView* resultFound = [subView na_subViewOfClassName:className];
        if (resultFound) {
            return resultFound;
        }
    }
    return nil;
}

@end

@implementation UILabel (AZGradient)

+ (Class)layerClass {
    return [CAGradientLayer class];
}

@end
