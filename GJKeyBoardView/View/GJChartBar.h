//
//  XHBChartBar.h
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/9/27.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "GJBaseMessage.h"


@class GJChartBar;
@protocol GJChartBarDelegate <NSObject>

@optional
- (void)willSendVoice;
- (void)didSendVoice:(NSString *)filePath time:(CGFloat)time;
- (void)cancelSendVoice;

//yang Add Code
- (void)chartBar:(GJChartBar *)chartBar sendText:(NSString *)text;
- (void)chartBar:(GJChartBar *)chartBar sendImage:(UIImage *)image;


@end

@interface GJChartBar : UIView
@property (nonatomic, weak) id<GJChartBarDelegate> ChartBarDelegate;

@end
