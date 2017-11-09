//
//  GJPlusKeyboardCollectionView.h
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/10/11.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJPlusKeyboardCollectionView : UICollectionView

@property (nonatomic, strong) NSArray *plusModels;
@property (nonatomic, copy) void (^selectImageDelegate)(UIImage *image);

@end
