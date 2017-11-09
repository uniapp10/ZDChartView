//
//  XHBChartView.m
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/9/27.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import "XHBChartView.h"

@implementation XHBChartView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.superview && [self pointInside:point withEvent:event]) {
        [self.superview endEditing:true];
    }
    
    return [super hitTest:point withEvent:event];
}

@end
