//
//  MenuListOfDetailViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/8/4.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "MenuListOfDetailViewController.h"
#import "ZAdvertisementView.h"
#import "MenuListCellOfComment.h"
#import "ConfirmIndentViewController.h"
#import "ADLoopView.h"
#import "NSString+TextSize.h"
#import "ADScrollView.h"

@interface MenuListOfDetailViewController () <UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIAlertViewDelegate> {
    
    UITableView *_tableView;
   
    
    NSString *_dishId;
    
    NSDictionary *_dictionarySource;
    
   
    UILabel *_classifyNameOfLabel;  //分类名字
    
    UILabel *_numberOfSold; //销售份数
    UILabel *soldLabel;
    
    UIImageView *_adView; //菜品图片
    
    UILabel *timeLabel;
    
    float height;
    
    NSMutableDictionary *_selectedOrderList;        // 已选商品列表 OrderInfo

    UIAlertView *alertView;
    
    NSArray * _commentArray;
    
    int flag;
}
@property (nonatomic,retain) ADLoopView *adLoopView;

@property (nonatomic , strong) ADScrollView *adScrollView;

- (void)initializeDataSource;
- (void)initializeInterface;
@end

@implementation MenuListOfDetailViewController

- (id)initWithDishId:(NSString *)dishId {
    
    if (self = [super init]) {
        _dishId = dishId;
        _dictionarySource = [[NSDictionary alloc]init];
        _selectedOrderList = [[NSMutableDictionary alloc]init];
        
    }
    return self;
}

- (void)initializeDataSource {
    
    __weak typeof(self)myself = self;
    
    [myself showLoading];

    [NetWorkHandler getDishInfo:@{@"dish_id":_dishId} completionHandler:^(id content) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"%@",content);
            [myself hideLoading];
            if ([content[@"status"] integerValue] == 1) {
                if ([content[@"data"] isKindOfClass:[NSNull class]]) {
                    
                    [DisplayView displayShowWithTitle:@"没有多余数据"];
                    return ;
                }
                _dictionarySource = content[@"data"];
                NSLog(@"_dictionarySource:%@",_dictionarySource);
                
                //头像
                
                NSString *url_headerImage = _dictionarySource[@"chef"][@"icon"];
                [_headerImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://kdsc.mmqo.com%@",url_headerImage]]];
                //            NSData *headerImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://kdsc.mmqo.com%@",url_headerImage]]];
                //            [_headerImageView setImage:[UIImage imageWithData:headerImageData]];
                
                //菜品名称
                [_classifyNameOfLabel setText:_dictionarySource[@"dish"][@"name"]];
                
                
                //菜品图片
                if (![_dictionarySource[@"dish"][@"pic"] isKindOfClass:[NSNull class]]) {
                    NSString *url_dishImage = _dictionarySource[@"dish"][@"pic"][0][@"path"];
                    [_adView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://kdsc.mmqo.com%@",url_dishImage]]];
                    
                    
//                    //modify
//                    _adView.contentMode = UIViewContentModeScaleAspectFit;
//                    _adView.clipsToBounds = YES;
                    
                    [_adView addSubview:self.adLoopView];
                    
                    
//                    _adScrollView = [ADScrollView adScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(_adView.bounds), CGRectGetHeight(_adView.bounds)) block:^{
//                        
//                    }];
//                    _adScrollView.dataSource = [_dictionarySource[@"dish"][@"pic"] mutableCopy];
//                    [_adView addSubview:_adScrollView];
                }
                
                //厨师名字
                [_nameLabel setText:_dictionarySource[@"chef"][@"nicename"]];
                
                //价格
                [_priceLabel setText:_dictionarySource[@"dish"][@"price"]];
                
                
                //地址
                [ _positionLabel setText:_dictionarySource[@"chef"][@"address"]];
                
                if ([_dictionarySource[@"dish"][@"content"] isKindOfClass:[NSNull class]]) {
                    [_textView setText:@"暂无菜品介绍"];
                    [_textView setTextAlignment:NSTextAlignmentCenter];
                    
                    _textView.textColor = [UIColor grayColor];
                    _textView.font = [UIFont systemFontOfSize:12];
                    height = 10;
                }
                else {
                    
                    _textView.frame = CGRectMake(10, 5, ScreenWidth - 20, [NSString getTextHeightWithFont:[UIFont systemFontOfSize:16] forWidth:ScreenWidth - 20 text:_dictionarySource[@"dish"][@"content"]]);
                    _textView.text = _dictionarySource[@"dish"][@"content"];
                    _textView.textColor = [UIColor grayColor];
                    _textView.font = [UIFont systemFontOfSize:12];
                }
                
                if ([_dictionarySource[@"comment"] isKindOfClass:[NSArray class]]) {
                    _commentArray = _dictionarySource[@"comment"];
                }
                
                [_tableView reloadData];
            }
            [DisplayView displayShowWithTitle:content[@"info"]];
            
        
        });
        
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    flag = 0;
    // Do any additional setup after loading the view.
    [self initializeInterface];
    [self initializeDataSource];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    DefaultViewController *dvc = (DefaultViewController *)[AppDelegate app].window.rootViewController;
    
    [dvc.ztabBarController setHideEsunTabBarBtn:YES];
    [dvc.ztabBarController setHideEsunTabBar:YES];
    
    NSLog(@"armedFram:%@",NSStringFromCGRect(self.view.frame));
}



- (void)initializeInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.leftButton.hidden = NO;
    self.titleLabel.text = @"菜品详情";
    [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(barButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];
    
    self.rightButton.hidden = NO;
    [self.rightButton setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton.tag = 81;
    

    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [self.view addSubview:_tableView];
    
   }

#pragma mark - btnMethod
- (void)buttonPressed:(UIButton *)sender {

    if (sender.tag == 80) {
        
        OrderInfo *order = [[OrderInfo alloc] init];
        order.name = _classifyNameOfLabel.text;
        order.price = [_priceLabel.text doubleValue];
        order.ID = _dishId;
        order.num = 0;
        
        [_selectedOrderList setObject:order forKey:@"modelID"];
        
        // 总价
        [_selectedOrderList setObject:@(0)    forKey:kSumPrice];
        [_selectedOrderList setObject:@(0)      forKey:kSumNum];
        
        ConfirmIndentViewController *confirmIndentVC = [[ConfirmIndentViewController alloc]init];
        confirmIndentVC.selectedOrderList = _selectedOrderList;
        
        [self.navigationController pushViewController:confirmIndentVC animated:YES];

    }
    
    else if (sender.tag == 81) {
        
        NSLog(@"13131");
        alertView = [[UIAlertView alloc]initWithTitle:nil message:@"您将收藏此菜品信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        
    }
}


- (ADLoopView *)adLoopView {

    if (!_adLoopView) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        NSArray *url_dishImage = _dictionarySource[@"dish"][@"pic"]; //获取图片数组
        NSMutableArray *urls = [NSMutableArray array]; //获取 path 图片集合 url不知道..
        for (NSDictionary *dict in url_dishImage) {
            [urls addObject:[NSString stringWithFormat:@"http://kdsc.mmqo.com%@",dict[@"path"]]];
                
        }
        _adView.userInteractionEnabled = YES;
        
        NSLog(@"%@",urls);
        _adLoopView = [ADLoopView adScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(_adView.bounds), CGRectGetHeight(_adView.bounds))
                                       imageLinkURL:urls
                                placeHoderImageName:@"placeHoder.jpg"
                               pageControlShowStyle:UIPageControlShowStyleCenter];
        _adLoopView.frame = _adView.bounds;
        
        
        //    是否需要支持定时循环滚动，默认为YES
        _adLoopView.isNeedCycleRoll = YES; 
        
        [_adLoopView setAdTitleArray:urls withShowStyle:AdTitleShowStyleNone];
        //    设置图片滚动时间,默认3s
        //    adView.adMoveTime = 2.0;
        
        //图片被点击后回调的方法
        _adLoopView.callBack = ^(NSInteger index,NSString * imageURL)
        {
            
            //  NSLog(@"被点中图片的索引:%d---地址:%@",index,imageURL);
        };
        
    }
    
    return _adLoopView;
}
- (void)barButtonItemMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return section == 2 ? _commentArray.count:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CELLID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    cell = nil;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.section == 0) {
        
        if (!_classifyNameOfLabel) {
            _classifyNameOfLabel = [[UILabel alloc]init];
        }
        
        [_classifyNameOfLabel setFrame:CGRectMake(10, 12, 100 , 18)];
        [_classifyNameOfLabel setText:@"创新小炒"];
        [_classifyNameOfLabel setText:_dictionarySource[@"dish"][@"name"]];
        [cell.contentView addSubview:_classifyNameOfLabel];
        if (!_numberOfSold) {
              _numberOfSold = [[UILabel alloc]init];
        }
        
      
        _numberOfSold.text = @"0";
        
        if (!soldLabel) {
            soldLabel = [[UILabel alloc]init];

        }
        
        soldLabel.frame = CGRectMake(CGRectGetMaxX(_classifyNameOfLabel.frame) + 10 , CGRectGetMinX(_classifyNameOfLabel.frame), ScreenWidth - CGRectGetMaxX(_classifyNameOfLabel.frame) - 20, 14);
        
        //已售份数
        if (_dictionarySource[@"chef"][@"sale_num"] != nil) {
            
             _numberOfSold.text = _dictionarySource[@"chef"][@"sale_num"];
        }
        else {
            
             _numberOfSold.text = 0;
        }
       
        soldLabel.text = [NSString stringWithFormat:@"已售%@份",_numberOfSold.text];
        soldLabel.font = [UIFont systemFontOfSize:14];
        soldLabel.textAlignment = NSTextAlignmentRight;
        [cell.contentView addSubview:soldLabel];
        
        if (!_adView) {
            _adView = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_classifyNameOfLabel.frame) + 12, ScreenWidth - 20, 183)];
        }
        
        _adView.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:_adView];
        
      
        
        if (!_headerImageView) {
            _headerImageView = [[UIImageView alloc]init];
        }
        [_headerImageView setFrame:CGRectMake(11, CGRectGetMaxY(_adView.frame) + 11, 46 * ratioX, 46 * ratioY)];
        [_headerImageView setBackgroundColor:[UIColor grayColor]];
//        [_headerImageView setImage:[UIImage imageWithData:imageData]];
//        _headerImageView.userInteractionEnabled = YES;
        [cell.contentView addSubview:_headerImageView];
        
        //订
        
        
        if (!_confirmBtn) {
             _confirmBtn = [[UIButton alloc]init];
        }
       
        _confirmBtn.frame = CGRectMake(ScreenWidth - 50, CGRectGetMinY(_headerImageView.frame), 40 * ratioX, 40 *ratioX);
        _confirmBtn.tag = 80;
        [_confirmBtn setTitle:@"订" forState:UIControlStateNormal];
        
        //获取当前时间
        NSDate *nowDate = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"HH:mm"];
        NSString *nowString = [formatter stringFromDate:nowDate];
        NSDate *dateNow = [formatter dateFromString:nowString];
        
        NSDate *orderTimeDate = [[NSDate alloc]init];
        orderTimeDate = [formatter dateFromString:_dictionarySource[@"dish"][@"sell_time_end"]];
        NSString *orderString = [formatter stringFromDate:orderTimeDate];
        NSDate *orderDate = [formatter dateFromString:orderString];
        
        
        NSLog(@"%@",_dictionarySource[@"dish"][@"sell_time_end"]);
        
        NSComparisonResult result = [dateNow compare:orderDate];
        if (result == NSOrderedAscending) {
            
            
            [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"ding"] forState:UIControlStateNormal];
            [_confirmBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        }
        else {
            
            [_confirmBtn setBackgroundColor:[UIColor grayColor]];
            
        }
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell.contentView addSubview:_confirmBtn];

        
        
        
        //姓名
        if (!_nameLabel) {
             _nameLabel = [[UILabel alloc]init];
        }
       
        [_nameLabel setFrame:CGRectMake(CGRectGetMaxX(_headerImageView.frame) + 8 , CGRectGetMinY(_headerImageView.frame), 90 * ratioX, 17 * ratioY)];
        if (_dictionarySource[@"chef"][@"nicename"] != nil) {
            [_nameLabel setText:_dictionarySource[@"chef"][@"nicename"]];
        }
        else {
            [_nameLabel setText:@""];
        }
        [_nameLabel setTextColor:[UIColor blackColor]];
        [_nameLabel setFont:[UIFont systemFontOfSize:14]];
        [cell.contentView addSubview:_nameLabel];
        
        //身份证
        if (!_idImageBtn) {
              _idImageBtn = [[UIButton alloc]init];
        }
      
        [_idImageBtn setFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame), CGRectGetMinY(_headerImageView.frame), 30 * ratioX, 15 * ratioY)];
        [_idImageBtn setBackgroundColor:[UIColor orangeColor]];
        [_idImageBtn setTitle:@"身份证" forState:UIControlStateNormal];
        _idImageBtn.titleLabel.font = [UIFont systemFontOfSize:8];
        [cell.contentView addSubview:_idImageBtn];
        
        //健康证
        if (!_healthImageBtn) {
            _healthImageBtn = [[UIButton alloc]init];
        }
        
        [_healthImageBtn setFrame:CGRectMake(CGRectGetMaxX(_idImageBtn.frame) + 5, CGRectGetMinY(_headerImageView.frame), 30 * ratioX, 15 * ratioY)];
        [_healthImageBtn setBackgroundColor:[UIColor orangeColor]];
        [_healthImageBtn setTitle:@"健康证" forState:UIControlStateNormal];
        _healthImageBtn.titleLabel.font = [UIFont systemFontOfSize:8];
        [cell.contentView addSubview:_healthImageBtn];
        
        for (int i = 0; i < 5; i++) {
            
           UIImageView  *starImageView = (UIImageView *)[cell.contentView viewWithTag:100+i];
            [starImageView removeFromSuperview];
        }

        //star
        for (int i = 0; i < 5; i++) {
            
            
           UIImageView *starImageView = [[UIImageView alloc]init];
            starImageView.tag = 100 + i;
            
            [starImageView setFrame:CGRectMake(CGRectGetMaxX(_headerImageView.frame) + 8 +21 * i * ratioX, CGRectGetMaxY(_headerImageView.frame) - 18 * ratioY, 18 * ratioX, 18 * ratioY)];
            [starImageView setImage:[UIImage imageNamed:@"tb9"]];
            [cell.contentView addSubview:starImageView];
        }
        
        NSString *score = [NSString stringWithFormat:@"%@",_dictionarySource[@"chef"][@"score"]];
        [Common screNumber:score view:cell.contentView tag:100];
        
        
//        //价格
//        UILabel *moneyAndPer = [[UILabel alloc]init];
//        moneyAndPer.frame = CGRectMake(CGRectGetMinX(_confirmBtn.frame) - 50 *ratioX, CGRectGetMinY(_starImageView.frame)  , 40 * ratioX, 16 *ratioY);
//        moneyAndPer.text = @"元/份";
//        moneyAndPer.font = [UIFont systemFontOfSize:14];
//        [cell.contentView addSubview:moneyAndPer];
//        
        //价格
        UILabel *moneyAndPer = [[UILabel alloc]init];
        moneyAndPer.frame = CGRectMake(CGRectGetMinX(_confirmBtn.frame) - 50 *ratioX, CGRectGetMaxY(_confirmBtn.frame) - 13 *ratioY , 40 * ratioX, 16 *ratioY);
        moneyAndPer.text = @"元/份";
        moneyAndPer.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:moneyAndPer];
        
        if (!_priceLabel) {
             _priceLabel = [[UILabel alloc]init];
        }
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.frame = CGRectMake(CGRectGetMaxX(_starImageView.frame) + 10, CGRectGetMaxY(_confirmBtn.frame) - 13 *ratioY, ScreenWidth - CGRectGetMaxX(_starImageView.frame) - (ScreenWidth - CGRectGetMinX(moneyAndPer.frame)) - 10, 16);
//        _priceLabel.text = @"0.00";
        _priceLabel.text = _dictionarySource[@"dish"][@"price"];
        _priceLabel.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.font = [UIFont systemFontOfSize:14];
        [cell.contentView addSubview:_priceLabel];
    
        //地址
        UIImageView *positionImageView = [[UIImageView alloc]init];
        [positionImageView setFrame:CGRectMake(11, CGRectGetMaxY(_headerImageView.frame) + 21, 16 , 16)];
        [positionImageView setImage:[UIImage imageNamed:@"tb4"]];
        [cell.contentView addSubview:positionImageView];
        
        if (!_positionLabel) {
           _positionLabel = [[UILabel alloc]init];
        }
        
        [_positionLabel setFrame:CGRectMake(CGRectGetMaxX(positionImageView.frame) + 8, CGRectGetMaxY(positionImageView.frame) - 11, (ScreenWidth - CGRectGetMaxX(positionImageView.frame) - 8 - 10), 10 )];
        [_positionLabel setText:@"成都市高新区创业路火炬大厦B座三楼"];
        [_positionLabel setText:_dictionarySource[@"chef"][@"address"]];
        [_positionLabel setFont:[UIFont systemFontOfSize:13]];
        [_positionLabel setTextColor:[UIColor colorWithRed:0.482f green:0.478f blue:0.482f alpha:1.00f]];
        [cell.contentView addSubview:_positionLabel];

        //时间
        UIImageView *timeImageView = [[UIImageView alloc]init];
        [timeImageView setFrame:CGRectMake(CGRectGetMinX(positionImageView.frame), CGRectGetMaxY(positionImageView.frame) + 12, 16 , 16 )];
        [timeImageView setImage:[UIImage imageNamed:@"tb5"]];
        [cell.contentView addSubview:timeImageView];
        
        
        //
        if (!_fTimeLabel) {
            _fTimeLabel = [[UILabel alloc]init];
        }
       
        if (_dictionarySource[@"dish"][@"sell_time_start"] != nil) {
            [_fTimeLabel setText:_dictionarySource[@"dish"][@"sell_time_start"]];
        }
        else {
            [_fTimeLabel setText:@"00:00"];

        }

        
        //
        if (!_tTimeLabel) {
            _tTimeLabel = [[UILabel alloc]init];
        }
        _tTimeLabel = [[UILabel alloc]init];
        [_tTimeLabel setText:@"00:00"];

        if (_dictionarySource[@"dish"][@"sell_time_end"] != nil) {
            [_tTimeLabel setText:_dictionarySource[@"dish"][@"sell_time_end"]];
        }
        else {
            [_tTimeLabel setText:@"00:00"];
        
        }
        
        if (!timeLabel) {
            timeLabel = [[UILabel alloc]init];
        }
        
        [timeLabel setFrame:CGRectMake(CGRectGetMaxX(timeImageView.frame) + 8, CGRectGetMaxY(timeImageView.frame) - 10 , (ScreenWidth - CGRectGetMaxX(timeImageView.frame) - 8 - 10), 10 )];
        [timeLabel setText:[NSString stringWithFormat:@"今日%@~%@可取",_fTimeLabel.text,_tTimeLabel.text]];
        [timeLabel setFont:[UIFont systemFontOfSize:13]];
        [timeLabel setTextColor:[UIColor colorWithRed:0.482f green:0.478f blue:0.482f alpha:1.00f]];
        [cell.contentView addSubview:timeLabel];
    }
    else if (indexPath.section == 1) {
        if (!_textView) {
             _textView = [[UILabel alloc]init];
        }
       
//        [_textView setFrame:CGRectMake(11, 8, ScreenWidth - 22, 50)];
        [_textView setUserInteractionEnabled:NO];
//        [_textView setScrollEnabled:NO];
//        [_textView setDelegate:self];
        _textView.font = [UIFont systemFontOfSize:12];
        [cell.contentView addSubview:_textView];
        
    }
    else if (indexPath.section == 2) {
        
        static NSString *CommentCell = @"CommentCell";
        MenuListCellOfComment *cell = [tableView dequeueReusableCellWithIdentifier:CommentCell];
        if (!cell) {
            cell = [[MenuListCellOfComment alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CommentCell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
//        cell.headerImageView setImageWithURL:[NSURL]
//        cell.nameOfLabel
        cell.contentOfLabel.text = _commentArray[indexPath.row][@"content"];
//        (11, CGRectGetMaxY(_headerImageView.frame) + 10, ScreenWidth - 20, 35)
        cell.frame = CGRectMake(11, CGRectGetMaxY(cell.headerImageView.frame) + 10, ScreenWidth - 20, [NSString getTextHeightWithFont:[UIFont systemFontOfSize:16] forWidth:ScreenWidth - 20 text:_commentArray[indexPath.row][@"content"]]);
        cell.contentOfLabel.font = [UIFont systemFontOfSize:16];
        
        cell.timeOfLabel.text = [[NSString stringWithFormat:@"%@", [NSDate dateWithTimeInterval:8*60*60 sinceDate:[NSDate dateWithTimeIntervalSince1970:[_commentArray[indexPath.row][@"time"] intValue]]]] substringToIndex:16];
        
        return cell;
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 365;
    }
    else if (indexPath.section == 1) {
        
        return 10 + [NSString getTextHeightWithFont:[UIFont systemFontOfSize:16] forWidth:ScreenWidth - 20 text:_dictionarySource[@"dish"][@"content"]];
    }
    else if (indexPath.section == 2) {
        
        return 76 + [NSString getTextHeightWithFont:[UIFont systemFontOfSize:16] forWidth:ScreenWidth - 20 text:_commentArray[indexPath.row][@"content"]];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 10;
    }
    else if (section == 1) {
        
        return 46;
    }
    else {
        
        return 65;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        
        UIView *headerView = [[UIView alloc]init];
        headerView.frame = CGRectMake(0, 0, ScreenWidth, 46);
        headerView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
        
        UILabel *label = [[UILabel alloc]init];
        [label setFrame:CGRectMake(11, 12, ScreenWidth - 11, 18)];
        [label setText:@"菜品介绍"];
        [headerView addSubview:label];
        
        return headerView;
    }
    if (section == 2) {
        
        UIView *headerView = [[UIView alloc]init];
        headerView.frame = CGRectMake(0, 0, ScreenWidth, 65);
        headerView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
        
        UIView *newView = [[UIView alloc]init];
        newView.frame = CGRectMake(0, 21, ScreenWidth, 44);
        newView.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:newView];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView setFrame:CGRectMake(11, 11, 25, 24)];
        [imageView setImage:[UIImage imageNamed:@"tb6"]];
        [newView addSubview:imageView];
        
        
        UILabel *blackLine = [[UILabel alloc]init];
        [blackLine setFrame:CGRectMake(0, 44 - 1, ScreenWidth, 1)];
        [blackLine setBackgroundColor:[UIColor colorWithRed:0.867f green:0.867f blue:0.867f alpha:1.00f]];
        [newView addSubview:blackLine];
        return headerView;
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
        
        
        NSLog(@"111");
        
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        NSString *tel = [defaults objectForKey:@"tel"];
//        NSString *pwd = [defaults objectForKey:@"pwd"];
//        NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"id":_selectedUserID};
//        
//        [NetWorkHandler delDish:dict completionHandler:^(id content) {
//            
//            NSLog(@"%@",content);
//        }];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *tel = [defaults objectForKey:@"tel"];
        NSString *pwd = [defaults objectForKey:@"pwd"];
        NSString *object_id = _dishId;
        NSString *type = @"2";
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
