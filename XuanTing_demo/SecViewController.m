//
//  SecViewController.m
//  XuanTing_demo
//
//  Created by YinlongNie on 17/1/11.
//  Copyright © 2017年 Jiuzhekan. All rights reserved.
//

#import "SecViewController.h"
#import "NYLTableViewController.h"
#import "UIButton+Size.h"
#import "UIView+WLFrame.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kCategories @[@"汽车", @"美女", @"新闻", @"娱乐", @"科技", @"电源"， @"电视剧"]
#define PADDING 15
@interface SecViewController ()<UIScrollViewDelegate>


@property (nonatomic, strong) UIScrollView *bottomScrollView;
@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UIScrollView *segmentScrollView;

@property (nonatomic, strong) NSArray *categories;

@property (nonatomic, strong) UIImageView *currentSelectedItemImageView;

//存放button
@property(nonatomic,strong)NSMutableArray *titleButtons;
// 当前显示的tableView
@property (nonatomic, strong) UITableView *currentTableView;

//存放TableView
@property(nonatomic,strong)NSMutableArray *tableViews;

//记录当前偏移量
@property (nonatomic, assign) CGFloat lastTableViewOffsetY;



@end

@implementation SecViewController
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    for (UITableView *tableView in self.tableViews) {
//        
//        [tableView removeObserver:self forKeyPath:@"contentOffSet"];
//    }
    
    NSLog(@"PPPPPPPPP");
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
    //self.navigationController.navigationBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"多个tableView";
    
    [self.view addSubview:self.bottomScrollView];
    [self.view addSubview:self.headImageView];
    [self.view addSubview:self.segmentScrollView];
    [self.segmentScrollView addSubview:self.currentSelectedItemImageView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    UITableView *tableView = (UITableView*)object;
    int offY = tableView.contentOffset.y;
    NSLog(@"🐒%d", offY);
    self.lastTableViewOffsetY = offY;
    
    if (offY >= 0 && offY <= 200) {
        self.headImageView.frame = CGRectMake(0, 0-offY, kScreenWidth, 200);
        self.segmentScrollView.frame = CGRectMake(0, 200-offY, kScreenWidth, 40);
    } else if (offY < 0) {
        // tableView使劲下拉
        
        // 这句是下拉放大动画
        //self.headImageView.frame = CGRectMake(0, 0, kScreenWidth+(-offY), 200+(-offY));
        
        self.headImageView.frame = CGRectMake(0, 0, kScreenWidth, 200);
        self.segmentScrollView.frame = CGRectMake(0, self.headImageView.frame.origin.y+self.headImageView.frame.size.height, kScreenWidth, 40);
        
        
    } else if (offY > 200) {
        // tableView向上移动
        self.headImageView.frame = CGRectMake(0, -200, kScreenWidth, 200);
        self.segmentScrollView.frame = CGRectMake(0, 0, kScreenWidth, 40);
        
        
    }
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView !=self.bottomScrollView) {
        return ;
    }
    
    int index = scrollView.contentOffset.x/kScreenWidth;
    UIButton *currentButton = self.titleButtons[index];
    for (UIButton *button in self.titleButtons) {
        button.selected = NO;
    }
    currentButton.selected = YES;
    self.currentTableView  = self.tableViews[index];

    
    for (UITableView *tableView in self.tableViews) {
        if ( self.lastTableViewOffsetY>=0 &&  self.lastTableViewOffsetY<=240) {
            tableView.contentOffset = CGPointMake(0,  self.lastTableViewOffsetY);
        }else if(  self.lastTableViewOffsetY < 0){
            tableView.contentOffset = CGPointMake(0, 0);
        }else if ( self.lastTableViewOffsetY > 240){
            tableView.contentOffset = CGPointMake(0, 240);
        }
    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        if (index == 0) {
            self.currentSelectedItemImageView.frame = CGRectMake(PADDING, self.segmentScrollView.frame.size.height - 2,currentButton.frame.size.width, 2);
        } else {
            UIButton *preButton = self.titleButtons[index - 1];
            
            float offsetX = CGRectGetMinX(preButton.frame)-PADDING*2;
            [self.segmentScrollView scrollRectToVisible:CGRectMake(offsetX, 0, self.segmentScrollView.width, self.segmentScrollView.height) animated:YES];
            
              self.currentSelectedItemImageView.frame = CGRectMake(CGRectGetMinX(currentButton.frame), self.segmentScrollView.frame.size.height-2, currentButton.frame.size.width, 2);
            
        }
    }];
    
    
    
    
}


#pragma  mark - 选项卡点击事件

/**
 *  选项卡的点击
 *  @param currentButton 当前点击按钮
 */
-(void)changeSelectedItem:(UIButton *)currentButton{
    NSInteger tag = currentButton.tag-1;
    // 全部变为未选择中, btn就变成了灰色
    for (id subview in self.segmentScrollView.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *button = subview;
            button.selected = NO;
        }
    }
    self.currentTableView  = self.tableViews[tag];
    
    for (UITableView *tableView in self.tableViews) {
        if ( self.lastTableViewOffsetY>=0 &&  self.lastTableViewOffsetY<=240) {
            tableView.contentOffset = CGPointMake(0,  self.lastTableViewOffsetY);
        }else if(  self.lastTableViewOffsetY < 0){
            tableView.contentOffset = CGPointMake(0, 0);
        }else if ( self.lastTableViewOffsetY > 240){
            tableView.contentOffset = CGPointMake(0, 240);
        }
    }
    
    currentButton.selected = YES;
    [UIView animateWithDuration:0.3 animations:^{
    
        if (tag == 0) {
            self.currentSelectedItemImageView.frame = CGRectMake(PADDING, self.segmentScrollView.frame.size.height - 2, currentButton.frame.size.width, 2);
        } else {
            
           self.currentSelectedItemImageView.frame = CGRectMake(CGRectGetMinX(currentButton.frame), self.segmentScrollView.frame.size.height-2, currentButton.frame.size.width, 2);
            
            UIButton *preBtn = self.titleButtons[tag-1];
            float offsetX = CGRectGetMinX(preBtn.frame)-PADDING*2;
            
            NSLog(@"%.f------%.f-----offsetX=%.f",currentButton.left, CGRectGetMaxX(currentButton.frame), offsetX);
            
            /** 移到可视区 */
            [self.segmentScrollView scrollRectToVisible:CGRectMake(offsetX, 0, self.segmentScrollView.frame.size.width, self.segmentScrollView.frame.size.height) animated:YES];
            //self.segmentScrollView.contentOffset = CGPointMake(currentButton.left, 0);
            
        }
        
        
        self.bottomScrollView.contentOffset = CGPointMake(tag*kScreenWidth, 0);
        
    }];
    
}




- (NSArray *)categories {
    if (!_categories) {
        _categories = @[@"汽车", @"美女", @"新闻", @"娱乐", @"科技", @"电源", @"电视剧", @"铸造原理", @"航天", @"军事", @"天涯社区"];
    }
    return _categories;
}


- (UIScrollView *)bottomScrollView {
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _bottomScrollView.pagingEnabled = YES;
        _bottomScrollView.delegate = self;
        self.tableViews = [NSMutableArray array];
        
        for (int i = 0; i < self.categories.count; i++) {
            NYLTableViewController *tabVC = [[NYLTableViewController alloc] init];
            tabVC.view.frame = CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight);
            [_bottomScrollView addSubview:tabVC.view];
            
            [self addChildViewController:tabVC];
            [self.tableViews addObject:tabVC.tableView];
            
           [tabVC.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
            
            
            
            
        }
        
        
        
        _bottomScrollView.contentSize = CGSizeMake(_categories.count * kScreenWidth, 0);
        
    }
    return _bottomScrollView;
}


- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        _headImageView.image = [UIImage imageNamed:@"53d07ba363c71.jpg"];
    }
    return _headImageView;
}

- (UIScrollView *)segmentScrollView {
    if (!_segmentScrollView) {
        _segmentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200, kScreenWidth, 40)];
        _segmentScrollView.backgroundColor = [UIColor yellowColor];
        
        NSInteger btnoffset = 0;
        self.titleButtons = [NSMutableArray array];
        for (int i = 0; i < self.categories.count; i++) {
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            
            [btn setTitle:self.categories[i] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor redColor] forState:(UIControlStateSelected)];
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            
            
            btn.backgroundColor = [UIColor greenColor];
            
            
            CGSize size = [UIButton sizeOfLabelWithCustomMaxWidth:kScreenWidth systemFontSize:14 andFilledTextString:self.categories[i]];
            
            
            
            
            float originX =  i > 0 ? 30+btnoffset : PADDING;
            btn.frame = CGRectMake(originX, 14, size.width, size.height);
            btn.titleLabel.textAlignment = NSTextAlignmentLeft;
            btnoffset = CGRectGetMaxX(btn.frame);
            
            
            
            
            //CGRect frame = [self.categories[i] boundingRectWithSize:CGSizeMake(1000, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName] context:nil];
            
            
           // btn.frame = CGRectMake(30+i*frame.size.width, 14, frame.size.width, 20);
            
            //NSLog(@"%.2f=====%.2f=====%.2f",size.width, frame.size.width, i*frame.size.width+30);
            [btn addTarget:self action:@selector(changeSelectedItem:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 1+i;
            [self.titleButtons addObject:btn];
            [_segmentScrollView addSubview:btn];
            
            
            //默认选中第一个按钮
            if (i == 0) {
                btn.selected = YES;
                self.currentSelectedItemImageView.frame = CGRectMake(PADDING, self.segmentScrollView.frame.size.height - 2, btn.frame.size.width, 2);
            }
            
        }
        
        _segmentScrollView.contentSize = CGSizeMake(btnoffset+PADDING, 25);
        
    }
    return _segmentScrollView;
}

// 红色滑动条
- (UIImageView *)currentSelectedItemImageView {
    if (!_currentSelectedItemImageView) {
        _currentSelectedItemImageView = [[UIImageView alloc] init];
        _currentSelectedItemImageView.image = [UIImage imageNamed:@"nar_bgbg.png"];
    }
    return _currentSelectedItemImageView;
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
