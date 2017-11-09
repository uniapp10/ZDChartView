//
//  GJSpeakBtn.h
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/10/13.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJSpeakBtn : UIView

@property (nonatomic, copy) NSString *normalTitle;
@property (nonatomic, copy) NSString *highlightTitle;
@property (nonatomic, strong) UILabel *titleL;
- (instancetype)initWithFrame: (CGRect)frame
                   beginBlock: (void(^)(CGPoint point))beginBlock
                  movingBlock: (void(^)(CGPoint point))movingBlock
                  cancelBlock: (void(^)(CGPoint point))cancelBlock
                     endBlock: (void(^)(CGPoint point, UILabel *titleL))endBlock;

@end
