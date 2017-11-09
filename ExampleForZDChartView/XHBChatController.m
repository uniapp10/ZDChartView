//
//  XHBChatController.m
//  XHBEmoji
//
//  Created by 朱冬冬 on 2017/9/27.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import "XHBChatController.h"

@interface XHBChatController ()<GJChartBarDelegate>
@property (nonatomic, assign) BOOL isTransformChanged;
@property (nonatomic, assign) BOOL isUp;
@end

@implementation XHBChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    [GJMessageManager sharedInstance].delegate = self;
    self.navigationController.navigationBar.translucent = false;

    [self.view addSubview:self.chartBar];

    [self.chartBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@TabBarHeight);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillChangeFrameNotification: (NSNotification *)notify {
    NSDictionary *keyboardDict = notify.userInfo;
    CGRect keyboardFrame = [keyboardDict[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    ;
    
    CGFloat offsetY = keyboardFrame.origin.y - GXB_ScreenHeight - TabBarHeight;
    CGFloat offsetYTranform = keyboardFrame.origin.y - GXB_ScreenHeight;
    self.view.transform = CGAffineTransformMakeTranslation(0, offsetYTranform);
}

- (GJChartBar *)chartBar {
    if (!_chartBar) {
        _chartBar = [[GJChartBar alloc] initWithFrame:CGRectMake(0, GXB_ScreenHeight - TabBarHeight - 64, GXB_ScreenWidth, TabBarHeight)];
        _chartBar.ChartBarDelegate = self;
    }
    return _chartBar;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
