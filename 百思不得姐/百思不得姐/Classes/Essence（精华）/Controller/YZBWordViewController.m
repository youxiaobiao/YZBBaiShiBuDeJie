//
//  YZBWordViewController.m
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/17.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import "YZBWordViewController.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import "YZBTopic.h"
#import "YZBTopicCell.h"

@interface YZBWordViewController ()

/** 模型数组 */
@property (nonatomic, strong) NSMutableArray *topics;

/** 用来下一页 */
@property (nonatomic, copy) NSString *maxtime;

/** 当前页 */
@property (nonatomic, assign) NSInteger currentPage;

/** 保存最新参数 */

@property (nonatomic,strong) NSMutableDictionary *params;


@end

static NSString * const ID = @"cell";

@implementation YZBWordViewController

- (NSMutableArray *)topics
{
    if (_topics == nil) {
        
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUpTableView];
    
    [self setUpRefresh];
}

/** 初始化TableView的inset */
- (void)setUpTableView
{
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YZBTopicCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    CGFloat top = YZBTitleViewH + YZBTitleVieY ;
    
    CGFloat bottom = self.tabBarController.tabBar.height;
    
    self.tableView.contentInset = UIEdgeInsetsMake(top , 0, bottom, 0);
    
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

- (void)setUpRefresh
{
    // 下拉
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 自动控制下拉控件的透明
    self.tableView.mj_header.automaticallyChangeAlpha= YES;
    
    // 开始刷新
    [self.tableView.mj_header beginRefreshing];
    
    // 上拉刷新
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark - 刷新控件的监听

/** 下拉刷新 */

- (void)loadNewData
{
    [self.tableView.mj_footer endRefreshing];

    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    
    self.params = params;
   
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) { // 请求成功
        
        // 最新参数和parames不同
        if (self.params != params) return;
        
        // maxtime
        self.maxtime = responseObject[@"nofo"][@"maxtime"];
        
        // 字典转模型
        
        self.topics = [YZBTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新数据
        [self.tableView reloadData];
        
        self.currentPage = 0;
        
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { // 请求失败
        
        // 最新参数和parames不同
        if (self.params != params) return;
        
        [self.tableView.mj_header endRefreshing];
        
    }];
    
    
}


/** 上拉 */

- (void)loadMoreData
{
    
    [self.tableView.mj_header endRefreshing];
    
    self.currentPage++;
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    params[@"page"] = @(self.currentPage);
    params[@"maxtime"] = self.maxtime;
    
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) { // 请求成功
        
        // 最新参数和parames不同
        if (self.params != params) return;
        
        // maxtime
        self.maxtime = responseObject[@"nofo"][@"maxtime"];
        
        // 字典转模型
        
        NSArray *array = [YZBTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.topics addObjectsFromArray:array];
        
        // 刷新数据
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) { // 请求失败
        
        // 最新参数和parames不同
        if (self.params != params) return;
        
        [self.tableView.mj_footer endRefreshing];
        
        self.currentPage--;
        
        
    }];

}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // 检测foot状态
    self.tableView.mj_footer.hidden = (!self.topics.count);
    
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YZBTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 取出模型
    YZBTopic *topic = self.topics[indexPath.row];
    
    cell.textLabel.text = topic.text;
    
    return  cell;
    
}



@end






















