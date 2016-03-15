//
//  YZBUserCell.m
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/14.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import "YZBUserCell.h"
#import <UIImageView+WebCache.h>

@interface YZBUserCell ()

// 昵称
@property (weak, nonatomic) IBOutlet UILabel *screen_name;

// 头像
@property (weak, nonatomic) IBOutlet UIImageView *header;

// 粉丝
@property (weak, nonatomic) IBOutlet UILabel *fans_count;

// 底部分割线
@property (weak, nonatomic) IBOutlet UIView *separator;

@end

@implementation YZBUserCell

- (void)awakeFromNib {
    
    self.separator.backgroundColor = YZBGlobalBg;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setUser:(YZBUser *)user
{
    _user = user;
    
    self.screen_name.text = user.screen_name;
    
    // 设置头像
    [self.header sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"fans_count"]];
    
    // 设置粉丝人数
    NSString *fans = nil;
    
    if (user.fans_count < 10000) {
        
        fans = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
        
    } else {
        
        fans = [NSString stringWithFormat:@"%.f万人关注",user.fans_count / 10000.0];
    }
    
    self.fans_count.text = fans;
        
    
    
}

@end
















