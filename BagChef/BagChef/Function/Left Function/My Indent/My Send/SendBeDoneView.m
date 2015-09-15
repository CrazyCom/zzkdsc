//
//  SendBeDoneView.m
//  BagChef
//
//  Created by zhangzhi on 15/8/10.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "SendBeDoneView.h"
#import "SendBeDoneViewTableViewCell.h"

@interface SendBeDoneView() {
    
    NSMutableArray *_dataSource;
}

@end

@implementation SendBeDoneView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 59) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
    }
    return self;
}


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
    SendBeDoneViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!cell) {
        cell = [[SendBeDoneViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    SendBeSendingViewModel *model = [[SendBeSendingViewModel alloc]initWithDicitonary:_dataSource[indexPath.section]];
    [cell setCellModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200;
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
