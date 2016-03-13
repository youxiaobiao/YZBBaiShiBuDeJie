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
    UINavigationBar *bar = [UINavigationBar appearance];
    
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = YZBGlobalBg;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 不是跟控制器
        // 设置右边的按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        btn.size = CGSizeMake(70, 30);
        
        // 水平左
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        

        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        viewController.hidesBottomBarWhenPushed = YES;

    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
    
    
}




@end
