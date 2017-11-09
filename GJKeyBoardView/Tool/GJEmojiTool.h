//
//  GJEmojiTool.h
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/9/28.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GJEmojiModel.h"
#import "GJPlusModel.h"

@interface GJEmojiTool : NSObject

+ (NSArray *)loadEmojis;
+ (NSArray *)loadPlusModels;

@end
