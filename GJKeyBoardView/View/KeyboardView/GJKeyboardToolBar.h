//
//  GJKeyboardToolBar.h
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/10/9.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJEmojiModel.h"

@interface GJKeyboardToolBar : UIView

@property (nonatomic, copy) void (^btnClickDelegate) (NSInteger section);
@property (nonatomic, copy) void (^sendClickDelegate)(void);
@property (nonatomic, assign) BOOL sendEnable;
- (void)addBtnWithModel: (GJEmojiModel *)emojiM;
- (void)setSelectionIndex: (NSInteger) index;

@end
