//
//  ApplyToJoinArmedEscort.m
//  BagChef
//
//  Created by zhangzhi on 15/7/29.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "ApplyToJoinArmedEscort.h"
#import "WaitForAuditViewController.h"
#import "PictureView.h"
#import "TakePictureView.h"

@interface ApplyToJoinArmedEscort ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
    
    UITableView *_tableView;
    
    UITextField *_idTextField;
    PictureView *_pictureViewID;
    PictureView *_currentPV;
    NSMutableArray *_imageList;
    
    UITextField *_alipayTextField;
    UITextField *_bankCardTextField;
    
    UITextField *_nameTextField;

    
}

- (void)initializeDataSource;
- (void)initializeInterface;
@end

@implementation ApplyToJoinArmedEscort

-(void)initializeDataSource {
    
    _imageList = [NSMutableArray array];

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
    [dvc.ztabBarController setHideEsunTabBar:YES];
    
    NSLog(@"armedFram:%@",NSStringFromCGRect(self.view.frame));
}


- (void)initializeInterface {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.leftButton.hidden = NO;
    self.titleLabel.text = @"申请加入镖师";
    [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftBatButtonItem) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
    [self.view addSubview:_tableView];
    
}
- (void)leftBatButtonItem {
    
    [self.navigationController popViewControllerAnimated:YES];
//    [self.presentationController d]
//    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 3;
    }
    else if (section == 1) {
        return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CELLID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
//            [cell.imageView setImage:[UIImage imageNamed:@"star"]];
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.frame = CGRectMake(18, 24, 8, 8);
            [imageView setImage:[UIImage imageNamed:@"star"]];
            [cell.contentView addSubview:imageView];
            
           _nameTextField= [[UITextField alloc]init];
            _nameTextField.frame = CGRectMake(37, 21, ScreenWidth - 37 - 10, 15);
            //        textField.layer.borderColor = [UIColor blackColor].CGColor;
            //        textField.layer.borderWidth = 1.0;
            _nameTextField.placeholder = @"姓名";
            _nameTextField.font = [UIFont systemFontOfSize:15];
            [cell.contentView addSubview:_nameTextField];
        }
        else if (indexPath.row == 1) {
            
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
        else {
            
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.frame = CGRectMake(18, 24, 8, 8);
            [imageView setImage:[UIImage imageNamed:@"star"]];
            [cell.contentView addSubview:imageView];
            
            UILabel *label = [[UILabel alloc]init];
            label.frame = CGRectMake(37, 21, 140, 15);
            label.text = @"上传身份证照片";
            label.textColor = [UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f];
            [cell.contentView addSubview:label];
            
//            UIButton *addBtn = [[UIButton alloc]init];
//            addBtn.frame = CGRectMake(20, CGRectGetMaxY(label.frame) + 21, 48, 48);
//            [addBtn setBackgroundImage:[UIImage imageNamed:@"pic"] forState:UIControlStateNormal];
//            [cell.contentView addSubview:addBtn];
            
            _pictureViewID = [[PictureView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(label.frame) + 10, ScreenWidth - 20, 60)];
            
            [_pictureViewID.addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:_pictureViewID];

        }
    }
    else if(indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"支付宝";
            cell.textLabel.textColor = [UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f];
            
            _alipayTextField = [[UITextField alloc]init];
            _alipayTextField.frame = CGRectMake(70, 15, ScreenWidth - 70 - 10, 18);
            _alipayTextField.font = [UIFont systemFontOfSize:15];
            _alipayTextField.delegate = self;
            [cell.contentView addSubview:_alipayTextField];
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = @"银行卡";
            cell.textLabel.textColor = [UIColor colorWithRed:0.667f green:0.667f blue:0.667f alpha:1.00f];
            
            _bankCardTextField = [[UITextField alloc]init];
            _bankCardTextField.delegate = self;
            _bankCardTextField.frame = CGRectMake(70, 15, ScreenWidth - 70 - 10, 18);
            //            _bankCardTextField.layer.borderColor = [UIColor blackColor].CGColor;
            //            _bankCardTextField.layer.borderWidth = 1.0;
            _bankCardTextField.font = [UIFont systemFontOfSize:15];
            [cell.contentView addSubview:_bankCardTextField];

        }
    }
    
    
//    if (indexPath.row == 0) {
//        
////        cell.textLabel.text = @"电话";
//        UITextField *textField = [[UITextField alloc]init];
//        textField.frame = CGRectMake(20, 21, 40, 22);
////        textField.layer.borderColor = [UIColor blackColor].CGColor;
////        textField.layer.borderWidth = 1.0;
//        textField.placeholder = @"电话";
//        [cell.contentView addSubview:textField];
//    }
//    else if (indexPath.row == 1) {
//        
////        cell.textLabel.text = @"密码至少为6位";
//       
//    }
//    else if (indexPath.row == 2) {
//       
//           }
//    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 47;
        }
        if (indexPath.row == 1) {
            return 47;
        }
        else if (indexPath.row == 2) {
            return 118;
        }
    }
    else if (indexPath.section == 1) {
        return 47;
    }
    return 0;
}

//headerView
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 12;
    }
    else {
        return 47;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        UIView *headerView = [[UIView alloc]init];
        headerView.bounds = CGRectMake(0, 0, ScreenWidth, 20);
        return headerView;
    }
    else {
        
        UIView *headerView = [[UIView alloc]init];
        headerView.bounds = CGRectMake(0, 0, ScreenWidth, 20);
       
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(10, 18, 100, 15);
        label.text = @"提款帐号";
        label.textColor = [UIColor blackColor];
        [headerView addSubview:label];
        return headerView;
    }
   
}


//footerView
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 1) {
        return 80;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    
    if (section == 1) {
        
        UIView *view = [[UIView alloc]init];
        view.bounds = CGRectMake(0, 0, ScreenWidth, 80);
        //    view.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
        
        
        UIButton *confirmBtn = [[UIButton alloc]init];
        confirmBtn.frame = CGRectMake(30, 30, ScreenWidth - 60, 37);
        [confirmBtn setTitle:@"确认提交" forState:UIControlStateNormal];
        [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [confirmBtn setBackgroundImage:[UIImage imageNamed:@"button1"] forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:confirmBtn];
        
        return view;

    }
    return nil;
}

#pragma mark - 上传资料

- (void)buttonPressed:(UIButton *)sender {
    
    
    
//    if (![self isParamsRight]) {
//        NSLog(@"请填写完整");
//        return;
//    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tel = [defaults objectForKey:@"tel"];
    NSString *pwd = [defaults objectForKey:@"pwd"];
    NSString *name = _nameTextField.text;
    NSString *idCard = _idTextField.text;
    
    
    
    NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"name":name,@"card_num":idCard,@"alipay":_alipayTextField.text,@"bankcard":_bankCardTextField.text};
    
    [NetWorkHandler joinedChef:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i = 0; i < _pictureViewID.imgArray.count; i++) {
            
            [formData appendPartWithFileData:_pictureViewID.imgArray[i] name:@"card" fileName:[NSString stringWithFormat:@"card_%i.png", i] mimeType:@"image/jpeg"];
        }
        
    } completionHandler:^(id content) {
        
        WaitForAuditViewController *wvc = [[WaitForAuditViewController alloc]init];
        [self.navigationController pushViewController:wvc animated:YES];
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updataImageList {
    
    [_currentPV imageData:_imageList];
    NSLog(@"%@",_imageList);
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
