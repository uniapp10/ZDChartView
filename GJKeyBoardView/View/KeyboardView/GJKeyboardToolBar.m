//
//  GJKeyboardToolBar.m
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/10/9.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import "GJKeyboardToolBar.h"
#define SepHeightRation 0.1
#define SepWidth 1
#define SendWidth 60
#define BtnBaseTag 1000

@interface GJKeyboardToolBar ()

@property (nonatomic, assign) CGFloat btnX;
@property (nonatomic, assign) NSInteger btnTag;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UIButton *sendBtn;

@end
@implementation GJKeyboardToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addBorder:1 color:[UIColor sepColor] position:GJTop];
        self.backgroundColor = [UIColor whiteColor];
        UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - SendWidth, 0, SendWidth, frame.size.height)];
        [sendBtn setBackgroundImage:[UIImage imageNamed:@"emojiKB_sendBtn_gray"] forState:UIControlStateDisabled];
        [sendBtn setBackgroundImage:[UIImage imageNamed:@"emojiKB_sendBtn_blueHL"] forState:UIControlStateNormal];
        [sendBtn sizeToFit];
        [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [sendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
        [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sendBtn.enabled = false;
        [sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.sendBtn = sendBtn;
        [self addSubview:sendBtn];
    }
    return self;
}

- (void)sendBtnClick {
    if (self.sendClickDelegate) {
        self.sendClickDelegate();
    }
}

- (void)addBtnWithModel: (GJEmojiModel *)emojiM {
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.btnX, 0, self.frame.size.height, self.frame.size.height)];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"emoji_hl_background"] forState:UIControlStateSelected];
    self.btnX = self.btnX + self.frame.size.height;
    btn.tag = self.btnTag + BtnBaseTag;
    btn.adjustsImageWhenHighlighted = false;
    self.btnTag += 1;
    [self insertSubview:btn atIndex:0];
    switch (emojiM.emojiType) {
        case EmojiType_png:
        {
            UIImage *icon = [[UIImage imageNamed:emojiM.name_png] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            [btn setImage:icon forState:UIControlStateNormal];
            
            CALayer *sepL = [CALayer layer];
            sepL.backgroundColor = [UIColor grayColor].CGColor;
            sepL.frame = CGRectMake(self.frame.size.height , self.frame.size.height * SepHeightRation, SepWidth, self.frame.size.height * (1 - 2 * SepHeightRation));
            [self.layer addSublayer:sepL];
            break;
        }
        case EmojiType_text:
        {
            [btn setTitle:emojiM.name_text forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:24];
            break;
        }
        default:
            break;
    }
}

- (void)btnClick: (UIButton *)btn {
    if (btn == self.selectedBtn) {
        return;
    }
    [self setSelectionIndex: (btn.tag - BtnBaseTag)];
    if (self.btnClickDelegate) {
        self.btnClickDelegate((btn.tag - BtnBaseTag));
    }
}

- (void)setSelectionIndex: (NSInteger) index{
    self.selectedBtn.selected = false;
    self.selectedBtn.userInteractionEnabled = true;
    UIButton *btn = [self viewWithTag:(BtnBaseTag + index)];
    btn.selected = true;
    btn.userInteractionEnabled = false;
    self.selectedBtn = btn;
}

- (void)setSendEnable:(BOOL)sendEnable{
    _sendEnable = sendEnable;
    self.sendBtn.enabled = sendEnable;
}
@end
