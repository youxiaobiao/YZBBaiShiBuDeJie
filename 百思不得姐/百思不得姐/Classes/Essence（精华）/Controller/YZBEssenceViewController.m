//
//  YZBEssenceViewController.m
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/13.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import "YZBEssenceViewController.h"
#import "YZBTagViewController.h"


@interface YZBEssenceViewController ()

@end

@implementation YZBEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置左边的按钮

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(click) image:@"MainTagSubIcon" selectImage:@"MainTagSubIconClick"];
    
    // 设置背景颜色
    self.view.backgroundColor = YZBGlobalBg;

    
    
}

- (void)click
{
    YZBTagViewController *tag = [[YZBTagViewController alloc] init];
    
    [self.navigationController pushViewController:tag animated:YES];
}


@end





















