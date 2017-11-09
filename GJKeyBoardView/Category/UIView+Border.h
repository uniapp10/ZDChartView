//
//  UIView+Border.h
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/9/27.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GJSeperatorPosition){
    GJTop,
    GJBottom,
    GJLeft,
    GJRight,
};
@interface UIView (Border)

- (void)addBorder:(CGFloat) width color:(UIColor *)color cornerWidth:(CGFloat) cornerWidth;
- (void)addBorder:(CGFloat) width color:(UIColor *)color position:(GJSeperatorPosition) position;

@end
