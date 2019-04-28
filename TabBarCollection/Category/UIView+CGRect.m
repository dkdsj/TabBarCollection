//


#import "UIView+CGRect.h"

@implementation UIView (CGRect)

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.top + self.height;
}

- (void)setBottom:(CGFloat)bottom {
    self.top = bottom - self.height;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)right {
    return self.left + self.width;
}

- (void)setRight:(CGFloat)right {
    self.left = right - self.width;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.centerY);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.centerX, centerY);
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGSize)size {
    return self.frame.size;
}
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    self.frame = CGRectMake(origin.x, origin.y, self.width, self.height);
}

- (CGFloat)tx {
    return self.transform.tx;
}

- (void)setTx:(CGFloat)tx {
    CGAffineTransform transform = self.transform;
    transform.tx = tx;
    self.transform = transform;
}

- (CGFloat)ty {
    return self.transform.ty;
}

- (void)setTy:(CGFloat)ty {
    CGAffineTransform transform = self.transform;
    transform.ty = ty;
    self.transform = transform;
}

- (nullable UIViewController *)viewController {
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]]) {
            return (UIViewController *)responder;
        }
    return nil;
}


//角标
- (NSInteger)brigeNum {
    if ([[self viewWithTag:48511] isKindOfClass:[UILabel class]]) {
        UILabel * tempLabel = [self viewWithTag:48511];
        return [tempLabel.text integerValue];
    }
    return 0;
}
//角标
- (void)setBrigeNum:(NSInteger)brigeNum {
    NSInteger length = [NSString stringWithFormat:@"%ld", (long)brigeNum].length;
    brigeNum = brigeNum > 99 ? 99 : brigeNum;
    if (0 == length && 0 == brigeNum) {
        return;
    }
    CGRect tempFrame = CGRectMake(self.left + self.width - 6,self.top, 12, 12);
    if ([[self.superview viewWithTag:48511] isKindOfClass:[UILabel class]]) {
        UILabel * tempLabel = [self.superview viewWithTag:48511];
        tempLabel.frame = tempFrame;
        tempLabel.text = [NSString stringWithFormat:@"%ld", (long)brigeNum];
        if (0 == brigeNum) {
            tempLabel.alpha = 0;
        }else {
            tempLabel.alpha = 1;
        }
    }else {
        UILabel * la = [[UILabel alloc] initWithFrame:tempFrame];
        la.text = [NSString stringWithFormat:@"%ld", (long)brigeNum];
        la.font = [UIFont systemFontOfSize:9];
        la.textAlignment = NSTextAlignmentCenter;
        la.textColor = [UIColor whiteColor];
        la.layer.cornerRadius = 6;
        la.layer.masksToBounds = YES;
        
        la.tag = 48511;
        la.backgroundColor = [UIColor redColor];
        
        if (length > 2) {
            la.frame = CGRectMake(tempFrame.size.width - 6, tempFrame.origin.y, 12, 12);
        }
        [self.superview addSubview:la];
        if (0 == brigeNum) {
            la.alpha = 0;
        }else {
            la.alpha = 1;
        }
    }
}

//边框颜色
- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}
- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = [borderColor CGColor];
}
//圆角度
- (BOOL)isCornerRadiusHeight10 {
    if (self.height / 10.0 == self.layer.cornerRadius) {
        return YES;
    }
    return NO;
}

- (void)setIsCornerRadiusHeight10:(BOOL)isCornerRadiusHeight10 {
    if (isCornerRadiusHeight10) {
        self.layer.cornerRadius = self.height * 1 / 10.0;
        self.layer.masksToBounds = YES;
    }else {
        isCornerRadiusHeight10 = NO;
    }
}
//切圆
- (BOOL)isCornerRadiusHalfWidth {
    if (self.layer.cornerRadius == self.height / 2.0) {
        return YES;
    }
    return NO;
}

- (void)setIsCornerRadiusHalfWidth:(BOOL)isCornerRadiusHalfWidth {
    if (isCornerRadiusHalfWidth) {
        self.layer.cornerRadius = self.height / 2.0;
        self.layer.masksToBounds = YES;
    }else {
        isCornerRadiusHalfWidth = NO;
    }
}

//虚线边框
- (void)LPCDashedLine:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth spaceAry:(NSArray<NSNumber *> *)spaceAry {
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    
    borderLayer.bounds = CGRectMake(0, 0, self.width , self.height);
    
    borderLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    //不带圆角
//    borderLayer.path = [UIBezierPath bezierPathWithRect:borderLayer.bounds].CGPath;
    //带圆角
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:self.layer.cornerRadius].CGPath;
    borderLayer.lineWidth = lineWidth / [[UIScreen mainScreen] scale];
    //虚线边框
    borderLayer.lineDashPattern = spaceAry;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = lineColor.CGColor;
    [self.layer addSublayer:borderLayer];
}
//实线变框
- (void)LPCSolidLine:(UIColor *)lineColor lineWidth:(CGFloat)lineWidth {
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    
    borderLayer.bounds = CGRectMake(0, 0, self.width , self.height);
    
    borderLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    //不带圆角
    //    borderLayer.path = [UIBezierPath bezierPathWithRect:borderLayer.bounds].CGPath;
    //带圆角
    borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:borderLayer.bounds cornerRadius:self.layer.cornerRadius].CGPath;
    borderLayer.lineWidth = lineWidth / [[UIScreen mainScreen] scale];
    //实线边框
    borderLayer.lineDashPattern = nil;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = lineColor.CGColor;
    [self.layer addSublayer:borderLayer];
}

/** 点击事件-目标-事件 */
- (void)addTarget:(id)target action:(SEL)action {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

@end
