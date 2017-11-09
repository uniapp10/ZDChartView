//
//  GJEmojiKeyboardView.m
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/9/28.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import "GJEmojiKeyboardView.h"
#import "GJEmojiCollectionView.h"
#define ScreenSize [UIScreen mainScreen].bounds.size
#define ToolBarHeight 35
#define PageControlHeight 15

@interface GJEmojiKeyboardView ()

@property (nonatomic, strong) GJEmojiCollectionView *emojiCollectonView;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation GJEmojiKeyboardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    __block NSArray *emojiVarieties = [GJEmojiTool loadEmojis];
    GJEmojiCollectionView *emojiCollectonView = [[GJEmojiCollectionView alloc] initWithFrame:CGRectMake(0, 0, GXB_ScreenWidth, KeyboardHeight - ToolBarHeight - PageControlHeight)];
    self.emojiCollectonView = emojiCollectonView;
    emojiCollectonView.emojiVarities = emojiVarieties;
    __block GJKeyboardToolBar *toolBar = [[GJKeyboardToolBar alloc] initWithFrame:CGRectMake(0, KeyboardHeight - ToolBarHeight, ScreenSize.width, ToolBarHeight)];
    [emojiVarieties enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GJEmojiModel *emojiM = ((NSArray *)obj.firstObject).firstObject;
        [toolBar addBtnWithModel: emojiM];
    }];
    [toolBar setSelectionIndex:0];
    __block UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, KeyboardHeight - ToolBarHeight - PageControlHeight, GXB_ScreenWidth, PageControlHeight)];
    pageControl.backgroundColor = [UIColor emojikeyboardColor];
    [pageControl setCurrentPageIndicatorTintColor:[UIColor darkGrayColor]];
    [pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
    NSArray *sectionArray_first = emojiVarieties.firstObject;
    pageControl.numberOfPages = sectionArray_first.count;
    pageControl.currentPage = 0;
    [pageControl addTarget:self action:@selector(pageControlChange:) forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:emojiCollectonView];
    [self addSubview:pageControl];
    [self addSubview:toolBar];
    
    __weak typeof(self) weakSelf = self;
    emojiCollectonView.scroolDelegate = ^(NSIndexPath *indexPath) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.indexPath = indexPath;
        NSArray *sectionArray = emojiVarieties[indexPath.section];
        pageControl.numberOfPages = sectionArray.count;
        pageControl.currentPage = indexPath.item;
        [toolBar setSelectionIndex:indexPath.section];
    };
    toolBar.btnClickDelegate = ^(NSInteger section) {
        __strong typeof(self) strongSelf = weakSelf;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
        [strongSelf.emojiCollectonView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:true];
    };
    toolBar.sendClickDelegate = ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:KeyboardSendBtnClick object:nil];
    };
    self.toolBar = toolBar;
    self.indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
}

- (void)pageControlChange: (UIPageControl *)pageControl {
    NSInteger index = pageControl.currentPage;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:self.indexPath.section];
    [self.emojiCollectonView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:true];
}

@end
