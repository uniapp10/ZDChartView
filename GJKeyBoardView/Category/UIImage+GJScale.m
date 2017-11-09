//
//  UIImage+GJScale.m
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/10/11.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import "UIImage+GJScale.h"

@implementation UIImage (GJScale)

+ (UIImage *)imageWithImage:(UIImage *)image scaledSize: (CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *image_scaled = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image_scaled;
}
@end
