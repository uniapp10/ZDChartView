//
//  UIView+Border.m
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/9/27.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import "UIView+Border.h"

@implementation UIView (Border)

- (void)addBorder:(CGFloat) width color:(UIColor *)color cornerWidth:(CGFloat) cornerWidth{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
    self.layer.masksToBounds = true;
    self.layer.cornerRadius = cornerWidth;
    [UIColor blueColor];
}

- (void)addBorder:(CGFloat) width color:(UIColor *)color position:(GJSeperatorPosition) position{
    CALayer *sepL = [CALayer layer];
    if (position == GJTop) {
        sepL.frame = CGRectMake(0, 0, self.frame.size.width, width);
    }
    sepL.backgroundColor = color.CGColor;
    [self.layer addSublayer:sepL];
}
@end
