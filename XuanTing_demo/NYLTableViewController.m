//
//  NYLTableViewController.m
//  XuanTing_demo
//
//  Created by YinlongNie on 17/1/11.
//  Copyright © 2017年 Jiuzhekan. All rights reserved.
//

#import "NYLTableViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface NYLTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation NYLTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTableView];
}


#pragma mark--- 创建tableView设置代理
- (void)createTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIView *emptyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 240)   ];
    self.tableView.tableHeaderView = emptyView;
    
}


#pragma mark---- 实现代理方法
// 返回分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

#pragma mark--返回cell的模样
#pragma mark--返回cell的模样
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyCell";
    
    // 从复用集合取出cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        // 如果复用集合为空就创建
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    }
    cell.textLabel.text = @"哈哈哈哈哈哈哈🐭🐂🐯🐰 🐲🐍🐴🐑 🐒🐔🐶🐖";
    return cell;
}





#pragma mark-------选择跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
