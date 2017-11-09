//
//  GXEmotionCollectionView.h
//  GXEmotionKeyboard
//
//  Created by zhudong on 16/7/11.
//  Copyright © 2016年 zhudong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJEmojiCollectionView : UICollectionView
@property (nonatomic,strong) NSArray *emojiVarities;
@property (nonatomic,copy) void (^scroolDelegate)(NSIndexPath *indexPath);
@end
