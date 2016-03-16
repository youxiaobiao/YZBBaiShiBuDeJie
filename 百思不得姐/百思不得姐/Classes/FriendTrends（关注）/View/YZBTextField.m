//
//  YZBTextField.m
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/16.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import "YZBTextField.h"


static NSString * const YZBPlacerholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation YZBTextField

- (void)awakeFromNib
{
    self.tintColor = self.textColor;
    
    
    
}


// 成为第一次响应着
- (BOOL)becomeFirstResponder
{
    [self setValue:self.textColor forKeyPath:YZBPlacerholderColorKeyPath];
    
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder

{
    [self setValue:[UIColor grayColor] forKeyPath:YZBPlacerholderColorKeyPath];

    
    return [super resignFirstResponder];
}


@end
