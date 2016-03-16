//
//  YZBLoginAndRegisterViewController.m
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/16.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import "YZBLoginAndRegisterViewController.h"

@interface YZBLoginAndRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;

@end

@implementation YZBLoginAndRegisterViewController

- (IBAction)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginOrRegister:(UIButton *)btn {
    
    if (self.leftMargin.constant == 0) { // 要显示注册页面
        
        self.leftMargin.constant = - [UIScreen mainScreen].bounds.size.width;
        
        btn.selected = YES;
    } else { // 要显示登陆页面
        
        self.leftMargin.constant = 0;
        
        btn.selected = NO;
        
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.view layoutIfNeeded];
    }];
}




// 控制当前控制器的状态栏情况
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
