//
//  UIBarButtonItem+YZBExtension.m
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/13.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import "UIBarButtonItem+YZBExtension.h"

@implementation UIBarButtonItem (YZBExtension)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image selectImage:(NSString *)selectImage
{
    // 设置左边的按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateHighlighted];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    btn.size = btn.currentBackgroundImage.size;
    
    return [[self alloc] initWithCustomView:btn];
}

@end
