//
//  YZBNavigationController.m
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/13.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import "YZBNavigationController.h"

@interface YZBNavigationController ()

@end

@implementation YZBNavigationController

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[YZBNavigationController class], nil];
    
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YZBGlobalBg;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
