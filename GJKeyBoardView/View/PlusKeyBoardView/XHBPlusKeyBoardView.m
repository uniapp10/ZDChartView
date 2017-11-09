//
//  XHBPlusKeyBoardView.m
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/9/27.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import "XHBPlusKeyBoardView.h"
#import "GJPlusKeyboardCollectionView.h"
#define PageControlHeight 20
#import "GJEmojiTool.h"
#import "GJKeyBoard.h"

@implementation XHBPlusKeyBoardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor chatBg];
        [self createUI];
    }
    return self;
}

- (void)createUI {
    GJPlusKeyboardCollectionView *keyboarC;
    CGFloat H = self.frame.size.height;
    if (!keyboarC) {
        keyboarC = [[GJPlusKeyboardCollectionView alloc] initWithFrame:CGRectMake(0, 0, GXB_ScreenWidth, H - PageControlHeight)];
    }
    __weak typeof(self) weakSelf = self;
    keyboarC.selectImageDelegate = ^(UIImage *image) {
        if (weakSelf.selectImageDelegate) {
            weakSelf.selectImageDelegate(image);
        }
    };
    UIPageControl *pageC;
    if (!pageC) {
        pageC = [[UIPageControl alloc] initWithFrame:CGRectMake(0, H - PageControlHeight, GXB_ScreenWidth, PageControlHeight)];
    }
    [self addSubview:keyboarC];
    [self addSubview:pageC];
    NSArray *plusModels = [GJEmojiTool loadPlusModels];
    keyboarC.plusModels = plusModels;
}

@end
