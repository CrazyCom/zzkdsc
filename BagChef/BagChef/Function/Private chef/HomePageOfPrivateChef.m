//
//  HomePageOfPrivateChef.m
//  BagChef
//
//  Created by zhangzhi on 15/7/30.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "HomePageOfPrivateChef.h"
#import "HomePageCellOfPrivateChef.h"
#import "ConfirmIndentViewController.h"
@interface HomePageOfPrivateChef ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate> {
    
    
    NSMutableDictionary *_selectedOrderList;        // 已选商品列表 OrderInfo
    
    UITableView *_tableView;
    NSMutableArray *_dishDataSource;
    NSDictionary *_infoDictionarySource;
//    NSMutableArray *_cellDataSource;
    NSMutableDictionary *_cellDataSource;
    int page;
    
    UIView *bottomView ;
    
    UILabel *_numOfAll;
    UILabel *numOfLabel;
    
    UILabel *_priceOfTotal;
    UILabel *priceOfLabel;
    
    BOOL _hasData;
    UIButton *_confirmBtn;
    
    UILabel *_nameLabel; //姓名
    UILabel *_numOfSoldLabel; //已出售份数
   
    NSString *_userId;
    
    
    UIImageView *_headerImageView; //头像
    UIButton *_idBtn; //身份证
    UIButton *_healthBtn;  //健康证
    
    UILabel *sectionLabel;
    
    NSMutableArray *_listArray;
    
    UIAlertView *alertView;
    
}

@property (nonatomic) CGFloat totalPrice;   // 总价
@property (nonatomic) int totalNum;         // 总份数

- (void)initializeDataSource;
- (void)initializeInterface;
@end

@implementation HomePageOfPrivateChef

- (id)initWithUserId:(NSString *)userId{
    
    if (self = [super init]) {
        _userId = userId;
    }
    return self;
}

- (void)initializeDataSource {
    
    _selectedOrderList = [[NSMutableDictionary alloc] init];
    
    page = 1;
    _hasData = NO;
    _dishDataSource = [[NSMutableArray alloc]init];
    _infoDictionarySource = [[NSDictionary alloc]init];
    _cellDataSource = [[NSMutableDictionary alloc]init];
    _listArray = [[NSMutableArray alloc]init];
    [self footRefreshing];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeDataSource];
    [self initializeInterface];
    
    
}

- (void)setTotalPrice:(CGFloat)totalPrice {

    _totalPrice = totalPrice;
    priceOfLabel.text = [NSString stringWithFormat:@"合计：%.2lf元", _totalPrice];
}

- (void)setTotalNum:(int)totalNum {

    _totalNum = totalNum;
    numOfLabel.text = [NSString stringWithFormat:@"共%i份", totalNum];
}

- (void)initializeInterface {
    
    self.view.backgroundColor = [UIColor colorWithRed:0.937f green:0.937f blue:0.957f alpha:1.00f];
    
    self.titleLabel.text = @"私厨主页";
    
    self.leftButton.hidden = NO;
    [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(barButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];
    
    self.rightButton.hidden = NO;
    [self.rightButton setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton.tag = 81;
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 30) style:UITableViewStyleGrouped];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [self.view addSubview:_tableView];
    
    
    //header
    
    
//    UIView *tableHeaderView = [[UIView alloc]init];
//    tableHeaderView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
//    
//    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 140)];
//    headerView.backgroundColor = [UIColor whiteColor];
//    [tableHeaderView addSubview:headerView];
//    
//    
//    
//    
//    _headerImageView = [[UIImageView alloc]init];
//    _headerImageView.frame = CGRectMake(10, 10, 55, 55);
//    _headerImageView.backgroundColor = [UIColor whiteColor];
//    NSString *headerImageUrl = [NSString stringWithFormat:@"http://kdsc.mmqo.com%@",_infoDictionarySource[@"icon"]];
//    [ _headerImageView setImageWithURL:[NSURL URLWithString:headerImageUrl]];
//    [headerView addSubview:_headerImageView];
//    
//    
//    
//    _nameLabel = [[UILabel alloc]init];
//    _nameLabel.frame = CGRectMake(CGRectGetMaxX(_headerImageView.frame) + 10, CGRectGetMinY(_headerImageView.frame), 100, 20);
//    //        _nameLabel.text = @"NULL";
//    _nameLabel.text = _infoDictionarySource[@"nicename"];
//    [headerView addSubview:_nameLabel];
//    
//    
//    
//    
//    //身份证
//    _idBtn = [[UIButton alloc]init];
//    [_idBtn setFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame), CGRectGetMinY(_headerImageView.frame), 30 * ratioX, 15 * ratioY)];
//    [_idBtn setBackgroundColor:[UIColor orangeColor]];
//    [_idBtn setTitle:@"身份证" forState:UIControlStateNormal];
//    _idBtn.titleLabel.font = [UIFont systemFontOfSize:8];
//    [headerView addSubview:_idBtn];
//    
//    //健康证
//    _healthBtn = [[UIButton alloc]init];
//    [_healthBtn setFrame:CGRectMake(CGRectGetMaxX(_idBtn.frame) + 5, CGRectGetMinY(_headerImageView.frame), 30 * ratioX, 15 * ratioY)];
//    [_healthBtn setBackgroundColor:[UIColor orangeColor]];
//    [_healthBtn setTitle:@"健康证" forState:UIControlStateNormal];
//    _healthBtn.titleLabel.font = [UIFont systemFontOfSize:8];
//    
//    [headerView addSubview:_healthBtn];
//    
//    
//    //五星
//    UIImageView *starsImageView ;
//    for (int i = 0; i < 5; i++) {
//        starsImageView = [[UIImageView alloc]init];
//        starsImageView.frame = CGRectMake(CGRectGetMaxX(_headerImageView.frame) + 8 + 18 * i, CGRectGetMaxY(_headerImageView.frame) - 20, 15, 15);
//        [starsImageView setImage:[UIImage imageNamed:@"tb9"]];
//        //        starsImageView.backgroundColor = [UIColor whiteColor];
//        [headerView addSubview:starsImageView];
//    }
//    
//    //已出售份数
//    
//    _numOfSoldLabel = [[UILabel alloc]init];
//    //        _numOfSoldLabel.text = @"0";
//    _numOfSoldLabel.text = _infoDictionarySource[@"sale_num"];
//    UILabel *soldLabel = [[UILabel alloc]init];
//    soldLabel.frame = CGRectMake(CGRectGetMaxX(starsImageView.frame) + 10, CGRectGetMinY(starsImageView.frame), ScreenWidth - CGRectGetMaxX(starsImageView.frame) - 10 - 10, 20);
//    soldLabel.textAlignment = NSTextAlignmentRight;
//    soldLabel.font = [UIFont systemFontOfSize:13];
//    soldLabel.text = [NSString stringWithFormat:@"已售%@份",_numOfSoldLabel.text];
//    [headerView addSubview:soldLabel];
//    
//    
//    
//    //添加横线
//    UILabel *horizontalLine = [[UILabel alloc]init];
//    horizontalLine.frame = CGRectMake(0, CGRectGetMaxY(_headerImageView.frame) + 20, ScreenWidth, 1);
//    horizontalLine.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
//    [headerView addSubview:horizontalLine];
//    
//    for (int i =0; i <3; i++) {
//        UIView *newView = [[UIView alloc]init];
//        newView.frame = CGRectMake(0 + ScreenWidth / 3 * i , CGRectGetMaxY(horizontalLine.frame) + 10, ScreenWidth / 3, 40);
//        //            newView.backgroundColor = [UIColor orangeColor];
//        [headerView addSubview:newView];
//        
//        //添加竖线
//        if (i == 1) {
//            UILabel *verticalLine = [[UILabel alloc]init];
//            verticalLine.frame = CGRectMake(0, 1, 1, 38);
//            verticalLine.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
//            [newView addSubview:verticalLine];
//            
//            UILabel *verticalLine1 = [[UILabel alloc]init];
//            verticalLine1.frame = CGRectMake(ScreenWidth / 3 - 1, 1, 1, 38);
//            verticalLine1.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
//            [newView addSubview:verticalLine1];
//        }
//        
//        UIImageView *newImageView = [[UIImageView alloc]init];
//        newImageView.frame = CGRectMake(10, 10, 18, 18);
//        [newImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tb%d",i + 1]]];
//        [newView addSubview:newImageView];
//        
//        UILabel *newLabel = [[UILabel alloc]init];
//        newLabel.frame = CGRectMake(CGRectGetMaxX(newImageView.frame) + 2, 10, ScreenWidth / 3 - 32, 20);
//        newLabel.font = [UIFont systemFontOfSize:12];
//        newLabel.textAlignment = NSTextAlignmentCenter;
//        newLabel.textColor = [UIColor grayColor];
//        if (i == 0) {
//            //                newLabel.text = @"";
//            newLabel.text = _infoDictionarySource[@"address"];
//        }
//        else if (i == 1) {
//            //                newLabel.text = @"";
//            newLabel.text = [NSString stringWithFormat:@"厨艺%@年",_infoDictionarySource[@"age"]] ;
//        }
//        else if (i == 2) {
//            //                newLabel.text = @"";
//            newLabel.text = [NSString stringWithFormat:@"好评率%@%%",_infoDictionarySource[@"score"]] ;
//        }
//        [newView addSubview:newLabel];
//    }
//    
//    
//    sectionLabel = [[UILabel alloc]init];
//    sectionLabel.frame = CGRectMake(10, 190 - 30 , ScreenWidth, 20);
//    sectionLabel.text = [NSString stringWithFormat:@"%@分享的菜品",_infoDictionarySource[@"nicename"]];
//    sectionLabel.font = [UIFont systemFontOfSize:13];
//    [tableHeaderView addSubview:sectionLabel];
//
//    
//    
//    _tableView.tableHeaderView = tableHeaderView;
//    
//    
//    //header
    
    
    [_tableView addFooterWithTarget:self action:@selector(footRefreshing)];

    
    bottomView = [[UIView alloc]init];
    bottomView.frame = CGRectMake(0, ScreenHeight - 30, ScreenWidth, 30);
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    bottomView.hidden = YES;
    

    numOfLabel = [[UILabel alloc]init];
    numOfLabel.frame = CGRectMake(10, 8, 70, 20);
    numOfLabel.font = [UIFont systemFontOfSize:12];
    [bottomView addSubview:numOfLabel];
    
    self.totalNum = 0;
   
    priceOfLabel = [[UILabel alloc]init];
    priceOfLabel.frame = CGRectMake(CGRectGetMaxX(numOfLabel.frame) + 8, CGRectGetMinY(numOfLabel.frame), 100, 20);
    priceOfLabel.font = [UIFont systemFontOfSize:12];
    [bottomView addSubview:priceOfLabel];
    
    self.totalPrice = 0;
    
    _confirmBtn = [[UIButton alloc]init];
    _confirmBtn.frame = CGRectMake(ScreenWidth - 120 - 10, 3, 120, 24);
    [_confirmBtn setTitle:@"我选好了,确认订单" forState:UIControlStateNormal];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    _confirmBtn.tag = 80;
    [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"button2"] forState:UIControlStateNormal];
    [_confirmBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:_confirmBtn];
}

#pragma mark - btnPressed

- (void)buttonPressed:(UIButton *)sender {
    
    if (sender.tag == 80) {
        
        if (self.totalNum == 0) {
            [DisplayView displayShowWithTitle:@"请选择一个菜品"];
            return;
        }
        
        // 总价
        [_selectedOrderList setObject:@(self.totalPrice)    forKey:kSumPrice];
        [_selectedOrderList setObject:@(self.totalNum)      forKey:kSumNum];
        
        ConfirmIndentViewController *confirmIndentVC = [[ConfirmIndentViewController alloc] init];
        confirmIndentVC.selectedOrderList = _selectedOrderList;
        
        [self.navigationController pushViewController:confirmIndentVC animated:YES];
    }
    else if (sender.tag == 81) {
        
        NSLog(@"12121");
        alertView = [[UIAlertView alloc]initWithTitle:nil message:@"您将收藏此厨师菜品信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
   
}

//tabBarButtonItem
- (void)barButtonItemMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    DefaultViewController *dvc = (DefaultViewController *)[AppDelegate app].window.rootViewController;
    
    [dvc.ztabBarController setHideEsunTabBarBtn:YES];
    [dvc.ztabBarController setHideEsunTabBar:YES];
    
    NSLog(@"armedFram:%@",NSStringFromCGRect(self.view.frame));
}

//数据刷新
- (void)footRefreshing {
    
   
//    
//    NSUserDefaults *defautls = [NSUserDefaults standardUserDefaults];
//    NSString *tel = [defautls objectForKey:@"tel"];
//    NSString *pwd = [defautls objectForKey:@"pwd"];
   
    NSString *userId = _userId;

  
//    NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"page":[NSString stringWithFormat:@"%i",page],@"uid":uid};
    __weak typeof(self)myself = self;
    [myself showLoading];
    [NetWorkHandler chefIndex:@{@"uid":userId,@"page":[NSString stringWithFormat:@"%i",page]} completionHandler:^(id content) {
        
        
        NSLog(@"%@",content);
        [myself hideLoading];
        
       [_tableView footerEndRefreshing];
        
        if (![content isKindOfClass:[NSDictionary class]]) {
            [DisplayView displayShowWithTitle:@"连接超时"];
            
            return ;
        }

        if ([content[@"status"] integerValue] == 1) {
            if ([content[@"data"] isKindOfClass:[NSNull class]]) {
                bottomView.hidden = YES;
                [DisplayView displayShowWithTitle:@"没有多余数据"];
                
                return ;
            }
                

            if ([content[@"data"][@"dish"] isKindOfClass:[NSNull class]]) {
                

                [DisplayView displayShowWithTitle:@"没有多余数据"];
                
                return;
            }
            
            bottomView.hidden = NO;
            _dishDataSource = content[@"data"][@"dish"];
            _infoDictionarySource = content[@"data"][@"info"];
            
            NSLog(@"_dataSource:%@",_infoDictionarySource);
            
            //
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:_infoDictionarySource[@"lat"] forKey:@"lat"];
            [defaults setObject:_infoDictionarySource[@"lon"] forKey:@"lon"];
            [defaults setObject:_infoDictionarySource[@"uid"] forKey:@"chefId"];
            [defaults synchronize];
            page += 1;
            [_tableView reloadData];
        }
            [DisplayView displayShowWithTitle:content[@"info"]];
        
        }];
//    else {
//        
//        [NetWorkHandler chefIndex:@{@"uid":uid} completionHandler:^(id content) {
//            NSLog(@"uid%@",content);
//            bottomView.hidden = NO;
//            if ([content[@"status"] integerValue] == 1) {
//                
//                NSLog(@"dishList:%@",content);
//                for (NSDictionary *dict in content[@"data"]) {
//                    [_dataSource addObject:dict];
//                }
//            }
//            
//            page += 1;
//            [DisplayView displayShowWithTitle:content[@"info"]];
//            [_tableView reloadData];
//            [_tableView footerEndRefreshing];
//            NSLog(@"HomePage%@",content);
//        }];
//    }
//    
//        [NetWorkHandler getChefList:dict completionHandler:^(id content) {
//        
//       
//    }];
//

}


#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dishDataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CELLID = @"cellID";
    HomePageCellOfPrivateChef *homePageCell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    
    if (!homePageCell) {
        homePageCell = [[HomePageCellOfPrivateChef alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
        homePageCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSLog(@"indexPath:%@",_dishDataSource[indexPath.section]);
    
    HomePageModel *model = [[HomePageModel alloc]initWithDicitonary:_dishDataSource[indexPath.section]];
    [homePageCell setCellWithModel:model];
    
//    __unsafe_unretained typeof(self) myself = self;
    [homePageCell setButtonClick:^(HomePageModel *model, int num) {
        

        
        OrderInfo *preOrder = [_selectedOrderList objectForKey:model.ID];
        
        
        if (preOrder) {
            self.totalPrice += [model.price doubleValue] * (num - preOrder.num);
            self.totalNum += num - preOrder.num;
        }
        else {
            self.totalPrice += [model.price doubleValue] * num;
            self.totalNum += num;
        }
        
        if (num == 0) {
            
            [_selectedOrderList removeObjectForKey:model.ID];
            
        }
        else {
            
            OrderInfo *order = [[OrderInfo alloc] init];
            order.name = model.name;
            order.price = [model.price doubleValue];
            order.ID = model.ID;
            order.num = num;
            
            [_selectedOrderList setObject:order forKey:model.ID];
            
        }
        
    }];
    return homePageCell;
}

- (void)clickPlus {

}



//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 315;
}

//tableViewHeader
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 190;
    }
    else {
        
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        UIView *tableHeaderView = [[UIView alloc]init];
        tableHeaderView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
        
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, ScreenWidth, 140)];
        headerView.backgroundColor = [UIColor whiteColor];
        [tableHeaderView addSubview:headerView];
        
       
       
       
        _headerImageView = [[UIImageView alloc]init];
        _headerImageView.frame = CGRectMake(10, 10, 55, 55);
        _headerImageView.backgroundColor = [UIColor whiteColor];
        NSString *headerImageUrl = [NSString stringWithFormat:@"http://kdsc.mmqo.com%@",_infoDictionarySource[@"icon"]];
        [ _headerImageView setImageWithURL:[NSURL URLWithString:headerImageUrl]];
        [headerView addSubview:_headerImageView];
        
        
        
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.frame = CGRectMake(CGRectGetMaxX(_headerImageView.frame) + 10, CGRectGetMinY(_headerImageView.frame), 100, 20);
        //        _nameLabel.text = @"NULL";
        _nameLabel.text = _infoDictionarySource[@"nicename"];
        [headerView addSubview:_nameLabel];

        
        
        
        //身份证
        _idBtn = [[UIButton alloc]init];
        [_idBtn setFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame), CGRectGetMinY(_headerImageView.frame), 30 * ratioX, 15 * ratioY)];
        [_idBtn setBackgroundColor:[UIColor orangeColor]];
        [_idBtn setTitle:@"身份证" forState:UIControlStateNormal];
        _idBtn.titleLabel.font = [UIFont systemFontOfSize:8];
        [headerView addSubview:_idBtn];
        
        //健康证
        _healthBtn = [[UIButton alloc]init];
        [_healthBtn setFrame:CGRectMake(CGRectGetMaxX(_idBtn.frame) + 5, CGRectGetMinY(_headerImageView.frame), 30 * ratioX, 15 * ratioY)];
        [_healthBtn setBackgroundColor:[UIColor orangeColor]];
        [_healthBtn setTitle:@"健康证" forState:UIControlStateNormal];
        _healthBtn.titleLabel.font = [UIFont systemFontOfSize:8];
        
        [headerView addSubview:_healthBtn];
        

        //五星
        UIImageView *starsImageView ;
        for (int i = 0; i < 5; i++) {
            starsImageView = [[UIImageView alloc]init];
            starsImageView.frame = CGRectMake(CGRectGetMaxX(_headerImageView.frame) + 8 + 18 * i, CGRectGetMaxY(_headerImageView.frame) - 20, 15, 15);
            [starsImageView setImage:[UIImage imageNamed:@"tb9"]];
            //        starsImageView.backgroundColor = [UIColor whiteColor];
            [headerView addSubview:starsImageView];
        }
        
        //已出售份数
        
        _numOfSoldLabel = [[UILabel alloc]init];
        //        _numOfSoldLabel.text = @"0";
        _numOfSoldLabel.text = _infoDictionarySource[@"sale_num"];
        UILabel *soldLabel = [[UILabel alloc]init];
        soldLabel.frame = CGRectMake(CGRectGetMaxX(starsImageView.frame) + 10, CGRectGetMinY(starsImageView.frame), ScreenWidth - CGRectGetMaxX(starsImageView.frame) - 10 - 10, 20);
        soldLabel.textAlignment = NSTextAlignmentRight;
        soldLabel.font = [UIFont systemFontOfSize:13];
        soldLabel.text = [NSString stringWithFormat:@"已售%@份",_numOfSoldLabel.text];
        [headerView addSubview:soldLabel];

        
        
        //添加横线
        UILabel *horizontalLine = [[UILabel alloc]init];
        horizontalLine.frame = CGRectMake(0, CGRectGetMaxY(_headerImageView.frame) + 20, ScreenWidth, 1);
        horizontalLine.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
        [headerView addSubview:horizontalLine];
        
        for (int i =0; i <3; i++) {
            UIView *newView = [[UIView alloc]init];
            newView.frame = CGRectMake(0 + ScreenWidth / 3 * i , CGRectGetMaxY(horizontalLine.frame) + 10, ScreenWidth / 3, 40);
//            newView.backgroundColor = [UIColor orangeColor];
            [headerView addSubview:newView];
            
            //添加竖线
            if (i == 1) {
                UILabel *verticalLine = [[UILabel alloc]init];
                verticalLine.frame = CGRectMake(0, 1, 1, 38);
                verticalLine.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
                [newView addSubview:verticalLine];
                
                UILabel *verticalLine1 = [[UILabel alloc]init];
                verticalLine1.frame = CGRectMake(ScreenWidth / 3 - 1, 1, 1, 38);
                verticalLine1.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
                [newView addSubview:verticalLine1];
            }
            
            UIImageView *newImageView = [[UIImageView alloc]init];
            newImageView.frame = CGRectMake(10, 10, 18, 18);
            [newImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tb%d",i + 1]]];
            [newView addSubview:newImageView];
            
            UILabel *newLabel = [[UILabel alloc]init];
            newLabel.frame = CGRectMake(CGRectGetMaxX(newImageView.frame) + 2, 10, ScreenWidth / 3 - 32, 20);
            newLabel.font = [UIFont systemFontOfSize:12];
            newLabel.textAlignment = NSTextAlignmentCenter;
            newLabel.textColor = [UIColor grayColor];
            if (i == 0) {
//                newLabel.text = @"";
                newLabel.text = _infoDictionarySource[@"address"];
            }
            else if (i == 1) {
//                newLabel.text = @"";
                newLabel.text = [NSString stringWithFormat:@"厨艺%@年",_infoDictionarySource[@"age"]] ;
            }
            else if (i == 2) {
//                newLabel.text = @"";
                newLabel.text = [NSString stringWithFormat:@"好评率%@%%",_infoDictionarySource[@"score"]] ;
            }
            [newView addSubview:newLabel];
        }
        
            
        sectionLabel = [[UILabel alloc]init];
        sectionLabel.frame = CGRectMake(10, 190 - 30 , ScreenWidth, 20);
        sectionLabel.text = [NSString stringWithFormat:@"%@分享的菜品",_infoDictionarySource[@"nicename"]];
        sectionLabel.font = [UIFont systemFontOfSize:13];
        [tableHeaderView addSubview:sectionLabel];

        
        
        
        return tableHeaderView;

    }
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        NSLog(@"12");
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *tel = [defaults objectForKey:@"tel"];
        NSString *pwd = [defaults objectForKey:@"pwd"];
        NSString *object_id = _userId;
        NSString *type = @"1";
        NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"type":type,@"object_id":object_id};
        
        [NetWorkHandler manageCollection:dict completionHandler:^(id content) {
            
            NSLog(@"%@",content);
            [DisplayView displayShowWithTitle:content[@"info"]];
            
        }];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    
    NSLog(@"dismiss");
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
