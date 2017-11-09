//
//  NSString+GJEmoji.h
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/10/26.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GJEmoji)

+ (NSAttributedString *)convertToEmoji: (NSString *)text textFont:(UIFont *)font textColor:(UIColor *)color;

@end
