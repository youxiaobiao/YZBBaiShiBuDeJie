//
//  YZBEssenceViewController.m
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/13.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import "YZBEssenceViewController.h"
#import "YZBTagViewController.h"
#import "YZBAllViewController.h"
#import "YZBVideoViewController.h"
#import "YZBVoiceViewController.h"
#import "YZBPictureViewController.h"
#import "YZBWordViewController.h"
#import <MJExtension.h>


@interface YZBEssenceViewController () <UIScrollViewDelegate>

// 保存的按钮
@property (nonatomic, weak) UIButton *selectedBtn;

// 指示器
@property (nonatomic, strong) UIView *indicator;

@property (nonatomic, weak) UIView *titleView;

@property (nonatomic, weak) UIScrollView *contentView;





@end

@implementation YZBEssenceViewController

- (UIView *)indicator
{
    if (_indicator == nil) {
        
        // 添加红色指示器
        UIView *indicatorView = [[UIView alloc] init];
        
        indicatorView.backgroundColor = [UIColor redColor];
        
        indicatorView.height= 2;
        
        indicatorView.y = _titleView.height - indicatorView.height;
        
        [_titleView addSubview:indicatorView];
        
        _indicator = indicatorView;
        
    }
    return _indicator;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
     // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置左边的按钮

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(click) image:@"MainTagSubIcon" selectImage:@"MainTagSubIconClick"];
    
    // 设置背景颜色
    self.view.backgroundColor = YZBGlobalBg;
    
    // 设置文字导航控件
    [self setUpTitleView];
    
    [self setUPChildControllerView];
    
    [self setupContentView];

}

// 跳转
- (void)click
{
    YZBTagViewController *tag = [[YZBTagViewController alloc] init];
    
    [self.navigationController pushViewController:tag animated:YES];
}

#pragma mark - 添加scrollView

- (void)setupContentView
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    [self.view insertSubview:contentView atIndex:0];
    
    contentView.delegate = self;
    
    contentView.pagingEnabled = YES;
    
    contentView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    
    _contentView = contentView;
    
    [self scrollViewDidEndScrollingAnimation:contentView];
    
}



#pragma mark - 添加子控制器

- (void)setUPChildControllerView
{
    YZBAllViewController *all = [[YZBAllViewController alloc] init];
    [self addChildViewController:all];
    
    YZBVideoViewController *video = [[YZBVideoViewController alloc] init];
    [self addChildViewController:video];
    
    YZBVoiceViewController *voice = [[YZBVoiceViewController alloc] init];
    [self addChildViewController:voice];
    
    YZBPictureViewController *picture = [[YZBPictureViewController alloc] init];
    [self addChildViewController:picture];
    
    YZBWordViewController *word = [[YZBWordViewController alloc] init];
    [self addChildViewController:word];
}




#pragma mark - 设置设置文字导航控件

- (void)setUpTitleView
{
    // 添加文字索引
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
//    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, screenW, 35)];
    
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    
    [self.view addSubview:titleView];
    
    self.titleView = titleView;
    
    // 添加按钮
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = screenW / titles.count;
    CGFloat btnH = titleView.height;
    
    for (NSInteger i = 0; i < titles.count; i++) {
        
        btnX = i *btnW;
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.tag = i;
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:14];

        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];

        [titleView addSubview:btn];
        
        if (i == 0) { // 默认点击第一个按钮
            
            btn.enabled = NO;
            
            self.selectedBtn = btn;
            
            // 让按钮的内部根据文字来计算
            [btn.titleLabel sizeToFit];
            
            self.indicator.width = btn.titleLabel.width;

            self.indicator.centerX = btn.centerX;

            }
    }
    
}

// 按钮的监听
    
- (void)clickBtn:(UIButton *)btn
    
{
    self.selectedBtn.enabled= YES;
    
    btn.enabled = NO;
    
    self.selectedBtn = btn;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.indicator.centerX = btn.centerX;
        
        self.indicator.width = btn.titleLabel.width;
        
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    
    offset.x = self.contentView.width * btn.tag;
    
    [self.contentView setContentOffset:offset animated:YES];
    
    
    
}


#pragma mark - <UIScrollViewDelegate>

// 动画滚动调用这个方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    UIViewController *vc = self.childViewControllers[index];
    
    vc.view.frame = scrollView.bounds;
    
    vc.view.x = scrollView.contentOffset.x;
    
    [scrollView addSubview:vc.view];
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;

    if (index > 0){ // 跳过titleView
        
        index++;
    }
    
    [self clickBtn:self.titleView.subviews[index]];
    
}



@end





















