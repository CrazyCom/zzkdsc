//
//  EatHadOrderReceivingView.m
//  BagChef
//
//  Created by zhangzhi on 15/8/10.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "EatHadOrderReceivingView.h"
#import "EatHadOrderReceivingViewTableViewCell.h"

@interface EatHadOrderReceivingView() {
    
    CGRect _frame;
    NSMutableArray *_productList;
    NSMutableArray *_dataSource;
    
    UILabel *numOfLabel;
    UILabel *totalOfPrice;
    UILabel *timeOfEat;
    UILabel *timeOfOrder;
}

- (void)initializeInterface;
- (void)initialDataSource;
@end

@implementation EatHadOrderReceivingView

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
        [self initialDataSource];
        [self initializeInterface];
        
        
    }
    return self;
}

- (void)updateViewWith:(NSMutableDictionary *)params {
    
    _dataSource = [[NSMutableArray alloc] initWithArray:params[@"data"]];
    [_tableView reloadData];
}

- (void)initializeInterface {
    
    self.backgroundColor = [UIColor grayColor];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(_frame) - 59) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
}

- (void)initialDataSource {
    
    _productList = [[NSMutableArray alloc] init];
    
//    for (NSString *key in _dataSource) {
//        NSLog(@"%@",key);
//        id object = _dataSource[key];
//        
//        if ([object isKindOfClass:[OrderInfo class]]) {
//            
//            OrderInfo *order = (OrderInfo *)object;
//            
//            [_productList addObject:order];
//            
//            
//        }
//    }
    
//    _productList = [@[@"1",@"2",@"3"] copy];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    _productList = [[NSMutableArray alloc] initWithArray:_dataSource[section][@"dish_list"]];
    return _productList.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CELLID = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    NSString *EatCellId = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    EatHadOrderReceivingViewTableViewCell *eatCell = [tableView dequeueReusableCellWithIdentifier:EatCellId];
    if (!eatCell) {
            eatCell = [[EatHadOrderReceivingViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EatCellId];
            eatCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *params = _dataSource[indexPath.section];
    NSArray *dishList = params[@"dish_list"];
    if (indexPath.row < dishList.count) {
        
        eatCell.dishOfName.text = dishList[indexPath.row][@"dish_name"];
        eatCell.perAndPrice.text = [NSString stringWithFormat:@"%@元/份", dishList[indexPath.row][@"dish_price"]];
        eatCell.numOfLabel.text = [NSString stringWithFormat:@"%@份", dishList[indexPath.row][@"dish_num"]];
    }
//    [eatCell updateCellWith:_productList[indexPath.row]];
    else if (indexPath.row == dishList.count) {
        
        
        numOfLabel = [[UILabel alloc]init];
        numOfLabel.frame = CGRectMake(10, 10, 50, 20);
        numOfLabel.textAlignment = NSTextAlignmentCenter;
        numOfLabel.text = [NSString stringWithFormat:@"共%lu份", (unsigned long)dishList.count];
        numOfLabel.font = [UIFont systemFontOfSize:14];
        [eatCell.contentView addSubview:numOfLabel];
        
        totalOfPrice = [[UILabel alloc]init];
        totalOfPrice.frame = CGRectMake(CGRectGetMaxX(numOfLabel.frame) + 10, 10, ScreenWidth -CGRectGetMaxX(numOfLabel.frame) - 10 - 10, 20);
        totalOfPrice.textAlignment = NSTextAlignmentRight;
        totalOfPrice.text = [NSString stringWithFormat:@"合计 ￥%.2lf(含镖费 ￥%.2lf)", [params[@"total_price"] doubleValue], [params[@"express_price"] doubleValue]];
        totalOfPrice.font = [UIFont systemFontOfSize:14];
        [eatCell.contentView addSubview:totalOfPrice];
        

        
        UILabel *line = [[UILabel alloc]init];
        line.frame = CGRectMake(10, CGRectGetMaxY(totalOfPrice.frame) + 12, ScreenWidth - 20, 0.5);
        line.backgroundColor = [UIColor colorWithRed:0.784f green:0.780f blue:0.800f alpha:1.00f];
        [eatCell.contentView addSubview:line];
        
        
        
        eatCell.numOfLabel.hidden = YES;
        eatCell.dishOfName.hidden = YES;
        eatCell.perAndPrice.hidden = YES;
       
    }
    if (indexPath.row == dishList.count + 1) {
        
        
        NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
        fomatter.dateFormat = @"yyyy-MM-dd HH:mm";
         
        UILabel *timeEatLabel = [[UILabel alloc]init];
        timeEatLabel.frame = CGRectMake(10,10, 80, 20);
        timeEatLabel.text = @"吃饭时间";
        timeEatLabel.textColor = [UIColor grayColor];
        timeEatLabel.font = [UIFont systemFontOfSize:12];
        [eatCell.contentView addSubview:timeEatLabel];
        
        
        timeOfEat = [[UILabel alloc]init];
        timeOfEat.frame = CGRectMake(CGRectGetMaxX(timeEatLabel.frame), 10, 120, 20);
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[params[@"place_time"] doubleValue]];
        timeOfEat.text = [fomatter stringFromDate:date];
        timeOfEat.textColor = [UIColor grayColor];
        timeOfEat.font = [UIFont systemFontOfSize:12];
        [eatCell.contentView addSubview:timeOfEat];
        
        UILabel *timeOrderLabel = [[UILabel alloc]init];
        timeOrderLabel.frame = CGRectMake(10, CGRectGetMaxY(timeOfEat.frame) + 10 , 80, 20);
        timeOrderLabel.text = @"下单时间";
        timeOrderLabel.textColor = [UIColor grayColor];
        timeOrderLabel.font = [UIFont systemFontOfSize:12];
        [eatCell.contentView addSubview:timeOrderLabel];
        
        
        timeOfOrder = [[UILabel alloc]init];
        timeOfOrder.frame = CGRectMake(CGRectGetMaxX(timeOrderLabel.frame), CGRectGetMaxY(timeOfEat.frame) + 10 , 120, 20);
        date = [NSDate dateWithTimeIntervalSince1970:[params[@"order_time"] doubleValue]];
        timeOfOrder.text = [fomatter stringFromDate:date];
        timeOfOrder.textColor = [UIColor grayColor];
        timeOfOrder.font = [UIFont systemFontOfSize:12];
        [eatCell.contentView addSubview:timeOfOrder];
        
        
        UIButton *sendBtn = [[UIButton alloc]init];
        sendBtn.frame = CGRectMake(ScreenWidth - 100, CGRectGetMinY(timeEatLabel.frame) + 12, 90, 30);
        [sendBtn setBackgroundImage:[UIImage imageNamed:@"button2"] forState:UIControlStateNormal];
        [sendBtn setTitle:@"餐已送出" forState:UIControlStateNormal];
        [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [eatCell.contentView addSubview:sendBtn];

        
        eatCell.numOfLabel.hidden = YES;
        eatCell.dishOfName.hidden = YES;
        eatCell.perAndPrice.hidden = YES;

    }
    
    return eatCell;



}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = [[NSArray alloc] initWithArray:_dataSource[indexPath.section][@"dish_list"]];
    if (indexPath.row == array.count + 1) {
        
        return 68;
    }
    return 44;
}

//headerView 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
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
