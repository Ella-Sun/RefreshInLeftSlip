//
//  ViewController.m
//  RefreshInLeftSlip
//
//  Created by sunhong on 2016/12/29.
//  Copyright © 2016年 sunhong. All rights reserved.
//

#import "ViewController.h"

#import "ShowInfoView.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.0];
    
    [self setupMainView];
    
}

- (void)setupMainView
{
    CGFloat viewWidth = self.view.bounds.size.width;
    CGRect showFrame = CGRectMake(0, 100, viewWidth, 100);
    ShowInfoView *showView = [[ShowInfoView alloc] initWithFrame:showFrame];
    [self.view addSubview:showView];
    
    showView.JumpToNewBlock = ^(){
        NSLog(@"跳转到新页面");
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
