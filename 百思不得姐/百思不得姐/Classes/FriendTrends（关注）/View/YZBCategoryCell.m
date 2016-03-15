//
//  YZBCategoryCell.m
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/14.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import "YZBCategoryCell.h"
#import "YZBRecommentCategory.h"

@interface YZBCategoryCell ()

@property (weak, nonatomic) IBOutlet UIView *guideView;
@property (weak, nonatomic) IBOutlet UILabel *name;




@end

@implementation YZBCategoryCell

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
        
    // 没有点击的cell，默认隐藏
    self.guideView.hidden = !selected;
        
    self.name.textColor = ( selected ? [UIColor redColor] : [UIColor blackColor]);

}

- (void)setCategory:(YZBRecommentCategory *)category
{
    _category = category;
        
    self.name.text = category.name;
    
}

@end
