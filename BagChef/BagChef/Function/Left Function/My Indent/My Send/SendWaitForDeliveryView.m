//
//  SendWaitForDeliveryView.m
//  BagChef
//
//  Created by zhangzhi on 15/8/10.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "SendWaitForDeliveryView.h"
#import "SendWaitForDeliveryViewTableViewCell.h"
@interface SendWaitForDeliveryView() {
    
    NSMutableArray *_dataSource;
    CGRect _frame;
}

@end
@implementation SendWaitForDeliveryView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _frame = frame;
        //        [self initializeDataSource];
        [self initializeInterface];
    }
    return self;
}

- (void)initializeInterface {
    
    self.backgroundColor = [UIColor grayColor];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(_frame) - 59) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];
    
}



//- (instancetype)initWithFrame:(CGRect)frame {
//    
//    if (self = [super initWithFrame:frame]) {
//        
//        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 59) style:UITableViewStyleGrouped];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        [self addSubview:_tableView];
//    }
//    return self;
//}


- (void)updateViewWith:(NSMutableDictionary *)params {
    
    _dataSource = [[NSMutableArray alloc] initWithArray:params[@"data"]];
    [_tableView reloadData];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CELLID = @"CellID";
    SendWaitForDeliveryViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!cell) {
        cell = [[SendWaitForDeliveryViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    SendBeSendingViewModel *model = [[SendBeSendingViewModel alloc]initWithDicitonary:_dataSource[indexPath.section]];
    [cell setCellModel:model];

    cell.buttonClick = ^(SendWaitForDeliveryViewTableViewCell *cell) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *pwd = [userDefaults objectForKey:@"pwd"];
        NSString *tel = [userDefaults objectForKey:@"tel"];
        
        NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
        NSString *order_num	 = _dataSource[indexPath.section][@"order_num"];
        NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"order_num":order_num};
        [NetWorkHandler expressSendGuest:dict completionHandler:^(id content) {
            [DisplayView displayShowWithTitle:content[@"info"]];
            NSLog(@"expressSendGuest%@",content);
        }];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 270;
}

//headerView 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}


@end
