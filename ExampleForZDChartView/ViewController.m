//
//  ViewController.m
//  ZDChartView
//
//  Created by 朱冬冬 on 2017/11/9.
//  Copyright © 2017年 朱冬冬. All rights reserved.
//

#import "ViewController.h"
#import "XHBChatController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClick {
    XHBChatController *chatC = [[XHBChatController alloc] init];
    [self.navigationController pushViewController:chatC animated:true];
}

@end
