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
#import "YZBUser.h"
#import "YZBUserCell.h"

// 选择的类目对应的用户模型
#define YZBSelectedRow self.categorys[self.categoryTableView.indexPathForSelectedRow.row]

@interface YZBRecommentViewController () <UITableViewDataSource,UITableViewDelegate>

// 左边的类目
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

// 右边的用户
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

// 存放左边cell的数组
@property (nonatomic, strong) NSArray *categorys;


// 保存最新的请求数据
@property (nonatomic, strong) NSMutableDictionary *parameters;

@property (nonatomic, strong) AFHTTPSessionManager *Manager;

@end

static NSString * const categoryID = @"category";

static NSString * const userID = @"user";

@implementation YZBRecommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTableView];
    
    [self setUpRefresh];
    
    [self setUpCategory];
    
    self.view.backgroundColor = YZBGlobalBg;
    

}

- (AFHTTPSessionManager *)Manager
{
    if (_Manager == nil) {
        
        _Manager = [AFHTTPSessionManager manager];
    }
    return _Manager;
}


#pragma mark - 初始化类目数据

- (void)setUpCategory
{
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    
    [self.Manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 隐藏模板
        [SVProgressHUD dismiss];
        
        self.categorys = [YZBRecommentCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新列表
        
        [self.categoryTableView reloadData];
        
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:nil scrollPosition:UITableViewScrollPositionTop];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
        
    }];
}



#pragma mark - 初始化tableview

- (void)setUpTableView
{
    // 注册categoryCell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YZBCategoryCell class]) bundle:nil] forCellReuseIdentifier:categoryID];
    
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YZBUserCell class]) bundle:nil] forCellReuseIdentifier:userID];
    
    self.categoryTableView.rowHeight = 50;
    
    self.userTableView.rowHeight = 100;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    
    self.userTableView.contentInset = self.categoryTableView.contentInset;

}

#pragma mark - 初始化刷新控件

- (void)setUpRefresh
{
    // 底部刷新控件
    self.userTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 上拉控件开始隐藏
    self.userTableView.mj_footer.hidden = NO;
}

// 加载最新数据

- (void)loadNewData
{
    
    YZBRecommentCategory *category = YZBSelectedRow;
    
    category.currentPage = 1;

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(category.id);
    parameters[@"next_page"] = @(category.currentPage);
    
    self.parameters = parameters;

    [self.Manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 每次下拉刷新，清除旧数据
        [category.users removeAllObjects];
        
        NSArray *arry = [YZBUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [category.users addObjectsFromArray:arry];
        
        if (self.parameters != parameters) { // 不是最新数据
            return;
        }
        
        // 刷新列表
        [self.userTableView reloadData];
        
        [self.userTableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (self.parameters != parameters) { // 不是最新数据
            return;
        }
        
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
        
        [self.userTableView.mj_header endRefreshing];
        
    }];

}


// 加载更多数据

- (void)loadMoreData
{
    YZBRecommentCategory *category = YZBSelectedRow;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(category.id);
    parameters[@"next_page"] = @(category.currentPage++);
    
    
    [self.Manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *arry = [YZBUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [category.users addObjectsFromArray:arry];
        
        // 刷新列表
        [self.userTableView reloadData];
        
        // 时刻检测foot的状态
        [self checkFootState];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.userTableView.mj_footer endRefreshing];
        
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
        
    }];

}

#pragma mark - 检测foot状态

- (void)checkFootState
{
    YZBRecommentCategory *category = YZBSelectedRow;
    
    self.userTableView.mj_footer.hidden = (category.users.count == 0);
    
    if ([category.count integerValue] == category.users.count) { // 已经加载完了
        
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        
    } else { // 未加载完
        
        [self.userTableView.mj_footer endRefreshing];
        
    }

}



#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {
        
        return self.categorys.count;

    } else {
        
        YZBRecommentCategory *category = YZBSelectedRow;
        
        // 时刻检测foot的状态
        [self checkFootState];
        
        return category.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.categoryTableView) {
        
        YZBCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryID];
        
        YZBRecommentCategory *category = self.categorys[indexPath.row];

        
        cell.category = category;
        
        return cell;
        
    } else {
        
        YZBUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userID];
        
        YZBUser *user = [YZBSelectedRow users][indexPath.row];
        
        cell.user = user;
        
        return cell;
           
    }
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.userTableView.mj_footer endRefreshing];
    
    [self.userTableView.mj_header endRefreshing];

    YZBRecommentCategory *category = self.categorys[indexPath.row];
    
//    category.currentPage = 1;
    
    if (category.users.count) { // 已经请求过了
        
        [self.userTableView reloadData];
        
    } else { // 第一次请求
        
        // 这次刷新作用是赶紧把上一次点击的，给清除
        [self.userTableView reloadData];
        
        // 开始下拉刷新
        [self.userTableView.mj_header beginRefreshing];
        
    }

}

#pragma mark - 销毁请求

- (void)dealloc
{
    [self.Manager.operationQueue cancelAllOperations];
}

@end
















