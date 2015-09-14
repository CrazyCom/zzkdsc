//
//  LeftMenu.m
//  Bazaar
//
//  Created by zz on 15/7/2.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "LeftMenu.h"

@interface LeftMenu ()<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *_tableView;
    NSDictionary *_dictionary;
}


@end

@implementation LeftMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _tableView = [[UITableView alloc]initWithFrame:frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed:0.267f green:0.267f blue:0.267f alpha:1.00f];
        [_tableView setBounces:NO];
//紧展示有数据的cell的下划线
//        _tableView.tableFooterView = [[UIView alloc]init];
        
//取消cell所有下划线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self addSubview:_tableView];
        
        //注册通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notification:) name:@"personalInformation" object:nil];
    }
    return self;
}

- (void)notification:(NSNotification *)notification {
    
    NSLog(@"%@",notification.userInfo);
    _dictionary = [[NSDictionary alloc]init];
    _dictionary = notification.userInfo;
    [_tableView reloadData];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CELLID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
        cell.backgroundColor = [UIColor colorWithRed:0.267f green:0.267f blue:0.267f alpha:1.00f];

    }
    if (indexPath.row == 0) {
        
        [cell.imageView setImage:[UIImage imageNamed:@"ziliao"]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell.textLabel setText:@"我的资料"];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        
    }
    if (indexPath.row == 1) {
        [cell.imageView setImage:[UIImage imageNamed:@"my_indent"]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell.textLabel setText:@"我的订单"];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
       
    }
    if (indexPath.row == 2) {
        
        [cell.imageView setImage:[UIImage imageNamed:@"shoucang"]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell.textLabel setText:@"我的收藏"];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        
    }
    if (indexPath.row == 3) {
        
        
        [cell.imageView setImage:[UIImage imageNamed:@"my_money"]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell.textLabel setText:@"我的银子"];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        
    }
    if (indexPath.row == 4) {
        [cell.imageView setImage:[UIImage imageNamed:@"my_cupon"]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell.textLabel setText:@"我的优惠券"];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
        
       
    }
    if (indexPath.row == 5) {
        
        [cell.imageView setImage:[UIImage imageNamed:@"about_us"]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell.textLabel setText:@"关于我们"];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    }
    if (indexPath.row == 6) {
     
        [cell.imageView setImage:[UIImage imageNamed:@"complainAndsuggestion"]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell.textLabel setText:@"投诉建议"];
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    }
    
    return cell;
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

//添加headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, move_x, 100)];

    
    
    //头像
    UIImageView *headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 44, 50, 50)];
    [headerImageView setImage:[UIImage imageNamed:@""]];
    
    NSString *url = [NSString stringWithFormat:@"http://kdsc.mmqo.com%@",_dictionary[@"icon"]];
    [headerImageView setImageWithURL:[NSURL URLWithString:url]];
    //
    NSLog(@"%@",url);
    
//    NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//    [headerImageView setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];

    //
    [headerImageView setBackgroundColor:[UIColor whiteColor]];
    [headerView addSubview:headerImageView];
    
    //姓名
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headerImageView.frame) + 8, CGRectGetMinY(headerImageView.frame), move_x - CGRectGetMaxX(headerImageView.frame) - 10, 20)];
//    nameLabel.text = @"吃货的世界";
    nameLabel.text = _dictionary[@"name"];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:nameLabel];

    //五星
    for (int i = 0; i < 5; i++) {
        UIImageView *starsImageView = [[UIImageView alloc]init];
        starsImageView.tag = 100 + i;
        starsImageView.frame = CGRectMake(CGRectGetMaxX(headerImageView.frame) + 8 + 18 * i, CGRectGetMaxY(headerImageView.frame) - 20, 15, 15);
        [starsImageView setImage:[UIImage imageNamed:@"tb9"]];
//        starsImageView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:starsImageView];
    }
    
    
    NSString *score = [NSString stringWithFormat:@"%@",_dictionary[@"score"]];
    [Common  screNumber:score view:self tag:100];

    
    return headerView;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 110;
}

//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    self.send(indexPath.row);
    if ([_delegate respondsToSelector:@selector(leftItermButtonDidSelected:repeat:)]) {
        [_delegate leftItermButtonDidSelected:(int)indexPath.row repeat:NO];
    }
}
@end
