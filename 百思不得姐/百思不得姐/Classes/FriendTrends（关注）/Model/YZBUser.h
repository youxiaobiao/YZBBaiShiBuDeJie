//
//  YZBUser.h
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/14.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZBUser : NSObject

// 头像
@property (nonatomic, copy) NSString *header;

// 昵称
@property (nonatomic, copy) NSString *screen_name;

// 粉丝
@property (nonatomic, assign) NSInteger fans_count;

@end
