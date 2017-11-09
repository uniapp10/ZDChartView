//
//  NSString+GJEmoji.m
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/10/26.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import "NSString+GJEmoji.h"

@implementation NSString (GJEmoji)

+ (NSAttributedString *)convertToEmoji: (NSString *)text textFont:(UIFont *)font textColor:(UIColor *)color{
    
    NSRegularExpression *emojiExp = [NSRegularExpression regularExpressionWithPattern:@"\\[[\u4e00-\u9fa5]{1,3}\\]" options:NSRegularExpressionCaseInsensitive error:nil];
    if (text.length == 0) {
        return nil;
    }
    long count = text.length;
    NSArray<NSTextCheckingResult *> *results = [emojiExp matchesInString:text options:NSMatchingReportProgress range:NSMakeRange(0, count)];
    NSMutableAttributedString *attrM = [[NSMutableAttributedString alloc] init];
    NSDictionary *attrDict = @{NSFontAttributeName:font, NSForegroundColorAttributeName:color};
    __block long lastIndex = 0;
    [results enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *str = [text substringWithRange:NSMakeRange(lastIndex, obj.range.location-lastIndex)];
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:str attributes:attrDict];
        [attrM appendAttributedString:attrStr];
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.bounds = CGRectMake(0, -3, 20, 20);
        NSString *imageName = [text substringWithRange:obj.range];
        attach.image = [UIImage imageNamed:imageName];
        NSAttributedString *attrAttach = [NSAttributedString attributedStringWithAttachment:attach];
        [attrM appendAttributedString:attrAttach];
        lastIndex = obj.range.location + obj.range.length;
    }];
    if (lastIndex < count) {
        NSString *lastStr = [text substringFromIndex:lastIndex];
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:lastStr attributes:attrDict];
        [attrM appendAttributedString:attrStr];
    }
    return attrM.copy;
    
}
@end
