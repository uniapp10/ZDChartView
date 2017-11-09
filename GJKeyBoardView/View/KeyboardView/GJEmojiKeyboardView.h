//
//  GJEmojiKeyboardView.h
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/9/28.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJEmojiTool.h"
#import "GJKeyboardToolBar.h"
#define KeyboardHeight 216
#define KeyboardSendBtnClick @"KeyboardSendBtnClick"

@interface GJEmojiKeyboardView : UIView
@property (nonatomic, strong) GJKeyboardToolBar *toolBar;
@end
