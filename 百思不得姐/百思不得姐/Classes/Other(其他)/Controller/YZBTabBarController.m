//
//  YZBTabBarController.m
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/13.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import "YZBTabBarController.h"
#import "YZBEssenceViewController.h"
#import "YZBNewViewController.h"
#import "YZBFriendViewController.h"
#import "YZBMeViewController.h"
#import "YZBTabBar.h"

@interface YZBTabBarController ()

@end

@implementation YZBTabBarController

// 类加载时候调用
+ (void)initialize
{
    // 显示TabBar文字的颜色
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    
    NSMutableDictionary *attrib = [NSMutableDictionary dictionary];
    
    attrib[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    attrib[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    NSMutableDictionary *selectAttrib = [NSMutableDictionary dictionary];
    
    selectAttrib[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    selectAttrib[NSFontAttributeName] = attrib[NSFontAttributeName];
    
    
    
    [tabBarItem setTitleTextAttributes:attrib forState:UIControlStateNormal];
    
    [tabBarItem setTitleTextAttributes:selectAttrib forState:UIControlStateSelected];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    // 添加精华子控制器
    [self setUpChildViewController:[[YZBEssenceViewController alloc] init] image:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon" title:@"精华"];
    
    // 添加新帖子控制器
    [self setUpChildViewController:[[YZBNewViewController alloc] init] image:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"title:@"新帖"];
    
    // 添加关注子控制器
    [self setUpChildViewController:[[YZBFriendViewController alloc] init] image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"title:@"关注"];

    // 添加我子控制器
    [self setUpChildViewController:[[YZBMeViewController alloc] init] image:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"title:@"我"];
    
    // 创建自定义Tabbar
    [self setValue:[[YZBTabBar alloc] init] forKeyPath:@"tabBar"];

    
}

// 初始化子控制器 不要在这里设置view，这样可以避免未使用view时候加载了
- (void)setUpChildViewController:(UIViewController *)vc image:(NSString *)image selectImage:(NSString *)selectImage title:(NSString *)title
{
    vc.tabBarItem.image = [UIImage imageNamed:image];
    
    vc.navigationItem.title = title;
    
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    
    vc.tabBarItem.title = title;
    
    // 用NavigationController包装子控制器
    UINavigationController *naVc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:naVc];
}



@end



























