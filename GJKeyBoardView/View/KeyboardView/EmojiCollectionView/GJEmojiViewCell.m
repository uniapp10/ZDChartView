//
//  GXEmotionCell.m
//  GXEmotionKeyboard
//
//  Created by zhudong on 16/7/11.
//  Copyright © 2016年 zhudong. All rights reserved.
//

#import "GJEmojiViewCell.h"
#import "GJEmojiCellCollectionView.h"

@interface GJEmojiViewCell ()

@property (nonatomic, strong) GJEmojiCellCollectionView *cellCoolectionView;

@end

@implementation GJEmojiViewCell

- (instancetype)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.cellCoolectionView = [[GJEmojiCellCollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.cellCoolectionView];
    }
    return self;
}

- (void)setEmojisSection:(NSArray *)emojisSection {
    _emojisSection = emojisSection;
    self.cellCoolectionView.emojiModels = emojisSection;
}

- (GJEmojiCellCollectionView *)cellCoolectionView {
    if (!_cellCoolectionView) {
        _cellCoolectionView = [[GJEmojiCellCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    return _cellCoolectionView;
}
@end
