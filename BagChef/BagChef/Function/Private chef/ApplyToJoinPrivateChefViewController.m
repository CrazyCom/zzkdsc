//
//  ApplyToJoinPrivateChefViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/8/6.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "ApplyToJoinPrivateChefViewController.h"
#import "WaitForAuditViewController.h"
#import "PictureView.h"
#import "TakePictureView.h"
#import <BaiduMapAPI/BMapKit.h>
#import "JSONKit.h"
#import "AFHTTPRequestOperationManager+HTTPBody.h"

@interface ApplyToJoinPrivateChefViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationBarDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKPoiSearchDelegate> {
    
    UITableView *_tableView;
    
    UITextField *_addressTextField;
    UITextField *_nameTextField;
    UITextField *_idTextField;
    
    UITextField *_alipayTextField;
    UITextField *_bankCardTextField;
    
    PictureView *_pictureViewID;
    PictureView *_pictureViewHealth;
    PictureView *_currentPV;
    NSMutableArray *_imageList; //添加的图片
    
    BOOL _isEdit;
    
    BMKLocationService* _locationService;
    BMKGeoCodeSearch* _geocodesearch;
    BMKPoiSearch *_poiSearch;
    
    NSMutableArray *_poiSearchArray;
    
    UIView *_poiSearchView;
    UITableView *_poiTableView;

}
@property (nonatomic, assign) int status;
@property (nonatomic, strong) void(^currentLocation)(BMKUserLocation *userLocatoin) ;
- (void)initializeDataSource;
- (void)initializeInterface;

@end

@implementation ApplyToJoinPrivateChefViewController

- (void)initializeDataSource {
    
     _imageList = [NSMutableArray array];
    _poiSearchArray = [NSMutableArray array];
    _poiSearchView = [[UIView alloc]init];
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

}

-(void)viewWillDisappear:(BOOL)animated {
    
    _locationService.delegate = nil;
    _geocodesearch.delegate = nil; // 不用时，置nil
}


- (void)initializeInterface {
    
   
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.titleLabel.text = @"申请加入私厨";
    self.leftButton.hidden = NO;
    [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(barButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStyleGrouped];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    _tableView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
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
    _poiSearchView.frame = CGRectMake(30, 118, 200, 120);
    _poiSearchView.backgroundColor = [UIColor colorWithRed:0.965f green:0.965f blue:0.965f alpha:1.00f];
    [self.view addSubview:_poiSearchView];
    _poiSearchView.hidden = YES;
    
    
    
}

- (void)barButtonItemMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updataImageList {
    
    [_currentPV imageData:_imageList];
    NSLog(@"%@",_imageList);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_locationService stopUserLocationService];
    _currentLocation(userLocation);
    
    //反向地理编码
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude};
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    NSLog(@"%f,%f",reverseGeoCodeSearchOption.reverseGeoPoint.longitude,reverseGeoCodeSearchOption.reverseGeoPoint.latitude);
    
    //
//    NSDictionary *dict = @{@"mcode":@"crazy.BagChef",@"ak":@"1yoWgXQeI6TKjGhQB4Ov9fg3",@"callback":@"renderReverse",@"location":[NSString stringWithFormat:@"%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude ],@"output":@"json",@"pois":@"1"};
//    [NetWorkHandler getAdressWithParams:dict completionHandler:^(id content) {
//        NSLog(@"content:%@",content);
//        NSLog(@"%@",content[@"message"]);
//        NSLog(@"%@",content[@"result"][@"addressComponent"][@"city"]);
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setObject:content[@"result"][@"addressComponent"][@"city"] forKey:@"city"];
//        [defaults synchronize];
//    }];

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
         return 3;
    }
    else {
//        if (_poiSearchArray.count != 0) {
//            
//            return _poiSearchArray.count;
//
//        }
//         return _poiSearchArray.count;
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual: _tableView]) {
        
        if (section == 0) {
            return 5;
        }
        else if (section == 1) {
            return 2;
        }
        else if (section == 2) {
            return 0;
        }
        return 0;
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
                
                UIImageView *imageView = [[UIImageView alloc]init];
                imageView.frame = CGRectMake(18, 24, 8, 8);
                [imageView setImage:[UIImage imageNamed:@"star"]];
                [cell.contentView addSubview:imageView];
                
                _addressTextField = [[UITextField alloc]init];
                _addressTextField.frame = CGRectMake(37, 21, ScreenWidth - 37 - 10, 15);
                _addressTextField.placeholder = @"地址";
                _addressTextField.delegate = self;
                _addressTextField.font = [UIFont systemFontOfSize:15];
                _addressTextField.tag = 1000;
                [cell.contentView addSubview:_addressTextField];
                
                
                _currentLocation = ^(BMKUserLocation *userLocation) {
                    
                    NSString *longitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
                    NSString *latitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];
                    NSLog(@"%@%@",longitude,latitude);
                    
                };
            }
            else if (indexPath.row == 1) {
                
                UIImageView *imageView = [[UIImageView alloc]init];
                imageView.frame = CGRectMake(18, 24, 8, 8);
                [imageView setImage:[UIImage imageNamed:@"star"]];
                [cell.contentView addSubview:imageView];
                
                _nameTextField = [[UITextField alloc]init];
                _nameTextField.frame = CGRectMake(37, 21, ScreenWidth - 37 - 10, 15);
                _nameTextField.placeholder = @"姓名";
                _nameTextField.delegate = self;
                _nameTextField.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:_nameTextField];
            }
            else if (indexPath.row == 2) {
                
                UIImageView *imageView = [[UIImageView alloc]init];
                imageView.frame = CGRectMake(18, 24, 8, 8);
                [imageView setImage:[UIImage imageNamed:@"star"]];
                [cell.contentView addSubview:imageView];
                
                _idTextField = [[UITextField alloc]init];
                _idTextField.frame = CGRectMake(37, 21, ScreenWidth - 37 - 10, 15);
                _idTextField.placeholder = @"身份证号码";
                _idTextField.delegate = self;
                _idTextField.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:_idTextField];
            }
            else if (indexPath.row == 3) {
                
                UIImageView *imageView = [[UIImageView alloc]init];
                imageView.frame = CGRectMake(18, 24, 8, 8);
                [imageView setImage:[UIImage imageNamed:@"star"]];
                [cell.contentView addSubview:imageView];
                
                UILabel *label = [[UILabel alloc]init];
                label.frame = CGRectMake(37, 21, 140, 15);
                label.text = @"上传身份证照片";
                label.font = [UIFont systemFontOfSize:15];
                label.textColor = [UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f];
                [cell.contentView addSubview:label];
                
                _pictureViewID = [[PictureView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(label.frame) + 10, ScreenWidth - 20, 60)];
                
                [_pictureViewID.addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:_pictureViewID];
                
                //            UIButton *addBtn = [[UIButton alloc]init];
                //            addBtn.frame = CGRectMake(20, CGRectGetMaxY(label.frame) + 21, 48, 48);
                //            [addBtn setBackgroundImage:[UIImage imageNamed:@"pic"] forState:UIControlStateNormal];
                //            [cell.contentView addSubview:addBtn];
                
            }
            else {
                
                
                UILabel *label = [[UILabel alloc]init];
                label.frame = CGRectMake(18, 21, 300, 20);
                label.text = @"上传健康证或其他你觉得很牛X的证件照片";
                label.numberOfLines = 1;
                label.lineBreakMode = NSLineBreakByCharWrapping;
                label.font = [UIFont systemFontOfSize:15];
                label.textColor = [UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f];
                [cell.contentView addSubview:label];
                
                _pictureViewHealth = [[PictureView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(label.frame) + 10, ScreenWidth - 20, 60)];
                [_pictureViewHealth.addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:_pictureViewHealth];
                
                //            UIButton *addBtn = [[UIButton alloc]init];
                //            addBtn.frame = CGRectMake(20, CGRectGetMaxY(label.frame) + 21, 48, 48);
                //            [addBtn setBackgroundImage:[UIImage imageNamed:@"pic"] forState:UIControlStateNormal];
                //            [cell.contentView addSubview:addBtn];
                
            }
        }
        else if(indexPath.section == 1) {
            
            cell.separatorInset = UIEdgeInsetsZero;
            if (indexPath.row == 0) {
                cell.textLabel.text = @"支付宝";
                cell.textLabel.textColor = [UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f];
                cell.textLabel.font =[UIFont systemFontOfSize:15];
                
                _alipayTextField = [[UITextField alloc]init];
                _alipayTextField.frame = CGRectMake(70, 15, ScreenWidth - 70 - 10, 18);
                _alipayTextField.font = [UIFont systemFontOfSize:15];
                _alipayTextField.delegate = self;
                [cell.contentView addSubview:_alipayTextField];
            }
            else if (indexPath.row == 1) {
                cell.textLabel.text = @"银行卡";
                cell.textLabel.textColor = [UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f];
                cell.textLabel.font =[UIFont systemFontOfSize:15];
                
                _bankCardTextField = [[UITextField alloc]init];
                _bankCardTextField.delegate = self;
                _bankCardTextField.frame = CGRectMake(70, 15, ScreenWidth - 70 - 10, 18);
                //            _bankCardTextField.layer.borderColor = [UIColor blackColor].CGColor;
                //            _bankCardTextField.layer.borderWidth = 1.0;
                _bankCardTextField.font = [UIFont systemFontOfSize:15];
                [cell.contentView addSubview:_bankCardTextField];
                
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
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 2, 60, 20)];
//        label.textAlignment = NSTextAlignmentLeft;
//        label.text = _poiSearchArray[indexPath.row];
//        [_poiSearchView addSubview:label];
    
        return cell;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual: _tableView]) {
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                
                return 47;
            }
            else if (indexPath.row == 1) {
                
                return 47;
            }
            else if (indexPath.row == 2) {
                
                return 47;
            }
            else if (indexPath.row == 3) {
                
                return 118;
            }
            else {
                return 118;
            }
        }
        else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                return 47;
            }
            else if (indexPath.row == 1) {
                return 47;
            }
            
        }
        else if (indexPath.section == 2) {
            
            return 0.1;
        }
        return 0;

    }
    else {
        
        return 30;
    }
    
}

//headerView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if ([tableView isEqual: _tableView]) {
        
        if (section == 0) {
            return 12;
        }
        else if (section == 1){
            return 47;
        }
        else if (section == 2) {
            return 65;
        }
        return 0.1;

    }
    else {
        return 0.1;
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if ([tableView isEqual: _tableView]) {
        
        if (section == 0) {
            
            UIView *headerView = [[UIView alloc]init];
            headerView.bounds = CGRectMake(0, 0, ScreenWidth, 20);
            return headerView;
        }
        else if (section == 1){
            
            UIView *headerView = [[UIView alloc]init];
            headerView.bounds = CGRectMake(0, 0, ScreenWidth, 20);
            
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake(10, 18, 100, 15);
            label.text = @"提现帐号";
            label.textColor = [UIColor blackColor];
            [headerView addSubview:label];
            return headerView;
        }
        else if (section == 2) {
            UIView *headerView = [[UIView alloc]init];
            headerView.frame = CGRectMake(0, 0, ScreenWidth, 40);
            headerView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
            
            UIButton *btn = [[UIButton alloc]init];
            btn.frame = CGRectMake(20, 18, ScreenWidth - 40, 37);
            [btn setTitle:@"保存资料" forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"button-dingdan-1"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
            [headerView addSubview:btn];
            
            return headerView;
        }
        return nil;

    }
    else {
        
        return nil;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (void)buttonPressed:(UIButton *)sender {
    
    WaitForAuditViewController *wvc = [[WaitForAuditViewController alloc]init];
    [self.navigationController pushViewController:wvc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
}

#pragma mark - 上传资料

- (BOOL)isParamsRight {

    BOOL isRight = NO;
    
    if (_addressTextField.text.length > 0 && _nameTextField.text.length > 0 && _idTextField.text.length > 0 && _pictureViewID.imgArray.count > 0) {
        isRight = YES;
    }
    
    return isRight;
}

- (void)saveInfo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (![self isParamsRight]) {
        [DisplayView displayShowWithTitle:@"请填写完整"];
        NSLog(@"请填写完整");
        return;
    }
   
    NSString *tel = [defaults objectForKey:@"tel"];
    NSString *pwd = [defaults objectForKey:@"pwd"];
    NSString *latitude = [defaults objectForKey:@"latitude"];
    NSString *longitude = [defaults objectForKey:@"longitude"];
    
    NSString *adress = _addressTextField.text;
    NSString *name = _nameTextField.text;
    NSString *idCard = _idTextField.text;
    

    
    NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"lat":latitude,@"lon":longitude,@"address":adress,@"name":name,@"card_num":idCard,@"alipay":_alipayTextField.text,@"bankcard":_bankCardTextField.text};
  
    [NetWorkHandler joinedChef:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i = 0; i < _pictureViewID.imgArray.count; i++) {
            
            [formData appendPartWithFileData:_pictureViewID.imgArray[i] name:@"card" fileName:[NSString stringWithFormat:@"card_%i.png", i] mimeType:@"image/jpeg"];
        }
        
        for (int i = 0; i < _pictureViewHealth.imgArray.count; i++) {
            
            [formData appendPartWithFileData:_pictureViewHealth.imgArray[i] name:@"other" fileName:[NSString stringWithFormat:@"other_%i.png", i] mimeType:@"image/jpeg"];
            
        }
        
    } completionHandler:^(id content) {
        
        
        WaitForAuditViewController *wvc = [[WaitForAuditViewController alloc]init];
        [self.navigationController pushViewController:wvc animated:YES];
    }];
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



//点击拍照button
- (void)addBtnClick:(UIButton *)sender {
    
    _currentPV = (PictureView *)sender.superview;
    [_imageList removeAllObjects];
    
    [self.view endEditing:YES];
    if ([_imageList count] == 5) {
        
        return;
    }
    [TakePictureView takePictureViewWithTakePictureBlock:^(PickMethods method) {
        switch (method) {
            case pickTakePhotos:
                [self pickImageFromCamera];
                break;
            case pickImageFromAlbum:
                
                [self pickImageFromAlbum];
                break;
            case pickCancel:
                
                break;
            default:
                break;
        }
    }];

}

#pragma mark -相册相关-
- (void)pickImageFromAlbum
{
    
    [self.view endEditing:YES];
    //    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
    //检查是否有相机
    UIImagePickerController *imagepicker = [[UIImagePickerController alloc] init];
    imagepicker.delegate = self;
    imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagepicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagepicker.allowsEditing = YES;
    
    //        [self presentModalViewController:imagepicker animated:YES];
    [self presentViewController:imagepicker animated:YES completion:^{
        
    }];
    //    }
}

#pragma mark- UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _isEdit = NO;
    //压缩图片分辨率
    //图片编辑状态
    NSData *imageData1 = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerEditedImage"], 0.1);
    //这段代码的作用是修复拍摄图片传到服务器时倒置等情况
    //UIImage *img = ((UIImage *)[info objectForKey:@"UIImagePickerControllerOriginalImage"]).fixOrientation;
    
    //    NSData *imageData1 = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"],1.0);
    UIImage *img = [UIImage imageWithData:imageData1];
    [_imageList addObject:img];
    
    for (int i = 0 ; i < _imageList.count; i++) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString * _filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"img_%d.jpg", i]];   // 保存文件的名称
        [UIImagePNGRepresentation(_imageList[i])writeToFile:_filePath atomically:YES];
    }
    
    
    
    //  NSLog(@"%d",_imageList.count);
    [self updataImageList];
    //tempimg = [self compressUploadPic:img];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)pickImageFromCamera
{
    [self.view endEditing:YES];
    
    if (IOS7) {
        NSString *mediaType = AVMediaTypeVideo;// Or AVMediaTypeAudio
        
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        
        // This status is normally not visible—the AVCaptureDevice class methods for discovering devices do not return devices the user is restricted from accessing.
        
        if(authStatus ==AVAuthorizationStatusRestricted){
            NSLog(@"Restricted");
        }
        // The user has explicitly denied permission for media capture.
        else if(authStatus == AVAuthorizationStatusDenied){
            NSLog(@"Denied");     //应该是这个，如果不允许的话
            //            [Common showAlert:@"没有权限访问你的相机，请进入系统“设置>隐私>相机”,允许访问您的相机"];
            return;
            
        }
        // The user has explicitly granted permission for media capture, or explicit user permission is not necessary for the media type in question.
        else if(authStatus == AVAuthorizationStatusAuthorized){
            NSLog(@"Authorized");
        }
        // Explicit user permission is required for media capture, but the user has not yet granted or denied such permission.
        else if(authStatus == AVAuthorizationStatusNotDetermined){
            
            [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
                if(granted){
                    NSLog(@"Granted access to %@", mediaType);
                }
                else{
                    NSLog(@"Not granted access to %@", mediaType);
                }
            }];
            
        }
    }
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *imagepicker = [[UIImagePickerController alloc] init];
        imagepicker.delegate = self;
        imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagepicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        imagepicker.allowsEditing = YES;
        
        //        [self presentModalViewController:imagepicker animated:YES];
        [self presentViewController:imagepicker animated:YES completion:^{
            
        }];
    }
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
