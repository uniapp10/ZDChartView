//
//  GJSpeakBtn.m
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/10/13.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import "GJSpeakBtn.h"
#define CenterViewH 150

@interface GJSpeakBtn ()

@property (nonatomic, copy) void(^beginBlock)(CGPoint point);
@property (nonatomic, copy) void(^movingBlock)(CGPoint point);
@property (nonatomic, copy) void(^cancelBlock)(CGPoint point);
@property (nonatomic, copy) void(^endBlock)(CGPoint point, UILabel *titleL);

@end

@implementation GJSpeakBtn

- (instancetype)initWithFrame:(CGRect)frame
                   beginBlock: (void(^)(CGPoint point))beginBlock
                  movingBlock: (void(^)(CGPoint point))movingBlock
                  cancelBlock: (void(^)(CGPoint point))cancelBlock
                     endBlock: (void(^)(CGPoint point, UILabel *titleL))endBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        self.beginBlock = beginBlock;
        self.movingBlock = movingBlock;
        self.cancelBlock = cancelBlock;
        self.endBlock = endBlock;
        
        self.backgroundColor = [UIColor chatBg];
        [self addBorder:1 color:[UIColor colorWithWhite:0.0 alpha:0.3] cornerWidth:5];
        UILabel *titleL = [[UILabel alloc] init];
        self.titleL = titleL;
        titleL.font = [UIFont systemFontOfSize:14];
        titleL.textColor = [UIColor textColor];
        titleL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleL];
        [titleL makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"**********");
    self.titleL.text = self.highlightTitle;
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (self.beginBlock) {
        self.beginBlock(point);
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (point.y < 0) {
        self.titleL.text = self.highlightTitle;
        if (self.cancelBlock) {
            self.cancelBlock(point);
        }
    }else {
        self.titleL.text = self.normalTitle;
        if (self.movingBlock) {
            self.movingBlock(point);
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (self.endBlock) {
        self.endBlock(point, self.titleL);
    }
}

@end
