//
//  YZBVerticalButton.m
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/16.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import "YZBVerticalButton.h"

@implementation YZBVerticalButton


- (void)setUpButton
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpButton];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setUpButton];

    
}





- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片位置

    self.imageView.x = 0;
    
    self.imageView.y = 0;
    
    self.imageView.height = self.width;
    
    self.imageView.width = self.width;
    
    // 调整文字文字
    self.titleLabel.x = 0;
    
    self.titleLabel.y = self.imageView.height;
    
    self.titleLabel.width = self.width;
    
    self.titleLabel.height = self.height - self.imageView.height;

}

@end
