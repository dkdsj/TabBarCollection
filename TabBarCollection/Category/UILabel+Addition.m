//
//  UILabel+Addition.m
//  GreenTomato
//
//  Created by liuxudong on 14-6-23.
//  Copyright (c) 2014年 Jan Lion. All rights reserved.
//

#import "UILabel+Addition.h"

@implementation UILabel (Addition)

/**
 *  UILable + NSString calc size with font
 */
- (CGSize)na_labelSizeOfNSString {
    CGSize sizes = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    CGSize adjustedSize = CGSizeMake(ceilf(sizes.width), ceilf(sizes.height));//向上取整
    return adjustedSize;
}

/**
 sizeThatFits
 
 1行：设置的参数的无效 返回最合适的size
 n行：设置的width有效 返回共n行 width下的size，多余n行的文字不显示height也不算在内
 */
- (CGSize)labelSizeFit:(CGSize)maxSize {
    return [self sizeThatFits:maxSize];
}


/**
 boundingRectWithSize 需要用ceil来调整size
 
 @param maxSize CGSizeMake(width, height) width/height某个=0 表示其不限制
 */
- (CGSize)labelBoundingRect:(CGSize)maxSize {
    CGSize size = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;
    
    return CGSizeMake(ceil(size.width)+1, ceil(size.height)+1);
}

- (CGSize)getSize {
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(kScreenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
    return size;
}

/**
 *  NSStringDrawingTruncatesLastVisibleLine:超过size部分的内容以...表示
 *  @return 若文字有非汉字 height width都要+5或其他数字
 */
- (CGSize)boundingRectWithSize:(CGSize)limitSize {
    CGSize sizes  = [self sizeThatFits:limitSize];
    CGSize adjustedSize = CGSizeMake(ceilf(sizes.width+5), ceilf(sizes.height+2));//向上取整
    
    return adjustedSize;

//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        //return [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];

//        sizes = [self.text boundingRectWithSize:size
//                                        options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
//                                     attributes:@{NSFontAttributeName:self.font}
//                                        context:nil].size;
//        sizes.width = ceil(sizes.width);
//        sizes.height = ceil(sizes.height);

//    }
//    else {
//        sizes = [self.text sizeWithFont:self.font
//                     constrainedToSize:limitSize
//                         lineBreakMode:NSLineBreakByWordWrapping];
//    }
}

/**
 *  行距
 */
- (void)lineSpace {
    [self lineSpace:5];
}

/**
 *  行距 https://blog.csdn.net/weixin_41970246/article/details/80258296
 */
- (void)lineSpace:(CGFloat)space {
    if (self.text.length==0) {
        return;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = space - (self.font.lineHeight - self.font.pointSize);
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    self.attributedText = [[NSAttributedString alloc] initWithString:self.text attributes:attributes];
//
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//
//    [paragraphStyle setLineSpacing:space];//调整行间距
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
//    self.attributedText = attributedString;
//    [self sizeToFit];
}

@end
