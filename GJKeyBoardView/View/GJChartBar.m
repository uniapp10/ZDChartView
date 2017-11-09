//
//  XHBChartBar.m
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/9/27.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import "GJChartBar.h"
#import "XHBPlusKeyBoardView.h"
#define CharBarTextFont [UIFont systemFontOfSize:16.0f]
#import "GJEmojiKeyboardView.h"
#import "GJKeyBoard.h"
#import "GJVoiceCoverView.h"
#import "GJAudioRecorder.h"
#import "GJAudioPlayer.h"
#import "GJSpeakBtn.h"

@interface GJChartBar ()<UITextViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIButton *voiceBtn;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *emojiBtn;
@property (nonatomic, strong) UIButton *plusBtn;
@property (nonatomic, strong) GJSpeakBtn *speakBtn;
@property (nonatomic, strong) XHBPlusKeyBoardView *plusKeyBoardView;
@property (nonatomic, assign) BOOL isVoice;
@property (nonatomic, assign) BOOL isEmoji;
@property (nonatomic, strong) GJEmojiKeyboardView *emojiKeyboardView;
@property (nonatomic, strong) GJVoiceCoverView *coverView;

@end

@implementation GJChartBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(insertEmoji:) name:KeyboardInsertEmojiNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendTextMsg) name:KeyboardSendBtnClick object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
        self.isVoice = true;
        self.isEmoji = true;
        self.backgroundColor = [UIColor chatBg];
        [self createUI];
        
    }
    return self;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [self sendTextMsg];
        return NO;
    }
    if (textView.text.length==0) {
        self.emojiKeyboardView.toolBar.sendEnable = false;
    }else{
        self.emojiKeyboardView.toolBar.sendEnable = true;
    }
    
    return true;
}
- (void)textViewDidChange:(UITextView *)textView{
    [self updateFrame];
}

#pragma mark - 杨福堂修改
- (void)sendTextMsg {
    if ([self.ChartBarDelegate respondsToSelector:@selector(chartBar:sendText:)]) {
        [self.ChartBarDelegate chartBar:self sendText:self.textView.text];
    }
    self.textView.text = nil;
    [self updateFrame];
}

- (void)sendImageMsg: (UIImage *)image {
    if ([self.ChartBarDelegate respondsToSelector:@selector(chartBar:sendImage:)]) {
        [self.ChartBarDelegate chartBar:self sendImage:image];
    }
    [self updateFrame];
}

- (void)insertEmoji: (NSNotification *)insertNotify {
    NSDictionary *valueDict = insertNotify.userInfo;
    GJEmojiModel *emojiModel = valueDict[@"emojiModel"];
    switch (emojiModel.emojiType) {
        case EmojiType_png:
            [self.textView insertText:emojiModel.name_png];
            break;
        case EmojiType_text:
            [self.textView insertText:emojiModel.name_text];
            break;
        case EmojiType_delete:
            [self deleteWord:self.textView.text];
        default:
            
            break;
    }
    [self textView:self.textView shouldChangeTextInRange:NSMakeRange(0, 0) replacementText:@""];
}

- (void)deleteWord: (NSString *)contentString {
    if (contentString.length == 0) {
        return;
    }
    NSString *lastChar = [contentString substringFromIndex:(contentString.length - 1)];
    if ([lastChar isEqualToString:@"]"] && [contentString rangeOfString:@"[" options:NSBackwardsSearch].length > 0) {
        NSRange range = [contentString rangeOfString:@"[" options:NSBackwardsSearch];
        NSString *deletedString = [contentString substringToIndex:range.location];
        self.textView.text = deletedString;
        [self updateFrame];
    } else{
        [self.textView deleteBackward];
    }
}

#pragma mark - UITextViewDelegate
- (void)updateFrame {
    CGSize size = [self.textView sizeThatFits:CGSizeMake((GXB_ScreenWidth - 3*BtnHeight), CGFLOAT_MAX)];
    CGFloat height_cla = size.height;
    self.textView.scrollEnabled = false;
    if ( height_cla > BtnHeight * 2.5) {
        self.textView.scrollEnabled = true;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(2.5 * BtnHeight + 20));
        }];
    }else if (height_cla > BtnHeight){
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(height_cla + 20));
        }];
    } else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(BtnHeight));
        }];
    };
    [UIView animateWithDuration:0.25 animations:^{
        [self setNeedsDisplay];
    }];
}

- (void)keyboardWillChangeFrameNotification: (NSNotification *)notify {
//    NSDictionary *keyboardDict = notify.userInfo;
//    CGRect keyboardFrame = [keyboardDict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    ;
//    CGFloat offsetY = keyboardFrame.origin.y - GXB_ScreenHeight;
//    self.transform = CGAffineTransformMakeTranslation(0, offsetY);
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)createUI {
    
    [self addSubview:self.voiceBtn];
    [self addSubview:self.speakBtn];
    [self addSubview:self.textView];
    [self addSubview:self.emojiBtn];
    [self addSubview:self.plusBtn];
 
    [self.voiceBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(@0);
        make.height.width.equalTo(@BtnHeight);
    }];
    [self.textView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@4);
        make.bottom.equalTo(@-4);
        make.left.equalTo(self.voiceBtn.mas_right);
        make.right.equalTo(self.emojiBtn.mas_left);
    }];
    [self.emojiBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.right.equalTo(self.plusBtn.mas_left);
        make.height.width.equalTo(@BtnHeight);
    }];
    [self.plusBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(@0);
        make.height.width.equalTo(@BtnHeight);
    }];
    [self.speakBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@4);
        make.bottom.equalTo(@-4);
        make.left.equalTo(self.voiceBtn.mas_right);
        make.right.equalTo(self.emojiBtn.mas_left);
    }];
}

- (void)plusBtnClick {
    self.textView.inputView = self.plusKeyBoardView;
    [self.textView reloadInputViews];
    [self.textView becomeFirstResponder];
}

- (void)voiceBtnClick {
    self.isVoice = !self.isVoice;
    if (!self.isVoice) {
        [self.voiceBtn setImage:[UIImage imageNamed:@"chat_toolbar_keyboard"] forState:UIControlStateNormal];
        [self.voiceBtn setImage:[UIImage imageNamed:@"chat_toolbar_keyboard_HL"] forState:UIControlStateHighlighted];
        
        self.speakBtn.hidden = false;
        self.textView.hidden = true;
        [self.textView resignFirstResponder];
        
        [self.emojiBtn setImage:[UIImage imageNamed:@"chat_toolbar_emotion"] forState:UIControlStateNormal];
        [self.emojiBtn setImage:[UIImage imageNamed:@"chat_toolbar_emotion_HL"] forState:UIControlStateHighlighted];
        self.isEmoji = true;
    }else {
        [_voiceBtn setImage:[UIImage imageNamed:@"chat_toolbar_voice"] forState:UIControlStateNormal];
        [_voiceBtn setImage:[UIImage imageNamed:@"chat_toolbar_voice_HL"] forState:UIControlStateHighlighted];
        self.speakBtn.hidden = true;
        self.textView.hidden = false;
        if (self.isEmoji) {
            self.textView.inputView = nil;
        }
        [self.textView becomeFirstResponder];
    }
    
}

- (void)speakBtnClick {
    [[UIApplication sharedApplication].keyWindow addSubview:self.coverView];
}

- (void)emojiBtnClick {    
    self.isEmoji = !self.isEmoji;
    if (!self.isEmoji) {
        [self.emojiBtn setImage:[UIImage imageNamed:@"chat_toolbar_keyboard"] forState:UIControlStateNormal];
        [self.emojiBtn setImage:[UIImage imageNamed:@"chat_toolbar_keyboard_HL"] forState:UIControlStateHighlighted];
        self.textView.inputView = self.emojiKeyboardView;
    }else {
        [self.emojiBtn setImage:[UIImage imageNamed:@"chat_toolbar_emotion"] forState:UIControlStateNormal];
        [self.emojiBtn setImage:[UIImage imageNamed:@"chat_toolbar_emotion_HL"] forState:UIControlStateHighlighted];
        self.textView.inputView = nil;
    }
    if (!self.isVoice) {
        [self voiceBtnClick];
    }
    [self.textView becomeFirstResponder];
    [self.textView reloadInputViews];
    
}

- (UIButton *)voiceBtn{
    if (!_voiceBtn) {
        _voiceBtn = [UIButton new];
        [_voiceBtn setImage:[UIImage imageNamed:@"chat_toolbar_voice"] forState:UIControlStateNormal];
        [_voiceBtn setImage:[UIImage imageNamed:@"chat_toolbar_voice_HL"] forState:UIControlStateHighlighted];
        _voiceBtn.imageView.contentMode = UIViewContentModeCenter;
        [_voiceBtn addTarget:self action:@selector(voiceBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _voiceBtn.backgroundColor = [UIColor chatBg];
    }
    return _voiceBtn;
}

-(UITextView *)textView {
    if (!_textView) {
        _textView = [UITextView new];
        _textView.layer.cornerRadius = 5;
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        [_textView addBorder:1 color:[UIColor colorWithWhite:0.0 alpha:0.3] cornerWidth:5];
        [_textView setFont:CharBarTextFont];
        _textView.delegate = self;
        _textView.returnKeyType = UIReturnKeySend;
        _textView.enablesReturnKeyAutomatically = true;
    }
    return _textView;
}

- (UIButton *)emojiBtn {
    if (!_emojiBtn) {
        _emojiBtn = [UIButton new];
        [_emojiBtn setImage:[UIImage imageNamed:@"chat_toolbar_emotion"] forState:UIControlStateNormal];
        [_emojiBtn setImage:[UIImage imageNamed:@"chat_toolbar_emotion_HL"] forState:UIControlStateHighlighted];
        _emojiBtn.imageView.contentMode = UIViewContentModeCenter;
        _emojiBtn.backgroundColor = [UIColor chatBg];
        [_emojiBtn addTarget:self action:@selector(emojiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emojiBtn;
}

- (UIButton *)plusBtn {
    if (!_plusBtn) {
        _plusBtn = [UIButton new];
        [_plusBtn setImage:[UIImage imageNamed:@"chat_toolbar_more"] forState:UIControlStateNormal];
        [_plusBtn setImage:[UIImage imageNamed:@"chat_toolbar_more_HL"] forState:UIControlStateHighlighted];
        _plusBtn.imageView.contentMode = UIViewContentModeCenter;
        _plusBtn.backgroundColor = [UIColor chatBg];
        [_plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _plusBtn;
}

- (GJSpeakBtn *)speakBtn {
    if (!_speakBtn) {
        __weak typeof(self) weakSelf = self;
        _speakBtn = [[GJSpeakBtn alloc] initWithFrame:CGRectZero beginBlock:^(CGPoint point) {
            __strong typeof(self) strongSelf = weakSelf;
            __weak typeof(self) weakSelf = strongSelf;
            if ([weakSelf.ChartBarDelegate respondsToSelector:@selector(willSendVoice)]) {
                [weakSelf.ChartBarDelegate willSendVoice];
            }
            [[GJAudioRecorder shareRecorder] startRecordWithVolumnChanged:^(CGFloat volumn) {
                [weakSelf.coverView setVolumn:volumn];
            } complete:^(NSString *filePath, CGFloat time) {
                if (time < 1.0) {
                    [self.coverView changeToTip];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [weakSelf.coverView removeFromSuperview];
                    });
                }else{
                    [weakSelf.coverView removeFromSuperview];                    
//                    [weakSelf sendVoiceMsg:filePath time:time];
                    if ([weakSelf.ChartBarDelegate respondsToSelector:@selector(didSendVoice:time:)]) {
                        [weakSelf.ChartBarDelegate didSendVoice:filePath time:time];
                    }
                    [weakSelf updateFrame];
                }
            } cancel:^{
                NSLog(@"取消了");
                if ([weakSelf.ChartBarDelegate respondsToSelector:@selector(cancelSendVoice)]) {
                    [weakSelf.ChartBarDelegate cancelSendVoice];
                }
            }];
        } movingBlock:^(CGPoint point) {
            __strong typeof(self) strongSelf = weakSelf;
            [[UIApplication sharedApplication].keyWindow addSubview:strongSelf.coverView];
            [strongSelf.coverView changeToSend];
           
        } cancelBlock:^(CGPoint point) {
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf.coverView changeToCancel];
        } endBlock:^(CGPoint point, UILabel *titleL) {
            if (point.y < 0) {
                [[GJAudioRecorder shareRecorder] cancelRecord];
                [weakSelf.coverView removeFromSuperview];
            }else {
                [[GJAudioRecorder shareRecorder] stopRecord];
            }
            titleL.text = @"按住 说话";
        }];
        _speakBtn.titleL.text = @"按住 说话";
        _speakBtn.normalTitle = @"手指上滑，取消发送";
        _speakBtn.highlightTitle = @"松开手指，取消发送";
        
    }
    return _speakBtn;
}

- (XHBPlusKeyBoardView *)plusKeyBoardView {
    if (!_plusKeyBoardView) {
        _plusKeyBoardView = [[XHBPlusKeyBoardView alloc] initWithFrame:CGRectMake(0, 0, GXB_ScreenWidth, KeyboardHeight)];
        __weak typeof(self) weakSelf = self;
        _plusKeyBoardView.selectImageDelegate = ^(UIImage *image) {
            [weakSelf sendImageMsg: image];
        };
    }
    return _plusKeyBoardView;
}

- (GJEmojiKeyboardView *)emojiKeyboardView {
    if (!_emojiKeyboardView) {
        _emojiKeyboardView = [[GJEmojiKeyboardView alloc] initWithFrame:CGRectMake(0, 0, GXB_ScreenWidth, KeyboardHeight)];
        
    }
    return _emojiKeyboardView;
}

- (GJVoiceCoverView *)coverView {
    if (!_coverView) {
        _coverView = [[GJVoiceCoverView alloc] initWithFrame:CGRectMake((GXB_ScreenWidth - CenterViewH) * 0.5, (GXB_ScreenHeight - CenterViewH) * 0.5, CenterViewH, CenterViewH)];
    }
    return _coverView;
}
@end
