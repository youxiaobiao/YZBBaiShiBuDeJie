//
//  YZBTagCell.m
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/15.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import "YZBTagCell.h"
#import <UIImageView+WebCache.h>
#import "YZBTag.h"

@interface YZBTagCell ()

@property (nonatomic, weak) IBOutlet UIImageView *image_listView;

@property (nonatomic, weak) IBOutlet UILabel *theme_name;

@property (weak, nonatomic) IBOutlet UILabel *sub_number;


@end

@implementation YZBTagCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{

    frame.origin.x =10;
    
    frame.size.width -= 2 * frame.origin.x;
    
    frame.size.height -=1;
    
    [super setFrame:frame];
    
  
}

- (void)setEsssenceTag:(YZBTag *)esssenceTag
{
    _esssenceTag = esssenceTag;
    
    [self.image_listView sd_setImageWithURL:[NSURL URLWithString:esssenceTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.theme_name.text = esssenceTag.theme_name;
    
    NSString *sub_number = nil;
    
    if ([esssenceTag.sub_number integerValue] < 10000) {
        
        sub_number = [NSString stringWithFormat:@"%zd人关注",[esssenceTag.sub_number integerValue]];
        
    } else {
        
        sub_number = [NSString stringWithFormat:@"%.f万人关注",[esssenceTag.sub_number integerValue] / 10000.0];
    }
    
    self.sub_number.text = sub_number;
    
    
    
}



@end
