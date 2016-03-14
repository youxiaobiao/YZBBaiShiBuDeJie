//
//  YZBRecommentViewController.m
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/13.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import "YZBRecommentViewController.h"
#import <AFNetworking.h>
#import <SDWebImageManager.h>
#import <SVProgressHUD.h>
#import "YZBCategoryCell.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import "YZBRecommentCategory.h"
@interface YZBRecommentViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

// 存放左边cell的数组
@property (nonatomic, strong) NSArray *categorys;


@end

static NSString * const ID = @"category";

@implementation YZBRecommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
    
    self.view.backgroundColor = YZBGlobalBg;
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 隐藏模板
        [SVProgressHUD dismiss];
        
        self.categorys = [YZBRecommentCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                
        // 刷新列表
        
        [self.categoryTableView reloadData];
        
        ;
        
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:nil scrollPosition:UITableViewScrollPositionTop];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
        
    }];
    
    
}

#pragma mark - 初始化tableview

- (void)setUpTableView
{
    // 注册categoryCell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YZBCategoryCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    self.categoryTableView.rowHeight = 70;
}


#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YZBLog(@"%ld",self.categorys.count);
    return self.categorys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZBCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    YZBRecommentCategory *category = self.categorys[indexPath.row];
    
    cell.category = category;
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZBRecommentCategory *category = self.categorys[indexPath.row];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];

    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(category.id);
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        [YZBRecommentCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新列表
        YZBLog(@"%@",responseObject[@"list"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
        
    }];

}




@end
















