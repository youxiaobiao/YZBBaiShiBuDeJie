//
//  YZBFriendViewController.m
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/13.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import "YZBFriendViewController.h"
#import "YZBRecommentViewController.h"

@interface YZBFriendViewController ()

@end

@implementation YZBFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(click) image:@"friendsRecommentIcon" selectImage:@"friendsRecommentIcon-click"];
    
    // 设置背景颜色
    self.view.backgroundColor = YZBGlobalBg;
    
    
}

// 左边按钮的监听
- (void)click
{
    
    [self.navigationController pushViewController:[[YZBRecommentViewController alloc] init] animated:YES];
    
}

@end
