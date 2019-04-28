
//

#import <UIKit/UIKit.h>

@interface UIView (CGRect)

/** 上 */
@property CGFloat top;
/** 下 */
@property CGFloat bottom;
/** 左 */
@property CGFloat left;
/** 右 */
@property CGFloat right;
/** 中心x */
@property CGFloat centerX;
/** 中心y */
@property CGFloat centerY;
/** 高 */
@property CGFloat height;
/** 宽 */
@property CGFloat width;
/** 角标数 */
@property NSInteger brigeNum;
/** 尺寸 */
@property CGSize size;
/** 坐标 */
@property (nonatomic, assign) CGPoint origin;
/** 偏移x */
@property (nonatomic, assign) CGFloat tx;
/** 偏移y */
@property (nonatomic, assign) CGFloat ty;
/** 是否圆角-高的十分之一 */
@property BOOL isCornerRadiusHeight10;
/** 是否切圆-高的一半 */
@property BOOL isCornerRadiusHalfWidth;
/** 边框颜色 */
@property (nonatomic, strong) UIColor * borderColor;
/** 虚线边框 */
- (void)LPCDashedLine:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth spaceAry:(NSArray<NSNumber *> *)spaceAry;
/** 实线边框 */
- (void)LPCSolidLine:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth;
/** 点击事件-目标-事件 */
- (void)addTarget:(id)target action:(SEL)action;
/** 当前View的视图控制器 */
- (nullable UIViewController *)viewController;

NS_ASSUME_NONNULL_BEGIN
//__nullable表示对象可以是NULL或nil，而__nonnull表示对象不应该为空
/** 避免出现警告 */
NS_ASSUME_NONNULL_END

@end
