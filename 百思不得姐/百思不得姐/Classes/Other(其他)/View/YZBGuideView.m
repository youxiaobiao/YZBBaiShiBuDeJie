//
//  YZBGuideView.m
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/16.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import "YZBGuideView.h"

@implementation YZBGuideView

+ (void)show
{
    NSString *key = @"CFBundleShortVersionString";
    
    // 取出当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    // 取出沙盒里的旧版本号
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSString *oldVersion = [user objectForKey:key];
    
    if (![currentVersion isEqualToString:oldVersion]) { // 有新的版本号
        
        YZBGuideView *guideView = [YZBGuideView guideView];
        
        // 添加引导页到主窗口
        [[UIApplication sharedApplication].keyWindow addSubview:guideView];
        
        // 保存最新的版本号
        [user setObject:currentVersion forKey:key];
    }
}

- (IBAction)go {
    
    [self removeFromSuperview];
}







+ (instancetype)guideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([YZBGuideView class]) owner:nil options:nil] lastObject];
}

@end
