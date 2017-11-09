//
//  GJVoiceCoverView.h
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/10/12.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CenterViewH 150

@interface GJVoiceCoverView : UIView

- (void)setVolumn: (CGFloat) volumn;
- (void)changeToCancel;
- (void)changeToSend;
- (void)changeToTip;

@end
