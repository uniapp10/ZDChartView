//
//  GJVoiceCoverView.m
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/10/12.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import "GJVoiceCoverView.h"

@interface GJVoiceCoverView ()

@property (nonatomic, strong) UILabel *tipL;
@property (nonatomic, strong) UIImageView *leftIcon;
@property (nonatomic, strong) UIImageView *rightIcon;
@property (nonatomic, strong) UIImageView *cancleIcon;
@property (nonatomic, strong) NSArray *imagesArray;

@end
@implementation GJVoiceCoverView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.tipL = [[UILabel alloc] init];
    self.tipL.text = @"手指上滑，取消发送";
    self.tipL.font = [UIFont systemFontOfSize:14];
    self.tipL.textColor = [UIColor whiteColor];
    self.tipL.textAlignment = NSTextAlignmentCenter;

    self.backgroundColor = [UIColor bg_AlphaColor];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = true;
    self.leftIcon = [[UIImageView alloc] init];
    self.leftIcon.image = [UIImage imageNamed:@"chat_record_recording"];
    self.leftIcon.contentMode = UIViewContentModeLeft;
    self.rightIcon = [[UIImageView alloc] init];
    self.leftIcon.contentMode = UIViewContentModeRight;
    self.rightIcon.image = [UIImage imageNamed:@"chat_record_signal_1"];
    self.cancleIcon = [[UIImageView alloc] init];
    self.cancleIcon.image = [UIImage imageNamed:@"chat_record_cancel"];
    self.cancleIcon.contentMode = UIViewContentModeCenter;
    self.cancleIcon.hidden = true;
    
    [self addSubview:_tipL];
    [self addSubview:self.leftIcon];
    [self addSubview:self.rightIcon];
    [self addSubview:self.cancleIcon];

    [_tipL sizeToFit];
    [_tipL makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.bottom.equalTo(@-5);
        make.height.equalTo(@20);
    }];
    [_leftIcon sizeToFit];
    [_leftIcon makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.width.equalTo(@(CenterViewH * 0.6));
        make.bottom.equalTo(_tipL.mas_top);
    }];
    [_rightIcon sizeToFit];
    [_rightIcon makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(@0);
        make.width.equalTo(@(CenterViewH * 0.4));
        make.bottom.equalTo(_leftIcon);
    }];
    [_cancleIcon makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.bottom.equalTo(_tipL.top);
        make.left.right.equalTo(@0);
    }];
}

- (void)setVolumn: (CGFloat) volumn{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSInteger picId = 10 * (volumn < 0 ? 0 : (volumn > 1.0 ? 1.0 : volumn));
        picId += 1;
        picId = picId > 8 ? 8 : picId;
        [self.rightIcon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"chat_record_signal_%ld", (long)picId]]];
    });
}

- (void)changeToCancel {
    self.tipL.text = @"松开手指，取消发送";
    self.tipL.backgroundColor = [UIColor warnColor];
    self.tipL.layer.cornerRadius = 3;
    self.tipL.layer.masksToBounds = true;
    self.leftIcon.hidden = true;
    self.rightIcon.hidden = true;
    self.cancleIcon.hidden = false;
}

- (void)changeToSend {
    self.tipL.text = @"手指上滑，取消发送";
    self.leftIcon.hidden = false;
    self.rightIcon.hidden = false;
    self.cancleIcon.hidden = true;
    self.tipL.backgroundColor = [UIColor clearColor];
}

- (void)changeToTip {
    self.tipL.text = @"说话时间太短";
    self.tipL.backgroundColor = [UIColor clearColor];
    self.tipL.layer.cornerRadius = 3;
    self.tipL.layer.masksToBounds = true;
    self.leftIcon.hidden = true;
    self.rightIcon.hidden = true;
    self.cancleIcon.hidden = false;
}
@end
