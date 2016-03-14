//
//  YZBRecommentCategory.m
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/14.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import "YZBRecommentCategory.h"

@implementation YZBRecommentCategory

- (NSMutableArray *)users
{
    if (_users == nil) {
        
        _users = [NSMutableArray array];
        
    }
    return _users;
}

@end
