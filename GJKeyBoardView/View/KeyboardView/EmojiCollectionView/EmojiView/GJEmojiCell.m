//
//  GJEmojiCell.m
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/9/28.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import "GJEmojiCell.h"

@interface GJEmojiCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *iconLabel;

@end
@implementation GJEmojiCell

- (instancetype)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor emojikeyboardColor];
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.iconLabel.textAlignment = NSTextAlignmentCenter;
    self.iconLabel.font = [UIFont systemFontOfSize:32];
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.iconLabel];
    
}

-(void)setEmojiModel:(GJEmojiModel *)emojiModel {
    _emojiModel = emojiModel;
//    NSLog(@"%@", emojiModel.name_png);
//    NSLog(@"%@", emojiModel.name_text);
    switch (emojiModel.emojiType) {
        case EmojiType_png:
            self.iconLabel.hidden = true;
            self.iconView.hidden = false;
            self.iconView.image = [[UIImage imageNamed:emojiModel.name_png] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            self.iconView.contentMode = UIViewContentModeCenter;
            self.iconView.transform = CGAffineTransformMakeScale(1.2, 1.2);
            break;
        case EmojiType_text:
            self.iconLabel.hidden = false;
            self.iconView.hidden = true;
            self.iconLabel.text = emojiModel.name_text;
            break;
        case EmojiType_delete:
            self.iconLabel.hidden = true;
            self.iconView.hidden = false;
            self.iconView.image = [[UIImage imageNamed:emojiModel.name_png] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            self.iconView.contentMode = UIViewContentModeCenter;
            self.iconView.transform = CGAffineTransformMakeScale(1.2, 1.2);
            break;
        default:
            self.iconLabel.hidden = true;
            self.iconView.hidden = true;
            break;
    }
}

@end
