//
//  GJPlusKeyboardCell.m
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/10/11.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import "GJPlusKeyboardCell.h"
#import "GJKeyBoard.h"
#define ImageWidth 50
#define TitleHeight 30

@interface GJPlusKeyboardCell ()

@property (nonatomic, strong) UIImageView *iconV;
@property (nonatomic, strong) UILabel *titleL;

@end
@implementation GJPlusKeyboardCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        self.contentView.backgroundColor = [UIColor chatBg];
    }
    return self;
}

- (void)createUI {
    UIImageView *iconV = [[UIImageView alloc] init];
    iconV.contentMode = UIViewContentModeCenter;
    UILabel *titleL = [[UILabel alloc] init];
    titleL.font = [UIFont systemFontOfSize:10];
    titleL.textColor = [UIColor textColor];
    titleL.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:iconV];
    [self.contentView addSubview:titleL];
    self.iconV = iconV;
    self.titleL = titleL;
    iconV.backgroundColor = [UIColor whiteColor];
    iconV.layer.cornerRadius = 10;
    iconV.layer.masksToBounds = true;
    
    [iconV makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@10);
        make.width.height.equalTo(@ImageWidth);
    }];
    [titleL makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@TitleHeight);
    }];
}
- (void)setPlusModel:(GJPlusModel *)plusModel {
    _plusModel = plusModel;
    self.iconV.image = [UIImage imageNamed:plusModel.imageName];
    self.titleL.text = plusModel.title;
}
@end
