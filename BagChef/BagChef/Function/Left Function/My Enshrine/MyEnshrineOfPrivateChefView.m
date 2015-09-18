//
//  MyEnshrineOfPrivateChefView.m
//  BagChef
//
//  Created by zhangzhi on 15/8/11.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "MyEnshrineOfPrivateChefView.h"
#import "MyEnshrineOfPrivateChefViewTableViewCell.h"

@interface MyEnshrineOfPrivateChefView()<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *_tableView;
    CGRect _frame;
    NSMutableArray *_productList;
    NSMutableArray *_dataSource;
    
    int _page;
}

- (void)initializeInterface;
- (void)initialiazeDataSource;

@end


@implementation MyEnshrineOfPrivateChefView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)initialiazeDataSource {
    
    _page = 1;
    _productList = [[NSMutableArray alloc]init];
    _dataSource = [[NSMutableArray alloc]init];
    [self footRefreshing];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _frame = frame;
        [self initialiazeDataSource];
        [self initializeInterface];
    }
    return self;
}

- (void)initializeInterface {
    
    self.backgroundColor = [UIColor grayColor];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(_frame)) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
    //下拉刷新
    [_tableView addFooterWithTarget:self action:@selector(footRefreshing)];
    
    
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CELLID = @"cellID";
    MyEnshrineOfPrivateChefViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!cell) {
        cell = [[MyEnshrineOfPrivateChefViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    MyEnshrineOfPrivateChefModel *model = [[MyEnshrineOfPrivateChefModel alloc]initWithDicitonary:_dataSource[indexPath.section]];
    [cell setCellWithModel:model];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 235;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView= [[UIView alloc]init];
    headerView.frame = CGRectMake(0, 0, ScreenWidth, 10);
    headerView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

//#pragma mark - <数据加载>
//#pragma mark 下拉刷新
//数据刷新
- (void)footRefreshing {
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tel = [defaults objectForKey:@"tel"];
    NSString *pwd = [defaults objectForKey:@"pwd"];
    NSString *page = [NSString stringWithFormat:@"%i",_page];
    NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"page":page};
    
    DisplayView *displayView = [[DisplayView alloc] init];
    [displayView displayShowLoading:self];
    [NetWorkHandler guestChefCollection:dict completionHandler:^(id content){
        
        [displayView displayHideLoading];
        NSLog(@"guestChefCollection%@",content);

        if ([content isKindOfClass:[NSError class]]) {

            [DisplayView displayShowWithTitle:@"连接超时"];
            [_tableView footerEndRefreshing];
            return ;

        }
        else {

            NSLog(@"%@",content);
            if (![content isKindOfClass:[NSDictionary class]]) {
                [DisplayView displayShowWithTitle:@"连接超时"];
                [_tableView footerEndRefreshing];
                return ;
            }
            else  if ([content[@"status"] integerValue] == 1) {

                if ([content[@"data"] isKindOfClass:[NSNull class]]) {

                    [_tableView footerEndRefreshing];
                    [DisplayView displayShowWithTitle:@"没有多余数据"];
                    return ;
                }

                for (NSMutableArray *dict in content[@"data"]) {

                    [_dataSource addObject:dict];

                }

                NSLog(@"_dataSource:%@",_dataSource);
                _page += 1;
                [_tableView reloadData];
            }

            [DisplayView displayShowWithTitle:content[@"info"]];
            [_tableView footerEndRefreshing];
            
        }
    }];

    
}


@end
