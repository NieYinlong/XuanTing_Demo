//
//  ViewController.m
//  XuanTing_demo
//
//  Created by YinlongNie on 17/1/11.
//  Copyright © 2017年 Jiuzhekan. All rights reserved.
//

#import "ViewController.h"
#import "SecViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *categoryView;

@property (nonatomic, strong) UIScrollView *bottomScrollView;



@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"视图已经出现");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO; // 不透明,默认为YES
    
//    _bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    _bottomScrollView.delegate = self;
//    _bottomScrollView.pagingEnabled = YES;
    //[self.view addSubview:_bottomScrollView];
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // 注意 这里一定要设置空表头， 留出高度
    UIView *headV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 240)];
    headV.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headV;
    //[self.view addSubview:self.tableView];
    // 监听
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [_tableView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
    
    
    _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    _headImageView.image = [UIImage imageNamed:@"53d07ba363c71.jpg"];
    //[self.view addSubview:_headImageView];
    
    
    
    _categoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth, 40)];
    _categoryView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_categoryView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_categoryView addGestureRecognizer:tap];
    
}


- (void)tap {
    SecViewController *secV = [[SecViewController alloc] init];
    [self.navigationController pushViewController:secV animated:YES];
}


#pragma mark - 关键代码============ observe 监听tableView的偏移量
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    UITableView *tableView = (UITableView *)object;
    
    CGFloat tableViewoffsetY = tableView.contentOffset.y;
    
    if ( tableViewoffsetY>=0 && tableViewoffsetY<=200) {
        
        self.headImageView.frame = CGRectMake(0, 0-tableViewoffsetY, kScreenWidth, 200);
        
        self.categoryView.frame = CGRectMake(0, 200-tableViewoffsetY, kScreenWidth, 40);
        
        //NSLog(@"%.f====%.f",0-tableViewoffsetY,200-tableViewoffsetY);
        
        
    }else if( tableViewoffsetY < 0){
        self.categoryView.frame = CGRectMake(0, 200, kScreenWidth, 40);
        self.headImageView.frame = CGRectMake(0, 0, kScreenWidth, 200);
        
    }else if (tableViewoffsetY > 200){
        self.categoryView.frame = CGRectMake(0, 0, kScreenWidth, 40);
        self.headImageView.frame = CGRectMake(0, -200, kScreenWidth, 200);
    }
}


#pragma mark---- 实现代理方法
// 返回分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

#pragma mark--返回cell的模样
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:identifier];
    }
    cell.textLabel.text = @"进入多个tableView的页面";
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SecViewController *VC = [[SecViewController alloc] init];
    
    [self.navigationController pushViewController:VC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
