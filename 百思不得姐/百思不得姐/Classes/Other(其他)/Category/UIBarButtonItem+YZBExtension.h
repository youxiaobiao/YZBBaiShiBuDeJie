//
//  UIBarButtonItem+YZBExtension.h
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/13.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YZBExtension)

// 设置导航栏左右的按钮
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image selectImage:(NSString *)selectImage;
@end
