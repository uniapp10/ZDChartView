//
//  GXEmotionCollectionView.m
//  GXEmotionKeyboard
//
//  Created by zhudong on 16/7/11.
//  Copyright © 2016年 zhudong. All rights reserved.
//

#import "GJEmojiCollectionView.h"
#import "GJEmojiViewCell.h"
#define ScreenSize [UIScreen mainScreen].bounds.size

@interface GJEmojiCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
@implementation GJEmojiCollectionView

- (instancetype)initWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(frame.size.width, frame.size.height);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        [self registerClass:[GJEmojiViewCell class] forCellWithReuseIdentifier:@"GJEmojiViewCell"];
        self.dataSource = self;
        self.delegate = self;
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = true;
        self.backgroundColor = [UIColor emojikeyboardColor];
    }
    return self;
}

- (void)setEmojiVarities:(NSArray *)emojiVarities {
    _emojiVarities = emojiVarities;
    [self reloadData];
}
#pragma mark - UICollectionViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    GJEmojiCollectionView *collectionView = (GJEmojiCollectionView *)scrollView;
    NSArray *indexPathArray = [collectionView indexPathsForVisibleItems];
    ;
    if (self.scroolDelegate) {
        self.scroolDelegate([indexPathArray firstObject]);
    }
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.scroolDelegate) {
        self.scroolDelegate(indexPath);
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.emojiVarities.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *emojisVariety = self.emojiVarities[section];
    return emojisVariety.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GJEmojiViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GJEmojiViewCell" forIndexPath:indexPath];
    NSArray *emojisVariety = self.emojiVarities[indexPath.section];
    NSArray *emojisArray = emojisVariety[indexPath.item];
    cell.emojisSection = emojisArray;
    return cell;
}
@end
