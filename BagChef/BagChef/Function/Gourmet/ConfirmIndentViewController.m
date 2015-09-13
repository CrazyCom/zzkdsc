//
//  ConfirmIndentViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/8/5.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "ConfirmIndentViewController.h"
#import <BaiduMapAPI/BMapKit.h>
#import "RouteManager.h"
#import "OrderInfoCell.h"
#import "JSONKit.h"
#import "ZHPickView.h"

@interface ConfirmIndentViewController ()<UITableViewDelegate,UITableViewDataSource,BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKPoiSearchDelegate,UITextFieldDelegate,OrderInfoCellDelegate,ZHPickViewDelegate> {
    
    UITableView *_tableView;
    UITextField *_telTextField;
    UITextField *_addressTextField;
    UILabel *_timeOfEat;
    UILabel *_time;
    
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    UIButton *btn4;
    
    BMKLocationService* _locationService;
    BMKGeoCodeSearch* _geocodesearch;
    BMKPoiSearch *_poiSearch;
    
    NSMutableArray *_poiSearchArray;
    
    UIView *_poiSearchView;
    UITableView *_poiTableView;
    
    UILabel *_nameOfMenu;
    UILabel *_priceOfMenu;
    
    NSDictionary *dictionaryOfHome;
    
    
    BOOL _isSelectAddress;
    
    //全局变量初始化后不会释放
    UILabel *labelOfTotal;
    UILabel *bankLabel;
    UILabel *alipayLabel;
    UILabel *armedLabel;
    UILabel *myselfLabel;
    
    NSMutableArray *_hpDataSource;
    
    float routeDistance;
    
    NSMutableArray *_productList;   // 商品列表
    BOOL _isExpress; //记录运输方式,YES为镖师送餐，NO为自己取货
    
    UIDatePicker *_datePicker;
    ZHPickView *_pickerView;
    NSInteger _section;
    id _dateString;
}

@property (nonatomic, assign) int productTotalNum;          // 商品总数量
@property (nonatomic, assign) CGFloat productTotalPrice;    // 商品总价格
@property (nonatomic, assign) CGFloat productDishFreight;   // 商品运费

@property (nonatomic, strong) void(^currentLocation)(BMKUserLocation *userLocatoin) ;


- (void)initializeDataSource;
- (void)initializeInterface;
@end

@implementation ConfirmIndentViewController

- (id)initWithData:(NSDictionary *)dict {
    
    if (self = [super init]) {
        dictionaryOfHome = [[NSDictionary alloc]init];
        dictionaryOfHome = dict;
    }
    return self;
}

- (void)initializeDataSource {
    
    _isSelectAddress = NO;
    _isExpress = NO;
    _poiSearchArray = [NSMutableArray array];
    _hpDataSource = [[NSMutableArray alloc]init];
    _poiSearchView = [[UIView alloc]init];
    
    
    _productTotalNum = [_selectedOrderList[kSumNum] intValue];
    
    _productList = [[NSMutableArray alloc] init];

    self.productTotalPrice = 0.0;
    self.productDishFreight = 0.0;
    
    for (NSString *key in _selectedOrderList) {
        NSLog(@"%@",key);
        id object = _selectedOrderList[key];
        
        if ([object isKindOfClass:[OrderInfo class]]) {
            
            OrderInfo *order = (OrderInfo *)object;
            
            self.productTotalPrice += order.num * order.price;
            
            [_productList addObject:order];
        }
    }
    
    [_productList sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        OrderInfo *order1 = (OrderInfo *)obj1;
        OrderInfo *order2 = (OrderInfo *)obj2;
        
        if (order1.num > order2.num) {
            return NSOrderedAscending;
        }
        
        return NSOrderedDescending;
        
    }];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeDataSource];
    [self initializeInterface];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    DefaultViewController *dvc = (DefaultViewController *)[AppDelegate app].window.rootViewController;
    [dvc.ztabBarController setHideEsunTabBarBtn:YES];
    
    _locationService.delegate = self;
    _geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
//    [[[RouteManager alloc] init] distance:CLLocationCoordinate2DMake(30.596319, 104.066815) EndPoint:CLLocationCoordinate2DMake(30.592519, 104.069815) Complete:^(CGFloat distance) {
//        
//        NSLog(@"distance : %lf", distance);
//        
//    }];
//
}

-(void)viewWillDisappear:(BOOL)animated {
    
    _locationService.delegate = nil;
    _geocodesearch.delegate = nil; // 不用时，置nil
}



- (void)initializeInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.leftButton.hidden = NO;
    self.titleLabel.text = @"确认订单";
    [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(barButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    //    [_tableView setFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [self.view addSubview:_tableView];
    
    
    //地图
    _locationService = [[BMKLocationService alloc]init];
    _locationService.delegate = self;
    //打开定位服务
    [_locationService startUserLocationService];
    
    //反向地理编码
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _geocodesearch.delegate = self;
    
    _poiSearch = [[BMKPoiSearch alloc]init];
    _poiSearch.delegate = self;
    
    //搜索兴趣点弹出view
    _poiSearchView.frame = CGRectMake(30, 162, 200, 120);
    _poiSearchView.backgroundColor = [UIColor colorWithRed:0.965f green:0.965f blue:0.965f alpha:1.00f];
    [self.view addSubview:_poiSearchView];
    _poiSearchView.hidden = YES;
    


}

- (void)barButtonItemMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - buttonPressed
- (void)buttonPressed:(UIButton *)sender {
    
    int i = (int)sender.tag - 20;
    if (i == 0 && [_numberOfPart.text integerValue] >= 0) {
        

        if ([_numberOfPart.text integerValue] != 0) {
            _numberOfPart.text = [NSString stringWithFormat:@"%d",(int)[_numberOfPart.text floatValue] - 1];
            _priceOfLabel.text = [NSString stringWithFormat:@"%.2f元",[_numberOfPart.text integerValue] * [dictionaryOfHome[@"price"] floatValue]];
            return;
        }
    }
    else if (i == 1){
        if (dictionaryOfHome[@"surplus_num"] != nil && [dictionaryOfHome[@"surplus_num"]integerValue] > [_numberOfPart.text integerValue] ) {
    
            
            _numberOfPart.text = [NSString stringWithFormat:@"%d",(int)[_numberOfPart.text floatValue] + 1];
            _priceOfLabel.text = [NSString stringWithFormat:@"%.2f元",[_numberOfPart.text integerValue] * [dictionaryOfHome[@"price"] floatValue]];

        }
        else {
            if (dictionaryOfHome[@"surplus_num"] != nil) {
                
                [DisplayView displayShowWithTitle:[NSString stringWithFormat:@"此商品还剩%@份",dictionaryOfHome[@"surplus_num"]]];
                _priceOfLabel.text = [NSString stringWithFormat:@"%.2f元",[_numberOfPart.text integerValue] * [dictionaryOfHome[@"price"] floatValue]];

            }
            
        }
       
    }

    else if (i == 2) {
        btn1.selected = YES;
        btn2.selected = NO;
        _isExpress = NO;
        
        self.productTotalPrice -= self.productDishFreight;
        self.productDishFreight = 0.0;
    }
    else if (i == 3) {
        
        btn1.selected = NO;
        btn2.selected = _isExpress = [self isSatisfyCondition];
        if (btn2.selected) {
           
//            [DisplayView displayShowWithTitle:@"亲!正在计算路费，请稍等"];
            //网络请求
            //厨师经纬度
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults objectForKey:@"lat"]; //经度
            [defaults objectForKey:@"lon"]; //纬度
            
            [self getDishFreight];
            
        }
    }
    else if (i == 4) {
        
        btn3.selected = YES;
        btn4.selected = NO;
    }
    else if (i == 5) {
        
        btn3.selected = NO;
        btn4.selected = YES;
    }
    else if (i == 6) {

        //确认订单
        [self requestHttp];
    }

}

- (BOOL)isSatisfyCondition {

    BOOL isSatisfy = YES;
    
    if (_addressTextField.text.length == 0) {
        [DisplayView displayShowWithTitle:@"请输入地址"];
        isSatisfy = NO;
    }
    else if (self.productTotalNum == 0) {
        
        [DisplayView displayShowWithTitle:@"请输入菜品份数"];
        isSatisfy = NO;
        
    }
    else if ([_telTextField.text integerValue] == 0) {
        
        [DisplayView displayShowWithTitle:@"请输入联系电话"];
        isSatisfy = NO;
    }
    
    
    return isSatisfy;
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_locationService stopUserLocationService];
//    _currentLocation(userLocation);
    
    //反向地理编码
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude};
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    NSLog(@"%f,%f",reverseGeoCodeSearchOption.reverseGeoPoint.longitude,reverseGeoCodeSearchOption.reverseGeoPoint.latitude);
    
    //
    NSDictionary *dict = @{@"mcode":@"crazy.BagChef",@"ak":@"1yoWgXQeI6TKjGhQB4Ov9fg3",@"callback":@"renderReverse",@"location":[NSString stringWithFormat:@"%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude ],@"output":@"json",@"pois":@"1"};
    [NetWorkHandler getAdressWithParams:dict completionHandler:^(id content) {
        NSLog(@"content:%@",content);
        NSLog(@"%@",content[@"message"]);
        NSLog(@"%@",content[@"result"][@"addressComponent"][@"city"]);
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:content[@"result"][@"addressComponent"][@"city"] forKey:@"city"];
        [defaults synchronize];
    }];
    
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeoCodeSearchOption];
    if (flag) {
        NSLog(@"success");
    }
    else {
        NSLog(@"fail");
    }
    
}
- (void)didFailToLocateUserWithError:(NSError *)error {
    _currentLocation(nil);
    NSLog(@"didFailToLocateUserWithError %@",error);
}

#pragma mark - 反向地理编译
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    
    if (error == 0) {
        
        //        NSLog(@"....%@",result.address);
        //        NSLog(@"%@",result.addressDetail.province);
        //        NSLog(@"%@",result.addressDetail.streetName);
        //        NSLog(@"%@",result.addressDetail.streetNumber);
        //        NSLog(@"%@",result.addressDetail.district);
        BMKPointAnnotation *item = [[BMKPointAnnotation alloc]init];
        item.title = result.address;
        
    }
}

#pragma mark -正向地理编码

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    
    BMKPointAnnotation *item = [[BMKPointAnnotation alloc]init];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    item.coordinate = result.location;
    [defaults setObject:[NSString stringWithFormat:@"%f",item.coordinate.latitude ]forKey:@"latitude"];
    [defaults setObject:[NSString stringWithFormat:@"%f",item.coordinate.longitude ]forKey:@"longitude"];
    [defaults synchronize];
    
    double lat = [[defaults objectForKey:@"lat"] doubleValue];
    double lon = [[defaults objectForKey:@"lon"] doubleValue];
    
    [[[RouteManager alloc] init] distance:item.coordinate EndPoint:CLLocationCoordinate2DMake(lat, lon) Complete:^(CGFloat distance) {
        
        routeDistance = distance;
        NSLog(@"distance : %lf", distance);
        
    }];
    
    NSLog(@"%@",result);
}

#pragma mark - PoiSearch
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode {
    
    NSLog(@"address:%@",poiResult);
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        for (int i = 0 ; i < poiResult.poiInfoList.count; i++) {
            
            BMKPoiInfo *poiInfo = [poiResult.poiInfoList objectAtIndex:i];
            [_poiSearchArray addObject:poiInfo.name];
            NSLog(@"name:%@",poiInfo.name);
        }
    }
    
    //弹出下拉列表
    if (poiResult.poiInfoList.count != 0) {
        //        _poiSearchArray = [poiResult.poiInfoList copy];
        _poiSearchView.hidden = NO;
        
        _poiTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, 200, 120)];
        _poiTableView.backgroundColor = [UIColor colorWithRed:0.965f green:0.965f blue:0.965f alpha:1.00f];
        _poiTableView.dataSource = self;
        _poiTableView.delegate = self;
        [_poiSearchView addSubview:_poiTableView];
        
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([tableView isEqual: _tableView]) {
        
        return 6;
        
    }
    else {
        
        return 1;
        
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([tableView isEqual: _tableView]) {
        
        if (section == 0) {
            
            return 2;
        }
        else if (section == 1) {
            
            return _productList.count;
        }
        else if (section == 3) {
            
            return 2;
        }
        else if (section == 4) {
            
            return 2;
        }
        else if (section == 5) {
            
            return 1;
        }
        return 1;
    }
    else {
        
        return _poiSearchArray.count;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual: _tableView]) {
        
        NSString *CELLID = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"联系电话";
                
                if (!_telTextField) {
                    
                    _telTextField = [[UITextField alloc]init];
                    _telTextField.frame = CGRectMake(88, 14, ScreenWidth - 88 - 10, 20);
                    _telTextField.textColor = [UIColor grayColor];
                    [cell.contentView addSubview:_telTextField];
                    
                }
                
            }
            else {
                cell.textLabel.text = @"地址";
                
                if (!_addressTextField) {
                    
                    _addressTextField = [[UITextField alloc]init];
                    _addressTextField.tag = 1000;
                    _addressTextField.delegate = self;
                    _addressTextField.frame = CGRectMake(58, 14, ScreenWidth - 58 - 10, 20);
                    _addressTextField.textColor = [UIColor grayColor];
                    [cell.contentView addSubview:_addressTextField];

                }

            }
        }
        else if (indexPath.section == 1) {
            
            OrderInfoCell *orderCell = [tableView dequeueReusableCellWithIdentifier:@"ordercell"];
            
            if (!orderCell) {
                orderCell = [[OrderInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ordercell"];
                orderCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            orderCell.delegate = self;
            [orderCell updateCellWith:_productList[indexPath.row]];
            
            return orderCell;
            
        }
        else if (indexPath.section == 2)
        {
            cell.textLabel.text = @"吃饭时间";
            
            if (!_timeOfEat) {
                
                _timeOfEat = [[UILabel alloc]init];
                _timeOfEat.frame = CGRectMake(95, 14, ScreenWidth- 88 - 10, 20);
                _timeOfEat.textColor = [UIColor grayColor];
                //            _timeOfEat.font = [UIFont systemFontOfSize:14];
                [cell.contentView addSubview:_timeOfEat];
                
            }
        }
        else if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                
                if (!myselfLabel) {
                    
                    btn1 = [[UIButton alloc]init];
                    btn1.frame = CGRectMake(11, 13, 21, 21);
                    btn1.tag = 22;
                    [btn1 setImage:[UIImage imageNamed:@"choose-n"] forState:UIControlStateNormal];
                    [btn1 setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateSelected];
                    [btn1 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:btn1];
                    
                    
                    myselfLabel = [[UILabel alloc]init];
                    myselfLabel.frame = CGRectMake(CGRectGetMaxX(btn1.frame) + 10, CGRectGetMaxY(btn1.frame) - 17, 200, 15);
                    myselfLabel.text = @"亲自上门取";
                    myselfLabel.textColor = [UIColor blackColor];
                    [cell.contentView addSubview:myselfLabel];
                }

            }
            else {
              
                if (!armedLabel) {
                    
                    btn2 = [[UIButton alloc]init];
                    btn2.tag = 23;
                    btn2.frame = CGRectMake(11, 13, 21, 21);
                    [btn2 setImage:[UIImage imageNamed:@"choose-n"] forState:UIControlStateNormal];
                    [btn2 setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateSelected];
                    [btn2 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:btn2];
                    
                    
                    armedLabel = [[UILabel alloc]init];
                    armedLabel.frame = CGRectMake(CGRectGetMaxX(btn2.frame) + 10, CGRectGetMaxY(btn2.frame) - 17, 200, 15);
                    armedLabel.text = @"请镖师送饭上门";
                    armedLabel.textColor = [UIColor blackColor];
                    [cell.contentView addSubview:armedLabel];

                }
            }
            
        }
        else if (indexPath.section == 4) {
            if (indexPath.row == 0) {
                
                if (!bankLabel) {
                    btn3 = [[UIButton alloc]init];
                    btn3.tag = 24;
                    btn3.frame = CGRectMake(11, 13, 21, 21);
                    [btn3 setImage:[UIImage imageNamed:@"choose-n"] forState:UIControlStateNormal];
                    [btn3 setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateSelected];
                    [btn3 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:btn3];
                    
                    bankLabel = [[UILabel alloc]init];
                    bankLabel.frame = CGRectMake(CGRectGetMaxX(btn3.frame) + 10, CGRectGetMaxY(btn3.frame) - 17, 200, 15);
                    bankLabel.text = @"网银支付";
                    bankLabel.textColor = [UIColor blackColor];
                    [cell.contentView addSubview:bankLabel];
                }
               
            }
            else {
                
                if (!alipayLabel) {
                    btn4 = [[UIButton alloc]init];
                    btn4.tag = 25;
                    btn4.frame = CGRectMake(11, 13, 21, 21);
                    [btn4 setImage:[UIImage imageNamed:@"choose-n"] forState:UIControlStateNormal];
                    [btn4 setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateSelected];
                    [btn4 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:btn4];
                    
                    alipayLabel = [[UILabel alloc]init];
                    alipayLabel.frame = CGRectMake(CGRectGetMaxX(btn4.frame) + 10, CGRectGetMaxY(btn4.frame) - 17, 200, 15);
                    alipayLabel.text = @"支付宝支付";
                    alipayLabel.textColor = [UIColor blackColor];
                    [cell.contentView addSubview:alipayLabel];
                }
               
            }
            
        }
        else if (indexPath.section == 5) {
            
            if (!labelOfTotal) {
                labelOfTotal = [[UILabel alloc]init];
                labelOfTotal.frame = CGRectMake(11, 13, 60, 21);
                labelOfTotal.font = [UIFont systemFontOfSize:13];
                labelOfTotal.text = @"共计";
                [cell.contentView addSubview:labelOfTotal];
            }
           
            
            if (!_priceOfLabel) {
                
                _priceOfLabel = [[UILabel alloc]init];
                _priceOfLabel.frame = CGRectMake(CGRectGetMaxX(labelOfTotal.frame), 13, 100, 21);
                _priceOfLabel.textColor = [UIColor colorWithRed:1.000f green:0.000f blue:0.133f alpha:1.00f];
                _priceOfLabel.font = [UIFont systemFontOfSize:13];
                _priceOfLabel.text = [NSString stringWithFormat:@"%.2f元", self.productTotalPrice];
                
                [cell.contentView addSubview:_priceOfLabel];

            }
            
            UIButton *btn;
            if (!btn) {
                btn = [[UIButton alloc]init];
                btn.tag = 26;
                btn.frame = CGRectMake(ScreenWidth - 150, 6, 140, 35);
                [btn setBackgroundImage:[UIImage imageNamed:@"button-shangchuancaipin"] forState:UIControlStateNormal];
                [btn setTitle:@"确定提交" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:btn];

            }
        }
        return cell;

    }
    else if ([tableView isEqual: _poiTableView]){
        
        NSString *CellID = @"CellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        }
        cell.textLabel.text = [_poiSearchArray objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;
    }
    return nil;

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual: _tableView]) {
        
        return indexPath.section == 1 ? 47 * 3 : 47;
    }
    else {
        
        return 30;
    }
   
}


//section HeaderView

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if ([tableView isEqual: _tableView]) {
        
        if (section == 0) {
            
            return 12;
        }
        else if (section == 1) {
            
            return 12;
        }
        else if (section == 2) {
            
            return 0;
        }
        else if (section == 3) {
            
            return 43;
        }
        else if (section == 4) {
            
            return 43;
        }
        else if (section == 5) {
            
            return 12;
        }

    }
    else {
        
        return 0.1;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if ([tableView isEqual: _tableView]) {
        
        if (section == 3) {
            
            UIView *headerView = [[UIView alloc]init];
            headerView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
            headerView.frame = CGRectMake(0, 0, ScreenWidth, 43);
            
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake(11, 13, 150, 15);
            label.text = @"请选择配送方式";
            [headerView addSubview:label];
            
            return headerView;
        }
        else if (section == 4) {
            
            UIView *headerView = [[UIView alloc]init];
            headerView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
            headerView.frame = CGRectMake(0, 0, ScreenWidth, 43);
            
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake(11, 13, 150, 15);
            label.text = @"请选择支付方式";
            [headerView addSubview:label];
            
            return headerView;
            
        }
        return nil;
    }
    else {
        
        return nil;
    }
}

#pragma mark - tableView select
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:_poiTableView]) {
        if (_addressTextField.text.length != 0) {
            _addressTextField.text = @"";
        }
        _addressTextField.text = _poiSearchArray[indexPath.row];
        
        //正向地理编码
        NSUserDefaults *userDefaults = [[NSUserDefaults alloc]init];
        
        BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
        geoCodeSearchOption.city = [userDefaults objectForKey:@"city"];
        geoCodeSearchOption.address = _addressTextField.text;
        BOOL flag = [_geocodesearch geoCode:geoCodeSearchOption];
        if(flag)
        {
            NSLog(@"geo检索发送成功");
        }
        else
        {
            NSLog(@"geo检索发送失败");
        }
        _poiSearchView.hidden = YES;
        [_poiSearchArray removeAllObjects];
    }
    else if (indexPath.section == 2) {
        _section = 2;
        [self displayDatePickerTime];
    }
}


#pragma mark - <OrderInfoCellDelegate>

- (void)numChangeWith:(OrderInfoCell *)cell Num:(int)num {
    
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    OrderInfo *orderInfo = _productList[indexPath.row];
    
    self.productTotalNum += num - orderInfo.num;
    self.productTotalPrice += orderInfo.price * (num - orderInfo.num);
    
    orderInfo.num = num;
    
    if (_isExpress) {
        
        [self getDishFreight];
    }

    
}

- (void)getDishFreight {
    
    _priceOfLabel.text = @"运费计算中...";
    
    NSString *length = [NSString stringWithFormat:@"%lf",routeDistance / 1000.0];
    NSDictionary *dict_getDishFreight = @{@"length":length, @"number":@(self.productTotalNum)};
    //计算菜品运费
    [NetWorkHandler getDishFreight:dict_getDishFreight completionHandler:^(id content) {

        if (_isExpress && [content isKindOfClass:[NSDictionary class]]) {
            
            self.productTotalPrice -= self.productDishFreight;
            self.productDishFreight = [content[@"data"] doubleValue];
            self.productTotalPrice += self.productDishFreight;
            
        }
        else {
            
            // 运费获取失败
            if ([content isKindOfClass:[NSError class]]) {
                
                NSError *error = (NSError *)content;
                
                [DisplayView displayShowWithTitle:error.localizedDescription];
            }
            
            self.productTotalPrice = _productTotalPrice;
        }
    }];

}

- (void)setProductTotalNum:(int)productTotalNum {

    _productTotalNum = productTotalNum;
}

- (void)setProductTotalPrice:(CGFloat)productTotalPrice {

    _productTotalPrice = productTotalPrice;
    _priceOfLabel.text = [NSString stringWithFormat:@"%.2f元", _productTotalPrice];
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if (textField.tag == 1000) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
        
        citySearchOption.city= [userDefaults objectForKey:@"city"];
        citySearchOption.keyword = _addressTextField.text;
        BOOL flag = [_poiSearch poiSearchInCity:citySearchOption];
        if(flag)
        {
            
            NSLog(@"城市内检索发送成功");
        }
        else
        {
            
            NSLog(@"城市内检索发送失败");
        }
        
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //    _poiSearchView.hidden = YES;
}

#pragma mark - 网络请求

#pragma mark -<计算单个菜品价格>
- (void)getDishPrice {
    
    NSDictionary *dict;
    [NetWorkHandler getDishPrice:dict completionHandler:^(id content) {
        NSLog(@"getDishPrice:%@",content);
    }];
}

#pragma mark 上传数据
- (void)requestHttp {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tel = [defaults objectForKey:@"tel"];
    NSString *pwd = [defaults objectForKey:@"pwd"];
    NSString *chef_id = [defaults objectForKey:@"chefId"];
    NSString *address = _addressTextField.text;
    
    double lat = [[defaults objectForKey:@"lat"] doubleValue];
    double lon = [[defaults objectForKey:@"lon"] doubleValue];
    NSString *length = [NSString stringWithFormat:@"%lf",routeDistance / 1000];
   
    
    NSDateFormatter *formmater = [[NSDateFormatter alloc]init];
    [formmater setDateStyle:NSDateFormatterShortStyle];
    [formmater setTimeStyle:NSDateFormatterShortStyle];
    [formmater setDateFormat:@"yyyy-MM-dd HH:mm:ss +0800"];
    NSDate *newDate = [formmater dateFromString:_time.text];
    NSString *order_time = [NSString stringWithFormat:@"%ld",(long)[newDate timeIntervalSince1970]];
    NSLog(@"%@",order_time);
//    NSString *order_time = [NSString stringWithFormat:@"%ld",(long)[ [self convertDateFromString:_timeOfEat.text] timeIntervalSince1970]];
//    NSString *order_time = [NSString stringWithFormat:@"%@", [NSDate dateWithTimeInterval:8*60*60 sinceDate:[NSDate dateWithTimeIntervalSince1970:[_timeOfEat.text intValue]]]] ;
//    NSString *order_time = [self timeToTurnTimeStamp:<#(NSDate *)#>]
    if (!order_time) {
        
        [DisplayView displayShowWithTitle:@"请输入时间"];
        return;
    }
    
    NSLog(@"%lf,%lf,%lf",_productTotalPrice,_productTotalPrice - _productDishFreight,_productDishFreight);
    NSString *total_price = [NSString stringWithFormat:@"%.2f",_productTotalPrice];
    NSString *dish_price = [NSString stringWithFormat:@"%.2f",_productTotalPrice - _productDishFreight];
    NSString *expressprice = [NSString stringWithFormat:@"%.2f",_productDishFreight];
    NSString *phone = _telTextField.text;
    NSLog(@"%@,%@,%@",total_price,dish_price,expressprice);
    
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (OrderInfo *orderInfo in _productList) {
        
        
        [temp addObject:@{@"id":orderInfo.ID,
                          @"num":@(orderInfo.num)}];
        
    }
    NSLog(@"temp:%@",temp);
//    NSString *dish_array = [temp JSONString];
    NSString *dish_array = [self arrayToJson:temp];
    
    NSDictionary *dict = [[NSDictionary alloc]init];

    if (_isExpress) {
        dict = @{@"phone":phone,@"tel":tel,@"pwd":pwd,@"chef_id":chef_id,@"address":address,@"order_lat":[NSString stringWithFormat:@"%lf",lat],@"order_lon":[NSString stringWithFormat:@"%lf",lon],@"length":length,@"order_time":order_time,@"total_price":total_price,@"dish_price":dish_price,@"express_price":expressprice,@"dish_array":dish_array};
    }
    else {
        
        dict = @{@"phone":phone,@"tel":tel,@"pwd":pwd,@"chef_id":chef_id,@"express_id":@"-1",@"address":address,@"order_lat":[NSString stringWithFormat:@"%lf",lat],@"order_lon":[NSString stringWithFormat:@"%lf",lon],@"length":length,@"order_time":order_time,@"total_price":total_price,@"dish_price":dish_price,@"express_price":expressprice,@"dish_array":dish_array};
    }
    
  
    [NetWorkHandler addOrder:dict completionHandler:^(id content) {
        // 运费获取失败
        if ([content isKindOfClass:[NSError class]]) {
            
            NSError *error = (NSError *)content;
            
            [DisplayView displayShowWithTitle:error.localizedDescription];
            return ;
        }
        
        NSLog(@"%@",content);
        [DisplayView displayShowWithTitle:content[@"info"]];
    }];
}

//数组转json
- (NSString *)arrayToJson:(NSMutableArray *)array {
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}

//NSString转NSDate
- (NSDate*) convertDateFromString:(NSString*)uiDate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"HH:mm"];
    NSDate *date=[formatter dateFromString:uiDate];
    return date;
}

- (NSString *)timeToTurnTimeStamp:(NSDate *)date
{
    //计算时间，预约时间要大于当前时间一小时
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss +0800"];//修改时区为东8区
    NSString *dateString = [dateFormatter stringFromDate:date];
    //标准时间转化为时间戳,当前时间
    NSDate *date2 = [dateFormatter dateFromString:dateString];
    return  [NSString stringWithFormat:@"%ld", (long)[date2 timeIntervalSince1970]];
}


#pragma mark ZhpickVIewDelegate

- (void)displayDatePickerTime {
    
    NSDate *date=[NSDate date];
    _pickerView = [[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeTime isHaveNavControler:NO];
    _pickerView.delegate=self;
    [_pickerView show];
}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(id )resultString{
    
    
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc]init];
    [pickerFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss +0800"];
    NSString *dateString = [pickerFormatter stringFromDate:resultString];
    if (_section == 2) {
        
        _time = [[UILabel alloc]init];
        _time.text = dateString;
        
        [pickerFormatter setDateFormat:@"HH:mm"];
        dateString = [pickerFormatter stringFromDate:resultString];
        _timeOfEat.text = dateString;
        
        
//        //转字符串为Date
//        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//        [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
//        [formatter setDateFormat:@"yyyy-MM-dd-HH-ss"];
//        earlierDate = [formatter dateFromString:_timeOfEat.text];
    }
    NSLog(@"%@",_dateString);
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
