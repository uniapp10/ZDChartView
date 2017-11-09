//
//  GJEmojiCellCollectionView.m
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/9/28.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import "GJEmojiCellCollectionView.h"
#import "GJEmojiCell.h"
#import "GJKeyBoard.h"

@interface GJEmojiCellCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation GJEmojiCellCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc] init];
    flowL.minimumLineSpacing = 0;
    flowL.minimumInteritemSpacing = 0;
    flowL.itemSize = CGSizeMake(frame.size.width / 8.0, frame.size.height / 3.0);
    self = [self initWithFrame:frame collectionViewLayout:flowL];
    if (self) {
        self.showsVerticalScrollIndicator = false;
        self.showsHorizontalScrollIndicator = false;
        self.dataSource = self;
        self.delegate = self;
        self.bounces = false;
        self.backgroundColor = [UIColor emojikeyboardColor];
        [self registerClass:[GJEmojiCell class] forCellWithReuseIdentifier:@"GJEmojiCell"];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.emojiModels.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GJEmojiCell *cell = [self dequeueReusableCellWithReuseIdentifier:@"GJEmojiCell" forIndexPath:indexPath];
    cell.emojiModel = self.emojiModels[indexPath.item];
    return cell;
}

- (void)setEmojiModels:(NSArray *)emojiModels {
    _emojiModels = emojiModels;
    [self reloadData];
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GJEmojiModel *emojiModel = self.emojiModels[indexPath.item];
    [[NSNotificationCenter defaultCenter] postNotificationName:KeyboardInsertEmojiNotification object:nil userInfo:@{@"emojiModel":emojiModel}];
}
@end
