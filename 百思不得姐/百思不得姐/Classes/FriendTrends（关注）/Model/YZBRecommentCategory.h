//
//  YZBRecommentCategory.h
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/14.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZBRecommentCategory : NSObject

// 类目
@property (nonatomic, copy) NSString *name;

// 类目对于的ID
@property (nonatomic,assign) NSInteger id;

// 每个类目对于的用户数量
@property (nonatomic, assign) NSInteger count;

// 对应的用户数组
@property (nonatomic, strong) NSMutableArray *users;




@end
