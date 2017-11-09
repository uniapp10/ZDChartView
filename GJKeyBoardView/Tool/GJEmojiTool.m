//
//  GJEmojiTool.m
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/9/28.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import "GJEmojiTool.h"

@implementation GJEmojiTool

+ (NSArray *)loadEmojis{
    NSArray *emojiVarityOne = [self emojisWithFileName:@"FaceEmoji.json" withType: EmojiType_png];
    NSArray *emojiVarityTwo = [self emojisWithFileName:@"SystemEmoji.json" withType: EmojiType_text];
    
    NSMutableArray *arrM = [NSMutableArray array];
    [arrM addObject:emojiVarityOne];
    [arrM addObject:emojiVarityTwo];
    return [arrM copy];
}

+ (NSArray *)emojisWithFileName: (NSString *)file withType: (EmojiType) type {
    NSString *path = [NSString stringWithFormat:@"DefaultEmoji.bundle/%@", file];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:nil];
    NSArray *emojiArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *emojiModels = [NSMutableArray arrayWithCapacity:emojiArray.count];
    __block int i = 0;
    [emojiArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GJEmojiModel *emojiM = [GJEmojiModel new];
        emojiM.emojiType = type;
        switch (type) {
            case EmojiType_png:
                emojiM.name_png = obj[@"credentialName"];
                break;
            case EmojiType_text:
                emojiM.name_text = obj[@"credentialName"];
                break;
            default:
                break;
        }
        
        [emojiModels addObject:emojiM];
        
        i++;
        if (i % 23 == 0) {
            i = 0;
            GJEmojiModel *emojiM_del = [GJEmojiModel new];
            emojiM_del.name_png = @"emojiKB_emoji_delete";
            emojiM_del.emojiType = EmojiType_delete;
            [emojiModels addObject:emojiM_del];
        }
    }];
    if (emojiModels.count % 24 != 0) {
        int blankCount = 24 - emojiModels.count % 24 - 1;
        for (int i = 0; i < blankCount; i++) {
            GJEmojiModel *emojiM = [GJEmojiModel new];
            emojiM.emojiType = EmojiType_blank;
            [emojiModels addObject:emojiM];
        }
        GJEmojiModel *emojiM = [GJEmojiModel new];
        emojiM.name_png = @"emojiKB_emoji_delete";
        emojiM.emojiType = EmojiType_delete;
        [emojiModels addObject:emojiM];
    }
    NSMutableArray *emojisSections = [NSMutableArray array];
    __block NSMutableArray *container;
    [emojiModels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx % 24 == 0) {
            container = [NSMutableArray arrayWithCapacity:24];
            [emojisSections addObject:container];
        }
        [container addObject:obj];
    }];
    return [emojisSections copy];
}

+ (NSArray *)loadPlusModels {
    NSString *path = [NSString stringWithFormat:@"DefaultEmoji.bundle/PlusKeyboard.json"];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:path ofType:nil];
    NSArray *plusArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *plusModels = [NSMutableArray arrayWithCapacity:plusArray.count];
    [plusArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GJPlusModel *plusModel = [GJPlusModel modelWithDict:obj];
        [plusModels addObject:plusModel];
    }];
    return plusModels.copy;
}
@end
