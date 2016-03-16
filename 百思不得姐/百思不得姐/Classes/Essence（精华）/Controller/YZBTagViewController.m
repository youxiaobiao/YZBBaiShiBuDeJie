//
//  YZBTagViewController.m
//  百思不得姐
//
//  Created by 尤佐标 on 16/3/15.
//  Copyright © 2016年 尤佐标. All rights reserved.
//

#import "YZBTagViewController.h"
#import <AFNetworking.h>

#import <SVProgressHUD.h>
#import "YZBTag.h"
#import <MJExtension.h>
#import "YZBTagCell.h"

@interface YZBTagViewController ()

@property (nonatomic, strong) NSArray *tags;


@end


static NSString * const tagID = @"tag";

@implementation YZBTagViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = YZBGlobalBg;
    
    self.tableView.rowHeight = 70;
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YZBTagCell class]) bundle:nil] forCellReuseIdentifier:tagID];
    
    [self setUpTagData];
    
}

- (void)setUpTagData
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";

    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 隐藏模板
        [SVProgressHUD dismiss];
        
        self.tags = [YZBTag mj_objectArrayWithKeyValuesArray:responseObject];
        
        // 刷新列表
        
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    
    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    YZBTagCell *cell = [tableView dequeueReusableCellWithIdentifier:tagID];
    
    YZBTag *tag = self.tags[indexPath.row];
    
    cell.esssenceTag = tag;
 
    return cell;
}

@end















