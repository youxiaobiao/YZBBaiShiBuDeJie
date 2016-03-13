//
//  YZBNewViewController.m
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/13.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import "YZBNewViewController.h"

@interface YZBNewViewController ()

@end

@implementation YZBNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(click) image:@"MainTagSubIcon" selectImage:@"MainTagSubIconClick"];
    
    // 设置背景颜色
    self.view.backgroundColor = YZBGlobalBg;

}

- (void)click
{
    YZBLogFunc;
}


@end
