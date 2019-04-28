//
//  UIView+Addition.h
//  BearShop
//
//  Created by zz on 2019/2/28.
//  Copyright © 2019 zz. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

@interface UIView (Addition)

/**
 view圆角
 */
- (void)na_viewCornerRadius:(CGFloat)cornerRadius;

/**
 view圆角
 @param round UIRectCornerAllCorners
 */
- (void)na_viewCornerRadius:(CGFloat)cornerRadius round:(NSInteger)round;

/**
 周边加阴影，并且同时圆角
 */
- (void)na_viewAddShadowDefaultCornerRadius:(CGFloat)cornerRadius;

/*
 周边加阴影，并且同时圆角
 */
- (void)na_viewAddShadowOpacity:(float)shadowOpacity
                   shadowRadius:(CGFloat)shadowRadius
                andCornerRadius:(CGFloat)cornerRadius;

/**
 hRadio:弧线的高度
 up:圆弧向上 默认向下
 */
- (void)na_viewUpBottonRadioHeight:(CGFloat)hRadio;
/**
 hRadio:弧线的高度
 up:圆弧向上 默认向下
 */
- (void)na_viewUpBottonRadioHeight:(CGFloat)hRadio locationUp:(BOOL)locationUp fillColor:(UIColor *)fillColor;

- (void)na_viewAdjustLayerColor:(UIColor *)color;

#pragma mark - 渐变
@property(nullable, copy) NSArray *na_colors;

/* An optional array of NSNumber objects defining the location of each
 * gradient stop as a value in the range [0,1]. The values must be
 * monotonically increasing. If a nil array is given, the stops are
 * assumed to spread uniformly across the [0,1] range. When rendered,
 * the colors are mapped to the output colorspace before being
 * interpolated. Defaults to nil. Animatable. */

@property(nullable, copy) NSArray<NSNumber *> *na_locations;

/* The start and end points of the gradient when drawn into the layer's
 * coordinate space. The start point corresponds to the first gradient
 * stop, the end point to the last gradient stop. Both points are
 * defined in a unit coordinate space that is then mapped to the
 * layer's bounds rectangle when drawn. (I.e. [0,0] is the bottom-left
 * corner of the layer, [1,1] is the top-right corner.) The default values
 * are [.5,0] and [.5,1] respectively. Both are animatable. */

@property CGPoint na_startPoint;
@property CGPoint na_endPoint;

/**
 渐变
 https://www.jianshu.com/p/e7c9e94e165b
 */
+ (UIView *_Nullable)na_gradientViewWithColors:(NSArray<UIColor *> *_Nullable)colors locations:(NSArray<NSNumber *> *_Nullable)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;
/**
 渐变
 https://www.jianshu.com/p/e7c9e94e165b
 
 //从左-右 颜色从A-B渐变
 [lbName na_setGradientBackgroundWithColors:@[A, B] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
 
 //从⬆️-⬇️ 颜色从B-A渐变
 [lbName2 na_setGradientBackgroundWithColors:@[B, A] locations:nil startPoint:CGPointMake(0, 1) endPoint:CGPointMake(0, 0)];
 */
- (void)na_setGradientBackgroundWithColors:(NSArray<UIColor *> *_Nullable)colors locations:(NSArray<NSNumber *> *_Nullable)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/**
 在我们日常开发中，经常会遇到一些需求非要把 UISearchBar 默认的圆角矩形的圆角改大，顶端改成圆形的。虽然系统没有提供这个 API，不过还是有一个简单方法可以解决。
 UIView *backgroundView = [searchBar na_subViewOfClassName:@"_UISearchBarSearchFieldBackgroundView"];
 backgroundView.layer.cornerRadius = 15.0f;
 backgroundView.clipsToBounds = YES;
 */
- (UIView*)na_subViewOfClassName:(NSString *)className;

@end

NS_ASSUME_NONNULL_END
