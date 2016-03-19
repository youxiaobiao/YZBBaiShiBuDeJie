//
//  YZBTopicCell.m
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/18.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import "YZBTopicCell.h"
#import "YZBTopic.h"
#import <UIImageView+WebCache.h>

@interface YZBTopicCell ()

/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;

/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;

/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;

/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation YZBTopicCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTopic:(YZBTopic *)topic
{
    self.nameLabel.text = topic.name;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image]  placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    // 顶的数量
    [self setUpButton:self.dingButton count:topic.ding name:@"顶"];
    
    [self setUpButton:self.caiButton count:topic.cai name:@"踩"];
    
    [self setUpButton:self.shareButton count:topic.repost name:@"转发"];
    
    [self setUpButton:self.caiButton count:topic.comment name:@"评论"];

}

- (void)setUpButton:(UIButton *)btn count:(NSInteger)count name:(NSString *)name
{
    // 设置粉丝人数
    NSString *title = nil;
    
    if (count == 0) {
        
        title = name;
        
    } else if (count < 1000) {
        
        title = [NSString stringWithFormat:@"%zd人关注",count];
        
    } else {
        
        title = [NSString stringWithFormat:@"%.f万人关注",count / 10000.0];
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
}


@end


















