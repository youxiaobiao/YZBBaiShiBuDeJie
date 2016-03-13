//
//  YZBTabBar.m
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/13.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import "YZBTabBar.h"

@interface YZBTabBar ()

@property (nonatomic, weak) UIButton *publishBtn;


@end

@implementation YZBTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];

        UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        
        publishBtn.size = publishBtn.currentBackgroundImage.size;
        
        [self addSubview:publishBtn];
        
        self.publishBtn = publishBtn;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat barW = self.width;
    
    CGFloat barH = self.height;

    // publish的位置
    
    self.publishBtn.center = CGPointMake( barW / 2 , barH / 2);
    
    // 计算其他按钮的位置
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = barW / 5;
    CGFloat h = barH;
   
    NSInteger i = 0;
    
    for ( UIView *view in self.subviews) {
        
        if (![view isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        x =  w * ((i > 1) ? (i + 1) : i) ;
        
        view.frame = CGRectMake(x, y, w, h);
        
        i++;
        
    }
    
}









@end
