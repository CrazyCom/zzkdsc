//
//  EatHadOverBookView.m
//  BagChef
//
//  Created by zhangzhi on 15/8/10.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "EatHadOverBookView.h"
#import "EatHadOverBookTableViewCell.h"
#import "OrderDetailViewController.h"
#import "GourmetViewController.h"

@interface EatHadOverBookView ()<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *_tableView;
    CGRect _frame;
    NSMutableArray *_productList;
    NSMutableArray *_dataSource;

    
   
    
    UILabel *telLabel;
    UILabel *telOfLabel;
    
    UILabel *addressLabel;
    UILabel *addressOfLabel;
    
    UILabel *armedLabel;
    UILabel *armedPriceOfLabel;
    
    UILabel *totalLabel;
    UILabel *totalOfPrice;
    
//    UILabel *dishNameOfLabel;
//    UILabel *numOfLabel;
//    UILabel *perAndPrice;
    

   
}

@end

@implementation EatHadOverBookView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (instancetype)initWithFrame:(CGRect)frame {
//    
//    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor grayColor];
//        
//        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(frame) - 59) style:UITableViewStyleGrouped];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        [self addSubview:_tableView];
//    }
//    return self;
//}
//
//- (void)updateViewWith:(NSMutableDictionary *)params {
//
//    _dataSource = [[NSMutableArray alloc] initWithArray:params[@"data"]];
//    [_tableView reloadData];
//}
//
//#pragma mark - UITableViewDelegate,UITableViewDataSource
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    return _dataSource.count;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    return 1;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    static NSString *CELLID = @"CellID";
//    EatHadOverBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
//    if (!cell) {
//        cell = [[EatHadOverBookTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    [cell setCellModel:_dataSource[indexPath.section]];
//    return cell;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return 256;
//}
//
////headerView 高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//    return 10;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    UIView *headerView = [[UIView alloc]init];
//    headerView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
//    return headerView;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    
//    return 0.1;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    NSLog(@"----");
//    OrderDetailViewController *vc = [[OrderDetailViewController alloc]init];
//    
//    DefaultViewController *dvc = (DefaultViewController *)[AppDelegate app].window.rootViewController;
//    [dvc.ztabBarController.viewControllers[0] pushViewController:vc animated:YES];
//}

//-(void)initializeDataSource {
//    
//    _productList = [[NSMutableArray alloc]init];
//    _dataSource = [[NSMutableArray alloc]init];
//    //    _productList = [@[@"1",@"2"] copy];
//}
//
//
//- (instancetype)initWithFrame:(CGRect)frame {
//    
//    if (self = [super initWithFrame:frame]) {
//        
//        _frame = frame;
//        [self initializeDataSource];
//        [self initializeInterface];
//    }
//    return self;
//}
//
//- (void)initializeInterface {
//    
//    self.backgroundColor = [UIColor grayColor];
//    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(_frame) - 59) style:UITableViewStyleGrouped];;
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    [self addSubview:_tableView];
//    
//}
//
//- (void)updateViewWith:(NSMutableDictionary *)params {
//    
//    _dataSource = [[NSMutableArray alloc] initWithArray:params[@"data"]];
//    [_tableView reloadData];
//}
//
//
//#pragma mark - UITableViewDelegate,UITableViewDataSource
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    return _dataSource.count;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    NSArray *array = [[NSArray alloc] initWithArray:_dataSource[section][@"dish_list"]];
//    return array.count + 3;
//    //    if (section == 0) {
//    //
//    //         return _productList.count + 3;
//    //    }
//    //
//    //    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//    NSString *CELLID = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
//    
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        telLabel = [[UILabel alloc]init];
//        telLabel.tag = 5000;
//        [cell.contentView addSubview:telLabel];
//        
//        telOfLabel = [[UILabel alloc]init];
//        telOfLabel.tag = 5001;
//        [cell.contentView addSubview:telOfLabel];
//        
//        addressLabel = [[UILabel alloc]init];
//        addressLabel.tag = 5002;
//        [cell.contentView addSubview:addressLabel];
//        
//        addressOfLabel = [[UILabel alloc]init];
//        addressOfLabel.tag = 5003;
//        [cell.contentView addSubview:addressOfLabel];
//        
//        armedLabel = [[UILabel alloc]init];
//        armedLabel.tag = 5004;
//        [cell.contentView addSubview:armedLabel];
//        
//        armedPriceOfLabel = [[UILabel alloc]init];
//        armedPriceOfLabel.tag = 5005;
//        [cell.contentView addSubview:armedPriceOfLabel];
//        
//        totalLabel = [[UILabel alloc]init];
//        totalLabel.tag = 5006;
//        [cell.contentView addSubview:totalLabel];
//        
//        totalOfPrice = [[UILabel alloc]init];
//        totalOfPrice.tag = 5007;
//        [cell.contentView addSubview:totalOfPrice];
//
//
//    }
//    
//    
//    //------------
//    NSArray *array = [[NSArray alloc] initWithArray:_dataSource[indexPath.section][@"dish_list"]];
//    NSLog(@"count:%ld",array.count );
//    for (int i = 0 ; i < array.count; i ++) {
//        
//        if (indexPath.row == i) {
//            
//            EatHadOverBookTableViewCell *eatHadOverBookCell = [tableView dequeueReusableCellWithIdentifier:@"eatHadOverBookCell"];
//            
//            if (!eatHadOverBookCell) {
//                
//                eatHadOverBookCell = [[EatHadOverBookTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"eatHadOverBookCell"];
//                eatHadOverBookCell.selectionStyle = UITableViewCellSelectionStyleNone;
//                
//            }
//
//            NSDictionary *params = _dataSource[indexPath.section];
//            NSArray *dishList = params[@"dish_list"];
//            
//            if (indexPath.row < dishList.count) {
//                
//                eatHadOverBookCell.dishOfName.text = dishList[indexPath.row][@"dish_name"];
//                eatHadOverBookCell.perAndPrice.text = [NSString stringWithFormat:@"%@元/份", dishList[indexPath.row][@"dish_price"]];
//                eatHadOverBookCell.numOfLabel.text = [NSString stringWithFormat:@"%@份", dishList[indexPath.row][@"dish_num"]];
//            }
//            
//            return eatHadOverBookCell;
//        }
//        
//    }
//    if (indexPath.row == array.count) {
//        
//        
//        
//        
//        
//        telLabel = (UILabel *)[cell.contentView viewWithTag:5000];
//        telLabel.frame = CGRectMake(12, 10, 80, 20);
//        telLabel.font = [UIFont systemFontOfSize:14];
//        telLabel.text = @"电      话";
//        [cell.contentView addSubview:telLabel];
//        
//        telOfLabel = (UILabel *)[cell.contentView viewWithTag:5001];
//        telOfLabel.frame = CGRectMake(CGRectGetMaxX(telLabel.frame), CGRectGetMinY(telLabel.frame), ScreenWidth - 10 - CGRectGetMaxX(telLabel.frame), 21);
//        telOfLabel.font = [UIFont systemFontOfSize:15];
//        telOfLabel.text = @"";
//        telOfLabel.text = _dataSource[indexPath.section][@"phone"];
//        [cell.contentView addSubview:telOfLabel];
//
//        
//        
//        
//        
////        freightOfLabel = (UILabel *)[cell.contentView viewWithTag:5001];
////        freightOfLabel.frame = CGRectMake(ScreenWidth - 120, 12, 110, 20);
////        freightOfLabel.textAlignment = NSTextAlignmentRight;
////        freightOfLabel.textColor = [UIColor grayColor];
////        freightOfLabel.font = [UIFont systemFontOfSize:14];
////        freightOfLabel.text = [NSString stringWithFormat:@"￥%.2lf",[_dataSource[indexPath.section][@"express_price"]doubleValue]];
//        
//        
//        
//        
//    }
//    else if (indexPath.row == array.count + 1) {
//        
//        addressLabel = (UILabel *)[cell.contentView viewWithTag:5002];
//        addressLabel.frame = CGRectMake(12, 10, 80, 20);
//        addressLabel.font = [UIFont systemFontOfSize:14];
//        addressLabel.text = @"送餐地址";
//        [cell.contentView addSubview:addressLabel];
//        
//        addressOfLabel = (UILabel *)[cell.contentView viewWithTag:5003];
//        addressOfLabel.frame = CGRectMake(CGRectGetMaxX(addressLabel.frame), CGRectGetMinY(addressLabel.frame), ScreenWidth - 10 - CGRectGetMaxX(addressLabel.frame), 21);
//        addressOfLabel.font = [UIFont systemFontOfSize:14];
//        addressOfLabel.text = _dataSource[indexPath.section][@"b_address"];
//        [cell.contentView addSubview:addressOfLabel];
//
//        
//        totalPriceLabel = (UILabel *)[cell.contentView viewWithTag:5002];
//        totalPriceLabel.frame = CGRectMake(12, 10, 80, 20);
//        totalPriceLabel.font = [UIFont systemFontOfSize:15];
//        totalPriceLabel.textColor = [UIColor grayColor];
//        totalPriceLabel.text = @"合计";
//        
//        
//        
//        
//        
//        totalPriceOfLabel = (UILabel *)[cell.contentView viewWithTag:5003];
//        totalPriceOfLabel.frame = CGRectMake(ScreenWidth - 120, 12, 110, 20);
//        totalPriceOfLabel.textAlignment = NSTextAlignmentRight;
//        totalPriceOfLabel.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
//        totalPriceOfLabel.font = [UIFont systemFontOfSize:14];
//        totalPriceOfLabel.text = [NSString stringWithFormat:@"￥%.2lf",[_dataSource[indexPath.section][@"total_price"]doubleValue]];
//        
//
//        
//        
//    }
//    else if (indexPath.row == array.count + 2) {
//        
//        
//        armedLabel = (UILabel *)[cell.contentView viewWithTag:5004];
//        armedLabel.frame = CGRectMake(12, 10, 80, 20);
//        armedLabel.font = [UIFont systemFontOfSize:14];
//        armedLabel.text = @"配 送 费";
//        [cell.contentView addSubview:armedLabel];
//        
//        armedPriceOfLabel = (UILabel *)[cell.contentView viewWithTag:5005];
//        armedPriceOfLabel.frame = CGRectMake(CGRectGetMaxX(armedLabel.frame), CGRectGetMinY(armedLabel.frame), ScreenWidth - 10 - CGRectGetMaxX(armedLabel.frame), 21);
//        armedPriceOfLabel.font = [UIFont systemFontOfSize:14];
//        armedPriceOfLabel.text = _dataSource[indexPath.section][@"express_price"];
//        [cell.contentView addSubview:armedPriceOfLabel];
//        
//    }
//    else if (indexPath.row == array.count + 3) {
//        
//        totalLabel = (UILabel *)[cell.contentView viewWithTag:5006];
//        totalLabel.frame = CGRectMake(12, 10, 80, 20);
//        totalLabel.font = [UIFont systemFontOfSize:14];
//        totalLabel.text = @"合     计";
//        [cell.contentView addSubview:totalLabel];
//        
//        totalOfPrice = (UILabel *)[cell.contentView viewWithTag:5007];
//        totalOfPrice.frame = CGRectMake(CGRectGetMaxX(totalLabel.frame), CGRectGetMinY(totalLabel.frame), ScreenWidth - 10 - CGRectGetMaxX(totalLabel.frame), 21);
//        totalOfPrice.font = [UIFont systemFontOfSize:14];
//        totalOfPrice.text = _dataSource[indexPath.section][@"total_price"];
//        [cell.contentView addSubview:totalOfPrice];
//    }
//    
//    return cell;
//}
//
////headerView 高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//    return 10;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    UIView *headerView = [[UIView alloc]init];
//    headerView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
//    return headerView;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    
//    return 0.1;
//}
//
//
//- (void)buttonPressed:(UIButton *)sender {
//    
//    NSLog(@"sender:%li",sender.tag);
//}

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
    
    _dataSource = [[NSMutableArray alloc] init];
    
    if (VALID_ARRAY(params[@"data"])) {
        [_dataSource addObjectsFromArray:params[@"data"]];
    }
    [_tableView reloadData];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    NSArray * array = [[NSArray alloc] initWithArray:_dataSource[section][@"dish_list"]];
    NSLog(@"array:%ld",array.count);
    return array.count + 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CELLID = [NSString stringWithFormat:@"%li,%li",indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];

    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        telLabel = [[UILabel alloc]init];
        telLabel.tag = 5000;
        [cell.contentView addSubview:telLabel];
        
        telOfLabel = [[UILabel alloc]init];
        telOfLabel.tag = 5001;
        [cell.contentView addSubview:telOfLabel];
        
        addressLabel = [[UILabel alloc]init];
        addressLabel.tag = 5002;
        [cell.contentView addSubview:addressLabel];
        
        addressOfLabel = [[UILabel alloc]init];
        addressOfLabel.tag = 5003;
        [cell.contentView addSubview:addressOfLabel];
        
        armedLabel = [[UILabel alloc]init];
        armedLabel.tag = 5004;
        [cell.contentView addSubview:armedLabel];
        
        armedPriceOfLabel = [[UILabel alloc]init];
        armedPriceOfLabel.tag = 5005;
        [cell.contentView addSubview:armedPriceOfLabel];
        
        totalLabel = [[UILabel alloc]init];
        totalLabel.tag = 5006;
        [cell.contentView addSubview:totalLabel];
        
        totalOfPrice = [[UILabel alloc]init];
        totalOfPrice.tag = 5007;
        [cell.contentView addSubview:totalOfPrice];
    
    }
    
    NSArray *array = [[NSArray alloc] initWithArray:_dataSource[indexPath.section][@"dish_list"]];
    
    for (int i = 0 ; i < array.count; i ++) {
        
        if (indexPath.row == i) {
            
            NSString *eatHadOverBookCellID = @"eatHadOverBookCellID";
            EatHadOverBookTableViewCell *eatHadOverBookCell = [tableView dequeueReusableCellWithIdentifier:eatHadOverBookCellID];
            
            if (!eatHadOverBookCell) {
                
                eatHadOverBookCell = [[EatHadOverBookTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:eatHadOverBookCellID];
                eatHadOverBookCell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }


            NSDictionary *params = _dataSource[indexPath.section];
            
            NSArray *dishList = VALID_ARRAY(params[@"dish_list"]) ? params[@"dish_list"] : nil;

            if (indexPath.row < dishList.count) {
    
                
                eatHadOverBookCell.dishOfName.text = dishList[indexPath.row][@"dish_name"];
                
                eatHadOverBookCell.perAndPrice.text = [NSString stringWithFormat:@"%@元/份", dishList[indexPath.row][@"dish_price"]];
                
                eatHadOverBookCell.numOfLabel.text = [NSString stringWithFormat:@"%@份", dishList[indexPath.row][@"dish_num"]];
            }
        
            return eatHadOverBookCell;
            
        }
    }
    if (indexPath.row == array.count) {

        telLabel = (UILabel *)[cell.contentView viewWithTag:5000];
        telLabel.frame = CGRectMake(12, 10, 80, 20);
        telLabel.font = [UIFont systemFontOfSize:14];
        telLabel.text = @"电      话";


        telOfLabel = (UILabel *)[cell.contentView viewWithTag:5001];
        telOfLabel.frame = CGRectMake(CGRectGetMaxX(telLabel.frame), CGRectGetMinY(telLabel.frame), ScreenWidth - 10 - CGRectGetMaxX(telLabel.frame), 21);
        telOfLabel.font = [UIFont systemFontOfSize:15];
        telOfLabel.text = @"";
        telOfLabel.text = _dataSource[indexPath.section][@"phone"];



    }
    else if (indexPath.row == array.count + 1) {

        addressLabel = (UILabel *)[cell.contentView viewWithTag:5002];
        addressLabel.frame = CGRectMake(12, 10, 80, 20);
        addressLabel.font = [UIFont systemFontOfSize:14];
        addressLabel.text = @"送餐地址";

        addressOfLabel = (UILabel *)[cell.contentView viewWithTag:5003];
        addressOfLabel.frame = CGRectMake(CGRectGetMaxX(addressLabel.frame), CGRectGetMinY(addressLabel.frame), ScreenWidth - 10 - CGRectGetMaxX(addressLabel.frame), 21);
        addressOfLabel.font = [UIFont systemFontOfSize:14];
        addressOfLabel.text = _dataSource[indexPath.section][@"b_address"];


    }
    else if (indexPath.row == array.count + 2) {


        armedLabel = (UILabel *)[cell.contentView viewWithTag:5004];
        armedLabel.frame = CGRectMake(12, 10, 80, 20);
        armedLabel.font = [UIFont systemFontOfSize:14];
        armedLabel.text = @"配 送 费";


        armedPriceOfLabel = (UILabel *)[cell.contentView viewWithTag:5005];
        armedPriceOfLabel.frame = CGRectMake(CGRectGetMaxX(armedLabel.frame), CGRectGetMinY(armedLabel.frame), ScreenWidth - 10 - CGRectGetMaxX(armedLabel.frame), 21);
        armedPriceOfLabel.font = [UIFont systemFontOfSize:14];
        armedPriceOfLabel.text = _dataSource[indexPath.section][@"express_price"];


    }
    else if (indexPath.row == array.count + 3) {

        totalLabel = (UILabel *)[cell.contentView viewWithTag:5006];
        totalLabel.frame = CGRectMake(12, 10, 80, 20);
        totalLabel.font = [UIFont systemFontOfSize:14];
        totalLabel.text = @"合     计";

        totalOfPrice = (UILabel *)[cell.contentView viewWithTag:5007];
        totalOfPrice.frame = CGRectMake(CGRectGetMaxX(totalLabel.frame), CGRectGetMinY(totalLabel.frame), ScreenWidth - 10 - CGRectGetMaxX(totalLabel.frame), 21);
        totalOfPrice.font = [UIFont systemFontOfSize:14];
        totalOfPrice.text = _dataSource[indexPath.section][@"total_price"];

    }


    //-------------------------------------------------------------------------
//    if (indexPath.row == array.count) {
//        
//        totalLabel = (UILabel *)[cell.contentView viewWithTag:5000];
//        totalLabel.frame = CGRectMake(10, 12, 80, 20);
//        totalLabel.font = [UIFont systemFontOfSize:15];
//        totalLabel.text = @"合计";
//        
//        totalOfPriceLabel = (UILabel *)[cell.contentView viewWithTag:5001];
//        totalOfPriceLabel.frame = CGRectMake(ScreenWidth - 100, 12, 90, 20);
//        totalOfPriceLabel.font = [UIFont systemFontOfSize:15];
//        totalOfPriceLabel.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
//        totalOfPriceLabel.text = [NSString stringWithFormat:@"￥%.2lf",[_dataSource[indexPath.section][@"total_price"]doubleValue]];
//        totalOfPriceLabel.textAlignment = NSTextAlignmentRight;
//        
//        
//        positionImageView = (UIImageView *)[cell.contentView viewWithTag:5002];
//        [positionImageView setFrame:CGRectMake(CGRectGetMinX(totalLabel.frame), CGRectGetMaxY(totalLabel.frame) + 20, 16 , 16)];
//        [positionImageView setImage:[UIImage imageNamed:@"tb4"]];
//        
//        
//        addressOfLabel = (UILabel *)[cell.contentView viewWithTag:5003];
//        [addressOfLabel setFrame:CGRectMake(CGRectGetMaxX(positionImageView.frame) + 8, CGRectGetMaxY(positionImageView.frame) - 11, (ScreenWidth - CGRectGetMaxX(positionImageView.frame) - 8 - 10), 10 )];
//        [addressOfLabel setText:[NSString stringWithFormat:@"%@",_dataSource[indexPath.section][@"address"]]];
//        [addressOfLabel setFont:[UIFont systemFontOfSize:13]];
//        [addressOfLabel setTextColor:[UIColor grayColor]];
//        
//        
//        if (!fomatter) {
//            
//            fomatter = [[NSDateFormatter alloc] init];
//            fomatter.dateFormat = @"yyyy-MM-dd HH:mm";
//            
//        }
//        
//        timeImageView = (UIImageView *)[cell.contentView viewWithTag:5004];
//        [timeImageView setFrame:CGRectMake(CGRectGetMinX(positionImageView.frame), CGRectGetMaxY(positionImageView.frame) + 12, 16 , 16 )];
//        [timeImageView setImage:[UIImage imageNamed:@"tb5"]];
//        
//        
//        eatOfTimeLabel = (UILabel *)[cell.contentView viewWithTag:5005];
//        eatOfTimeLabel.frame = CGRectMake(CGRectGetMaxX(timeImageView.frame) + 8, CGRectGetMaxY(timeImageView.frame) - 11,(ScreenWidth - CGRectGetMaxX(timeImageView.frame) - 8 - 10), 10 );
//        
//        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_dataSource[indexPath.section][@"place_time"]doubleValue]];
//        [eatOfTimeLabel setText:[fomatter stringFromDate:date]];
//        [eatOfTimeLabel setTextColor:[UIColor grayColor]];
//        [eatOfTimeLabel setFont:[UIFont systemFontOfSize:13]];
//        
//        //            UILabel *line1 = [[UILabel alloc]init];
//        //            line1.frame = CGRectMake(10, CGRectGetMaxY(eatOfTimeLabel.frame) + 12, ScreenWidth - 20, 0.5);
//        //            line1.backgroundColor = [UIColor colorWithRed:0.867f green:0.867f blue:0.867f alpha:1.00f];
//        //            [cell.contentView addSubview:line1];
//        
//        //            UIButton *btn = (UIButton *)[cell.contentView viewWithTag:70];
//        //            btn.frame = CGRectMake(50, CGRectGetMaxY(line1.frame) + 6, ScreenWidth - 100, 30);
//        //            [btn setTitle:@"接单" forState:UIControlStateNormal];
//        //            [btn setBackgroundImage:[UIImage imageNamed:@"button-dingdan-1"] forState:UIControlStateNormal];
//        //
//        
//        
//        //        }
//    }
            return cell;
        
    }
    


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
    OrderDetailViewController *vc = [[OrderDetailViewController alloc]initWithOrder_num:_dataSource[indexPath.section][@"order_num"]];
    
    DefaultViewController *dvc = (DefaultViewController *)[AppDelegate app].window.rootViewController;
    [(UINavigationController *)dvc.ztabBarController.selectedViewController pushViewController:vc animated:YES];
}

@end
