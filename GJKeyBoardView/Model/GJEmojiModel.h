//
//  GJEmojiModel.h
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/9/28.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, EmojiType) {
    EmojiType_png,
    EmojiType_text,
    EmojiType_blank,
    EmojiType_delete,
};

@interface GJEmojiModel : NSObject

@property (nonatomic, assign) NSInteger emojiType;
@property (nonatomic, copy) NSString *name_text;
@property (nonatomic, copy) NSString *name_png;

@end
