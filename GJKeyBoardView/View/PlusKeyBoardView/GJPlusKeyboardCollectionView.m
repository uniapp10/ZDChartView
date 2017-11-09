//
//  GJPlusKeyboardCollectionView.m
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/10/11.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import "GJPlusKeyboardCollectionView.h"
#import "GJPlusKeyboardCell.h"
#import "GJPlusModel.h"
#import "GJKeyBoard.h"
#define HMargin 20
#define VMargin 10

@interface GJPlusKeyboardCollectionView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end
@implementation GJPlusKeyboardCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((GXB_ScreenWidth - 5 * HMargin) * 0.25, frame.size.height * 0.5);
    flowLayout.minimumLineSpacing = HMargin;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, HMargin, 70, HMargin);
    flowLayout.minimumInteritemSpacing = VMargin;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.showsVerticalScrollIndicator = false;
    self.showsHorizontalScrollIndicator = false;
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        [self registerClass:[GJPlusKeyboardCell class] forCellWithReuseIdentifier:@"GJPlusKeyboardCell"];
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor chatBg];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.plusModels.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GJPlusKeyboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GJPlusKeyboardCell" forIndexPath:indexPath];
    cell.plusModel = self.plusModels[indexPath.item];
    return cell;
}



- (void)setPlusModels:(NSArray *)plusModels {
    _plusModels = plusModels;
    [self reloadData];
}
@end
