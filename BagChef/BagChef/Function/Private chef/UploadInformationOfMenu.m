//
//  UploadInformationOfMenu.m
//  BagChef
//
//  Created by zhangzhi on 15/7/29.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "UploadInformationOfMenu.h"

#import "PictureView.h"
#import "TakePictureView.h"
#import "ZHPickView.h"
@interface UploadInformationOfMenu ()<UITableViewDelegate,UITableViewDataSource,ZHPickViewDelegate,UITextFieldDelegate> {
    
    UITableView *_tableView;
    UIButton *_imageButton;
    UIButton *_upMenuBtn;
    
    PictureView *_pictureViewMenu;
    PictureView *_currentPV;
    NSMutableArray *_imageList;
    
    UITextField *_nameOfMenu;
    UITextField *_priceOfMenu;
    UITextField *_numberOfMenu;
    UITextField *_timeOfGet;
    UITextField *_timeOfWork;
    UITextField *_introduceOfMenu;
    UIDatePicker *_sellOfPicker;
    UIDatePicker *_getOfPicker;
    
}
@property (nonatomic , strong) ZHPickView *pickerView;
@property (nonatomic,assign)NSInteger  row;

- (void)initializeDataSource;
- (void)initializeInterface;
@end

@implementation UploadInformationOfMenu

-(void)initializeDataSource {
    
    _imageList = [[NSMutableArray alloc]init];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.titleLabel setText:@"上传菜品资料"];
    self.leftButton.hidden = NO;
    [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(barButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];
    
    [self initializeDataSource];
    [self initializeInterface];
}

- (void)initializeInterface {
    
    _tableView = [[UITableView alloc]init];
    [_tableView setFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 )];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [_tableView setBounces:NO];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [_tableView setBackgroundColor:[UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f]];
    
// 取消没数据下划线
    _tableView.tableFooterView = [[UIView alloc]init];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self.view addSubview:_tableView];
    
    _imageButton = [[UIButton alloc]init];
    
    UIView *footView = [[UIView alloc]init];
    footView.frame = CGRectMake(0, 444-64 - 1, ScreenWidth, 100);
    footView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
//    [_tableView setContentSize:CGSizeMake(ScreenWidth, CGRectGetMaxY(_tableView.frame)- 100)];
//    [_tableView addSubview:footView];
    [_tableView setTableFooterView:footView];
    
    _upMenuBtn = [[UIButton alloc]init];
    _upMenuBtn.frame = CGRectMake(30, 40, ScreenWidth - 60, 40);
    [_upMenuBtn setTitle:@"我填好了,上架售卖了啦~~" forState:UIControlStateNormal];
    
    [_upMenuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_upMenuBtn setImage:[UIImage imageNamed:@"button1"] forState:UIControlStateNormal];
    [_upMenuBtn setBackgroundImage:[UIImage imageNamed:@"button1"] forState:UIControlStateNormal];
    [_upMenuBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:_upMenuBtn];
    
}
- (void)barButtonItemMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 上传资料
- (void)buttonPressed:(UIButton *)sender {
    NSUserDefaults *defautls = [NSUserDefaults standardUserDefaults];
    NSString *tel = [defautls objectForKey:@"tel"];
    NSString *pwd = [defautls objectForKey:@"pwd"];
    NSString *name = _nameOfMenu.text;
    NSString *price = _priceOfMenu.text;
    NSString *surplus_num = _numberOfMenu.text;
    NSString *sell_time_start = _timeOfWork.text;
    NSString *sell_time_end = _timeOfGet.text;
    NSString *content = _introduceOfMenu.text;
    NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"name":name,@"price":price,@"surplus_num":surplus_num,@"sell_time_start":sell_time_start,@"sell_time_end":sell_time_end,@"content":content};
    [NetWorkHandler addDish:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i = 0; i < _pictureViewMenu.imgArray.count; i++) {
            
            [formData appendPartWithFileData:_pictureViewMenu.imgArray[i] name:@"pic" fileName:[NSString stringWithFormat:@"pic_%i.png", i] mimeType:@"image/jpeg"];
        }

    } completionHandler:^(id content) {
        
        NSLog(@"uploadMenu:%@",content);
        [DisplayView displayShowWithTitle:content[@"info"]];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(popToTopViewController) userInfo:nil repeats:NO];
        
    }];
}

//延迟方法
- (void)popToTopViewController {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    DefaultViewController *dvc = (DefaultViewController *)[AppDelegate app].window.rootViewController;
    [dvc.ztabBarController setHideEsunTabBarBtn:YES];
}

- (void)displayDatePickerTime {
    
    NSDate *date=[NSDate date];
    _pickerView = [[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeTime isHaveNavControler:NO];
    _pickerView.delegate=self;
    [_pickerView show];
    
    
}
//
//- (void)displayDatePickerDate {
//    
//    NSDate *date=[NSDate date];
//    _pickview=[[ZHPickView alloc] initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
//    _pickview.delegate = self;
//    [_pickview show];
//    
//}


#pragma mark -UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    else {
        return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CELLID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CELLID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        UIView *view = [[UIView alloc]init];
        view.frame = CGRectMake(0, 0, ScreenWidth, 120);
        [cell.contentView addSubview:view];
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(15, 16, 120, 20);
        label.text = @"上传菜品照片";
        [view addSubview:label];
        
        _pictureViewMenu = [[PictureView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(label.frame) + 10, ScreenWidth - 20, 60)];        
        [_pictureViewMenu.addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:_pictureViewMenu];

    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"菜品名称";
            
            _nameOfMenu = [[UITextField alloc]initWithFrame:CGRectMake(90, 12, ScreenWidth - 90 - 80, 20)];
//            _nameOfMenu.layer.borderColor = [UIColor grayColor].CGColor;
//            _nameOfMenu.layer.borderWidth = 1.0;
            _nameOfMenu.textColor = [UIColor grayColor];
            [cell.contentView addSubview:_nameOfMenu];
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = @"菜品价格";
            UILabel *label = [[UILabel alloc]init];
            label.bounds = CGRectMake(0, 0, 50, 30);
            label.text = @"元/份";
            cell.accessoryView = label;
            
            _priceOfMenu = [[UITextField alloc]initWithFrame:CGRectMake(90, 12, ScreenWidth - 90 - 80, 20)];
            _priceOfMenu.textColor = [UIColor grayColor];
            [cell.contentView addSubview:_priceOfMenu];
        }
        else if (indexPath.row == 2) {
            cell.textLabel.text = @"可售份数";
            UILabel *label = [[UILabel alloc]init];
            label.bounds = CGRectMake(0, 0, 50, 30);
            label.text = @"份";
            cell.accessoryView = label;
            
            _numberOfMenu = [[UITextField alloc]initWithFrame:CGRectMake(90, 12, ScreenWidth - 90 - 80, 20)];
            _numberOfMenu.textColor = [UIColor grayColor];
            [cell.contentView addSubview:_numberOfMenu];
        }
        else if (indexPath.row == 3) {
            
            cell.textLabel.text = @"售卖开始时间";
            
            _timeOfWork = [[UITextField alloc]initWithFrame:CGRectMake(130, 12, ScreenWidth - 130 - 80, 20)];
            [_timeOfWork setUserInteractionEnabled:NO];
            _timeOfWork.textColor = [UIColor grayColor];
            [cell.contentView addSubview:_timeOfWork];
        }
        else if (indexPath.row == 4) {
            cell.textLabel.text = @"售卖结束时间";
            
            _timeOfGet = [[UITextField alloc]initWithFrame:CGRectMake(130, 12, ScreenWidth - 130 - 80, 20)];
            [_timeOfGet setUserInteractionEnabled:NO];
//            _timeOfGet.layer.borderWidth = 1.0;
//            _timeOfGet.layer.borderColor = [UIColor grayColor].CGColor;
            _timeOfGet.textColor = [UIColor grayColor];
            [cell.contentView addSubview:_timeOfGet];
        }
        else if (indexPath.row == 5) {
            cell.textLabel.text = @"菜品介绍";
            _introduceOfMenu = [[UITextField alloc]init];
//            label.bounds = CGRectMake(0, 0, 250, 30);
            _introduceOfMenu.frame = CGRectMake(90 , 12, 250, 20);
            _introduceOfMenu.font = [UIFont systemFontOfSize:15];
            _introduceOfMenu.placeholder = @"介绍一下你的菜品吧";
            _introduceOfMenu.textColor = [UIColor grayColor];
            [_introduceOfMenu setUserInteractionEnabled:NO];
            [cell.contentView addSubview:_introduceOfMenu];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    return cell;
}

//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 120;
    }
    else {
        return 44;
    }
}

//headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc]init];
    view.bounds = CGRectMake(0, 0, ScreenWidth, 20);
    view.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
    return view;
}


//headerView 的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        if (indexPath.row == 3) {
            
            _row = indexPath.row;
            [self displayDatePickerTime];
            _sellOfPicker = [[UIDatePicker alloc]init];
//            _sellOfPicker.frame = CGRectMake(0, ScreenHeight - 200, ScreenWidth, 200);
//            [_sellOfPicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
//            _sellOfPicker.backgroundColor = [UIColor groupTableViewBackgroundColor];
//            [self.view addSubview:_sellOfPicker];
//            
//            //创建当前时间
//            NSDate *date = [NSDate date];
//            //在当前时间加上的时间
//            NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
//            NSDateComponents *offsetComponets = [[NSDateComponents alloc]init];
//            [offsetComponets setYear:0];
//            [offsetComponets setMonth:0];
//            [offsetComponets setDay:5];
//            [offsetComponets setHour:20];
//            [offsetComponets setMinute:0];
//            [offsetComponets setSecond:0];
//            
//            //设置最大时间
//            NSDate *maxDate = [gregorian dateByAddingComponents:offsetComponets toDate:date options:0];
//            _sellOfPicker.minimumDate = date;
//            _sellOfPicker.maximumDate = maxDate;

        }
        if (indexPath.row == 4) {
            
            _row = indexPath.row;
            [self displayDatePickerTime];
            _sellOfPicker = [[UIDatePicker alloc]init];
        }
        if (indexPath.row == 5) {
            
//            __weak PersonInfoController * personInfoVC = self;
            AlertTextfield *alertText = [[AlertTextfield alloc]initWithFrame:CGRectMake(ScreenWidth/7, ScreenHeight / 2 - 150, ScreenWidth/7*5, 150)];
            __weak typeof(alertText)myself = alertText;
            alertText.cancelBlock = ^{
              _introduceOfMenu.text = myself.textField.text;
            };
            [self.view addSubview:alertText];
        }
    }
}

- (void)dateChange:(id)sender {
    
    UIDatePicker *datePicker = (UIDatePicker *)sender;
//    NSDate *date = control.date;
    
    NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    datePicker.locale = locale;
    
    
    NSDate *pickerDate = [_sellOfPicker date];
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc]init];
    [pickerFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [pickerFormatter stringFromDate:pickerDate];
    
    _timeOfWork.text = dateString;
}


#pragma mark ZhpickVIewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(id )resultString{
    
    NSDate *earlierDate = [NSDate date];
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc]init];
    [pickerFormatter setDateFormat:@"HH:mm"];
    NSString *dateString = [pickerFormatter stringFromDate:resultString];
    if (_row == 3) {
        _timeOfWork.text = dateString;
        
//        //转字符串为Date
//        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//        [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
//        [formatter setDateFormat:@"yyyy-MM-dd-HH-ss"];
//        earlierDate = [formatter dateFromString:_timeOfWork.text];
    }
    else if (_row == 4 && _timeOfWork.text != nil ) {
        //转字符串为Date
//        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//        [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
//        [formatter setDateFormat:@"yyyy_MM_dd_HH_ss"];
//        NSDate *nextDate =  [formatter dateFromString:_timeOfGet.text];
//        NSTimeInterval timeInterval = [nextDate timeIntervalSinceDate:earlierDate];
        
      _timeOfGet.text = dateString;
        
    }
    
    
    NSLog(@"%@",resultString);
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
