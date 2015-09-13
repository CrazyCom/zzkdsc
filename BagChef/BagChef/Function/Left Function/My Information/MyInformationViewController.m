//
//  MyInformationViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/8/11.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "MyInformationViewController.h"
#import "TakePictureView.h"
#import "PictureView.h"
@interface MyInformationViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    UIButton *headImageBtn;
    UITextField *_nameTextField; //昵称
    UITextField *_privateChefAge; //厨龄
    UITextField *_addressTextField; // 地址
    
    UITextField *_alipayTextField;  //支付宝
    UITextField *_bankCardTextField; //银行卡
    
    UITableView *_tableView;
    
    PictureView *_currentPV;
    NSMutableArray *_imageList;
    
    NSMutableArray *_dataSource;
    NSDictionary *_dictionary;
}

- (void)initializeDataSource;
- (void)initializeInterface;
@end

@implementation MyInformationViewController

- (void)initializeDataSource {
    
    _imageList = [[NSMutableArray alloc]init];
    _dataSource = [[NSMutableArray alloc]init];
    _dictionary = [[NSDictionary alloc]init];
    [_dataSource removeAllObjects];
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
    NSString *tel = [defaults objectForKey:@"tel"];
    NSString *pwd = [defaults objectForKey:@"pwd"];
    NSDictionary *dict = @{@"tel":tel,@"pwd":pwd};
    
    [self showLoading];
    __weak typeof (self) myself = self;
    [NetWorkHandler getUserInfoParams:dict completionHandler:^(id content) {
        [self hideLoading];
        NSLog(@"userInfo:%@",content);
        if ([content isKindOfClass:[NSError class]]) {
            
            [DisplayView displayShowWithTitle:@"连接超时"];
            return ;
        }
        else {
            NSLog(@"%@",content);
            [myself hideLoading];
            if (![content isKindOfClass:[NSDictionary class]]) {
                
                [DisplayView displayShowWithTitle:@"连接超时"];
                return ;
            }
            else  if ([content[@"status"] integerValue] == 1) {
                if ([content[@"data"] isKindOfClass:[NSNull class]]) {
                    
                    
                    [DisplayView displayShowWithTitle:@"没有多余数据"];
                    return ;
                }
                
                _dictionary = [NSDictionary dictionaryWithDictionary:content[@"data"]];
                NSString *url = [NSString stringWithFormat:@"http://kdsc.mmqo.com%@",_dictionary[@"icon"]];
                NSLog(@"%@",url);
                NSData * imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                [headImageBtn setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
                
                // bug 判断空
                if (![_dictionary[@"name"] isKindOfClass:[NSNull class]]) {
                    _nameTextField.text = _dictionary[@"name"];
                }
                if (![_dictionary[@"age"] isKindOfClass:[NSNull class]]) {
                    
                    _privateChefAge.text = _dictionary[@"age"];
                }
                if (![_dictionary[@"address"] isKindOfClass:[NSNull class]]) {
                    
                     _addressTextField.text = _dictionary[@"address"];
                }
                if (![_dictionary[@"alipay"] isKindOfClass:[NSNull class]]) {
                    
                     _alipayTextField.text = _dictionary[@"alipay"];
                }
                if (![_dictionary[@"bankcard"] isKindOfClass:[NSNull class]]) {
                    
                     _bankCardTextField.text = _dictionary[@"bankcard"];
                }
                
                
                //发送通知
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"personalInformation" object:_dataSource];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"personalInformation" object:nil userInfo:_dictionary];
            }
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self initializeIndicaterView];
    [self initializeInterface];
    [self initializeDataSource];
    

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    DefaultViewController *dvc = (DefaultViewController *)[AppDelegate app].window.rootViewController;
    [dvc.ztabBarController setHideEsunTabBarBtn:YES];
    [dvc.ztabBarController setHideEsunTabBar:YES];
    
//    [self showLoading];

    
}



-(void)initializeInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.leftButton.hidden = NO;
    [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(barButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];
    
    self.rightButton.hidden = NO;
    [self.rightButton setTitle:@"退出" forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(outBtn) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel.text = @"个人设置";
    self.titleLabel.textColor = [UIColor whiteColor];
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
    
    _currentPV = [[PictureView alloc]init];
}

- (void)barButtonItemMethod {
    
//    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


#pragma mark - <UITableViewDelegate,UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 4;
    }
    else if (section == 1) {
        return 2;
    }
    else if (section == 2) {
        return 0;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellID = [NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"头像";
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            
            headImageBtn = [[UIButton alloc]init];
            headImageBtn.frame = CGRectMake(ScreenWidth - 80, 6, 30, 30);
            headImageBtn.backgroundColor = [UIColor orangeColor];
            //
            
            [headImageBtn addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
           
            [cell.contentView addSubview:headImageBtn];
            
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = @"昵称";
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            
            _nameTextField = [[UITextField alloc]init];
            _nameTextField.frame = CGRectMake(60, 12, ScreenWidth - 60 - 10, 20);
            _nameTextField.placeholder = @"请输入您的昵称";
            _nameTextField.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:_nameTextField];
        }
        else if (indexPath.row == 2) {
            cell.textLabel.text = @"厨龄";
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            
            _privateChefAge = [[UITextField alloc]init];
            _privateChefAge.frame = CGRectMake(60, 12, ScreenWidth - 60 - 10, 20);
            _privateChefAge.placeholder = @"请输入您的厨龄";
            _privateChefAge.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:_privateChefAge];
        }
        else if (indexPath.row == 3) {
            cell.textLabel.text = @"地址";
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            
            _addressTextField = [[UITextField alloc]init];
            _addressTextField.frame = CGRectMake(60, 12, ScreenWidth - 60 - 10, 20);
            _addressTextField.text = @"";
            _addressTextField.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:_addressTextField];
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"支付宝";
            
            
            _alipayTextField = [[UITextField alloc]init];
            _alipayTextField.frame = CGRectMake(80, 12, ScreenWidth - 70 - 10, 20);
            _alipayTextField.text = @"";
            _alipayTextField.font = [UIFont systemFontOfSize:15];
            [cell.contentView addSubview:_alipayTextField];

        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = @"银行卡";
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            
            _bankCardTextField = [[UITextField alloc]init];
            _bankCardTextField.frame = CGRectMake(80, 12, ScreenWidth - 70 - 10, 20);
            _bankCardTextField.placeholder = @"";
            _bankCardTextField.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:_bankCardTextField];

        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        return 55;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 10;
    }
    else if (section == 1) {
        return 40;
    }
    else if (section == 2) {
        return 55;
    }
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        UIView *headerView = [[UIView alloc]init];
        headerView.frame = CGRectMake(0, 0, ScreenWidth, 40);
        headerView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(12, 12, 100, 20);
        label.text = @"提现帐号";
        label.font = [UIFont systemFontOfSize:16];
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

#pragma mark - 添加图片
- (void)headBtnClick {
    
    
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

- (BOOL)isParamsRight {
    
    BOOL isRight = NO;
//    
//    if (_addressTextField.text.length > 0 && _nameTextField.text.length > 0 && _idTextField.text.length > 0 && _pictureViewID.imgArray.count > 0) {
//        isRight = YES;
//    }
//    
    return isRight;
}


#pragma mark - 上传资料
- (void)saveInfo {
    NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
    NSString *tel = [defaults objectForKey:@"tel"];
    NSString *pwd = [defaults objectForKey:@"pwd"];
    NSString *age = _privateChefAge.text;
    NSString *name = _nameTextField.text;
    NSString *address = _addressTextField.text;
    NSString *alipay = _alipayTextField.text;
    NSString *bankcard = _bankCardTextField.text;
    NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"name":name,@"age":age,@"address":address,@"alipay":alipay,@"bankcard":bankcard};
    [self showLoading];
    __weak typeof(self) myself = self;
   [NetWorkHandler modifyUserInfoParams:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
       
       for (int i = 0; i < _currentPV.imgArray.count; i++) {
           
           [formData appendPartWithFileData:_currentPV.imgArray[i] name:@"img" fileName:[NSString stringWithFormat:@"img_%i.png", i] mimeType:@"image/jpeg"];
       }

   } completionHandler:^(id content) {
       [myself hideLoading];
       [DisplayView displayShowWithTitle:content[@"info"]];
       NSLog(@"modify:%@",content);
   }];
}
#pragma mark - 退出
- (void)outBtn {
 
    [Common loginOut];
    [DisplayView displayShowWithTitle:@"退出成功"];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"personalInformation" object:nil userInfo:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark

- (void)updataImageList {
    
    [_currentPV imageData:_imageList];
    [headImageBtn setBackgroundImage:[_imageList firstObject] forState:UIControlStateNormal];
    NSLog(@"%@",_imageList);
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
