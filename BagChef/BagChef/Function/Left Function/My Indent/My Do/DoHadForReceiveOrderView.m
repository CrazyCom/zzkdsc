//
//  DoHadForReceiveOrderView.m
//  BagChef
//
//  Created by zhangzhi on 15/8/10.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "DoHadForReceiveOrderView.h"
#import "DoHadForReceiveOrderViewTableViewCell.h"
#import "PrivateReceivedOrderDetailViewController.h"
@interface DoHadForReceiveOrderView() {
    
    CGRect _frame;
    NSMutableArray *_productList;
    NSMutableArray *_dataSource;
    
    UILabel *numOfLabel;
    UILabel *perAndPrice;
    UILabel *addressOfLabel;
    UILabel *armedPriceOfLabel;
    
    UILabel *totalLabel;
    UILabel *totalOfPriceLabel;
    UILabel *eatOfTimeLabel;
    
    //地址
    UIImageView *positionImageView;

    //时间
    
    NSDateFormatter *fomatter;
    UIImageView *timeImageView;
}

- (void)initialiazeDataSource;
- (void)initializeInterface;
@end
@implementation DoHadForReceiveOrderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)initialiazeDataSource {
    
    _productList = [[NSMutableArray alloc]init];

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
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(_frame) - 59) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];

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
    
    NSArray * array = [[NSArray alloc] initWithArray:_dataSource[section][@"dish_list"]];
    NSLog(@"array:%ld",array.count);
    return array.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CELLID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    
    NSString *doHadCellID = @"doHadCellID";
    DoHadForReceiveOrderViewTableViewCell *doHadForReceiveCell = [tableView dequeueReusableCellWithIdentifier:doHadCellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        totalLabel = [[UILabel alloc]init];
        totalLabel.tag = 5000;
        [cell.contentView addSubview:totalLabel];
        
        totalOfPriceLabel = [[UILabel alloc]init];
        totalOfPriceLabel.tag = 5001;
        [cell.contentView addSubview:totalOfPriceLabel];
        
        positionImageView = [[UIImageView alloc]init];
        positionImageView.tag = 5002;
        [cell.contentView addSubview:positionImageView];
        
        addressOfLabel = [[UILabel alloc]init];
        addressOfLabel.tag = 5003;
        [cell.contentView addSubview:addressOfLabel];
        
        timeImageView = [[UIImageView alloc]init];
        timeImageView.tag = 5004;
        [cell.contentView addSubview:timeImageView];
        
        eatOfTimeLabel = [[UILabel alloc]init];
        eatOfTimeLabel.tag = 5005;
        [cell.contentView addSubview:eatOfTimeLabel];
        
//        UIButton *btn = [[UIButton alloc]init];
//        btn.tag = 70;
//        [cell.contentView addSubview:btn];
    }
    
    //------------
    

    NSArray *array = [[NSArray alloc] initWithArray:_dataSource[indexPath.section][@"dish_list"]];

    for (int i = 0 ; i < array.count; i ++) {
        
      
        
        if (!doHadForReceiveCell) {
            
            doHadForReceiveCell = [[DoHadForReceiveOrderViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:doHadCellID];
            doHadForReceiveCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }

        if (indexPath.row == i) {

            NSDictionary *params = _dataSource[indexPath.section];
            NSArray *dishList = params[@"dish_list"];
            
            if (indexPath.row < dishList.count) {
            
                doHadForReceiveCell.dishOfName.text = dishList[indexPath.row][@"dish_name"];
                doHadForReceiveCell.perAndPrice.text = [NSString stringWithFormat:@"%@元/份", dishList[indexPath.row][@"dish_price"]];
                doHadForReceiveCell.numOfLabel.text = [NSString stringWithFormat:@"x%@", dishList[indexPath.row][@"dish_num"]];
            }

           
        }
        
    }
    if (indexPath.row == array.count) {
        
        totalLabel = (UILabel *)[cell.contentView viewWithTag:5000];
        totalLabel.frame = CGRectMake(10, 12, 80, 20);
        totalLabel.font = [UIFont systemFontOfSize:15];
        totalLabel.text = @"合计";
            
        totalOfPriceLabel = (UILabel *)[cell.contentView viewWithTag:5001];
        totalOfPriceLabel.frame = CGRectMake(ScreenWidth - 100, 12, 90, 20);
        totalOfPriceLabel.font = [UIFont systemFontOfSize:15];
        totalOfPriceLabel.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
        totalOfPriceLabel.text = [NSString stringWithFormat:@"￥%.2lf",[_dataSource[indexPath.section][@"total_price"]doubleValue]];
        totalOfPriceLabel.textAlignment = NSTextAlignmentRight;

        
        positionImageView = (UIImageView *)[cell.contentView viewWithTag:5002];
        [positionImageView setFrame:CGRectMake(CGRectGetMinX(totalLabel.frame), CGRectGetMaxY(totalLabel.frame) + 20, 16 , 16)];
        [positionImageView setImage:[UIImage imageNamed:@"tb4"]];

        
        addressOfLabel = (UILabel *)[cell.contentView viewWithTag:5003];
        [addressOfLabel setFrame:CGRectMake(CGRectGetMaxX(positionImageView.frame) + 8, CGRectGetMaxY(positionImageView.frame) - 11, (ScreenWidth - CGRectGetMaxX(positionImageView.frame) - 8 - 10), 10 )];
        [addressOfLabel setText:[NSString stringWithFormat:@"%@",_dataSource[indexPath.section][@"address"]]];
        [addressOfLabel setFont:[UIFont systemFontOfSize:13]];
        [addressOfLabel setTextColor:[UIColor grayColor]];
        
        
        if (!fomatter) {
            
            fomatter = [[NSDateFormatter alloc] init];
            fomatter.dateFormat = @"yyyy-MM-dd HH:mm";

        }
        
        timeImageView = (UIImageView *)[cell.contentView viewWithTag:5004];
        [timeImageView setFrame:CGRectMake(CGRectGetMinX(positionImageView.frame), CGRectGetMaxY(positionImageView.frame) + 12, 16 , 16 )];
        [timeImageView setImage:[UIImage imageNamed:@"tb5"]];
        
        
        eatOfTimeLabel = (UILabel *)[cell.contentView viewWithTag:5005];
        eatOfTimeLabel.frame = CGRectMake(CGRectGetMaxX(timeImageView.frame) + 8, CGRectGetMaxY(timeImageView.frame) - 11,(ScreenWidth - CGRectGetMaxX(timeImageView.frame) - 8 - 10), 10 );

        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_dataSource[indexPath.section][@"place_time"]doubleValue]];
        [eatOfTimeLabel setText:[fomatter stringFromDate:date]];
        [eatOfTimeLabel setTextColor:[UIColor grayColor]];
        [eatOfTimeLabel setFont:[UIFont systemFontOfSize:13]];
        
//            UILabel *line1 = [[UILabel alloc]init];
//            line1.frame = CGRectMake(10, CGRectGetMaxY(eatOfTimeLabel.frame) + 12, ScreenWidth - 20, 0.5);
//            line1.backgroundColor = [UIColor colorWithRed:0.867f green:0.867f blue:0.867f alpha:1.00f];
//            [cell.contentView addSubview:line1];
            
//            UIButton *btn = (UIButton *)[cell.contentView viewWithTag:70];
//            btn.frame = CGRectMake(50, CGRectGetMaxY(line1.frame) + 6, ScreenWidth - 100, 30);
//            [btn setTitle:@"接单" forState:UIControlStateNormal];
//            [btn setBackgroundImage:[UIImage imageNamed:@"button-dingdan-1"] forState:UIControlStateNormal];
//            
            
            
//        }
    }
    if (indexPath.row < array.count) {
         return doHadForReceiveCell;
    }
    else {
        
        return cell;

    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = _dataSource[indexPath.section][@"dish_list"];
    if (indexPath.row == array.count ) {
        
        return 110;
    }
    return 44;
}

//headerView 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"----");
    PrivateReceivedOrderDetailViewController *vc = [[PrivateReceivedOrderDetailViewController alloc]initWithOrder_num:_dataSource[indexPath.section][@"order_num"]];
    
    DefaultViewController *dvc = (DefaultViewController *)[AppDelegate app].window.rootViewController;
    
    [(UINavigationController *)dvc.ztabBarController.selectedViewController pushViewController:vc animated:YES];
    

}


@end
