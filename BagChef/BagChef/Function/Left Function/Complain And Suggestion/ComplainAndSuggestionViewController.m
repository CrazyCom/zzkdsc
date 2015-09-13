//
//  ComplainAndSuggestionViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/8/12.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "ComplainAndSuggestionViewController.h"

@interface ComplainAndSuggestionViewController () <UITextViewDelegate>{
    
    UITextView *_textView;
    UILabel *_label; //说点什么吧
}

- (void)initializeDataSource;
- (void)initializeInterface;

@end

@implementation ComplainAndSuggestionViewController

-(void)initializeDataSource {
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeDataSource];
    [self initializeInterface];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    DefaultViewController *dvc = (DefaultViewController *)[AppDelegate app].window.rootViewController;
    [dvc.ztabBarController setHideEsunTabBarBtn:YES];
    [dvc.ztabBarController setHideEsunTabBar:YES];
    
}

-(void)initializeInterface {
    
    self.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.view.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
    self.leftButton.hidden = NO;
    self.titleLabel.text = @"投诉建议";
    [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(barButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.frame = CGRectMake(10, 64, ScreenWidth - 20, 48 + [NSString getTextHeightWithFont:[UIFont systemFontOfSize:13] forWidth:ScreenWidth - 20 text:@"如果您在使用过程中，有任何问题或建议，请给我们留言或者联系我们的客服，我们会及时改进，感谢您对我们的支持。"]);
    contentLabel.text = @"如果您在使用过程中，有任何问题或建议，请给我们留言或者联系我们的客服，我们会及时改进，感谢您对我们的支持。";
    NSLog(@"%lf",[NSString getTextHeightWithFont:[UIFont systemFontOfSize:13] forWidth:ScreenWidth - 20 text:@"如果您在使用过程中，有任何问题或建议，请给我们留言或者联系我们的客服，我们会及时改进，感谢您对我们的支持。"]);
    contentLabel.text = @"如果您在使用过程中，有任何问题或建议，请给我们留言或者联系我们的客服，我们会及时改进，感谢您对我们的支持。";

    contentLabel.font = [UIFont systemFontOfSize:13];
//    contentLabel.layer.borderColor = [UIColor grayColor].CGColor;
//    contentLabel.layer.borderWidth = 1.0;
    contentLabel.numberOfLines = 3;
    [self.view addSubview:contentLabel];

    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:contentLabel.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:14];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, contentLabel.text.length)];
    contentLabel.attributedText = attributedString;
    
//调节高度
//    CGSize size = CGSizeMake(ScreenWidth - 20, 45);
//    
//    CGSize labelSize = [contentLabel sizeThatFits:size];
    
    UILabel *serviceLable = [[UILabel alloc]init];
    serviceLable.frame = CGRectMake(CGRectGetMinX(contentLabel.frame), CGRectGetMaxY(contentLabel.frame) , 80, 20);
    serviceLable.text = @"客服热线";
    serviceLable.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:serviceLable];
    
    UILabel *phoneLabel = [[UILabel alloc]init];
    phoneLabel.frame = CGRectMake(CGRectGetMaxX(serviceLable.frame), CGRectGetMinY(serviceLable.frame), 100, 20);
    phoneLabel.text = @"400-6667700";
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    phoneLabel.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
    phoneLabel.font = [UIFont systemFontOfSize:16];
//    phoneLabel.layer.borderWidth = 1.0;
//    phoneLabel.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:phoneLabel];
    
    UIImageView *phoneImageView = [[UIImageView alloc]init];
    phoneImageView.frame = CGRectMake(CGRectGetMaxX(phoneLabel.frame) + 8, CGRectGetMaxY(phoneLabel.frame) - 17 , 13, 14);
    [phoneImageView setImage:[UIImage imageNamed:@"phone"]];
    [self.view addSubview:phoneImageView];
    
    
    _textView = [[UITextView alloc]init];
    _textView.frame = CGRectMake(10, CGRectGetMaxY(serviceLable.frame) + 20, ScreenWidth - 20, 155);
    _textView.delegate = self;
    [self.view addSubview:_textView];
    
    
    _label = [[UILabel alloc]init];
    _label.frame = CGRectMake(10, 6, 80, 20);
    _label.text = @"说点什么吧!";
    _label.font = [UIFont systemFontOfSize:14];
    _label.textColor = [UIColor grayColor];
    [_textView addSubview:_label];
    
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(10, CGRectGetMaxY(_textView.frame) + 16, ScreenWidth - 20, 39);
    [btn setBackgroundImage:[UIImage imageNamed:@"button-dingdan-1"] forState:UIControlStateNormal];
    [btn setTitle:@"我已填好，确认提交" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(feedbackBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
}

- (void)feedbackBtn
{
    if (_textView.text.length == 0) {
        [DisplayView displayShowWithTitle:@"请输入建议内容"];
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tel = [defaults objectForKey:@"tel"];
    NSString *pwd = [defaults objectForKey:@"pwd"];
    
    [NetWorkHandler addFeedback:@{@"tel":tel,@"pwd":pwd,@"content":_textView.text} completionHandler:^(id content) {
        NSLog(@" content == %@",content);
        [DisplayView displayShowWithTitle:content[@"info"]];
        if ([content[@"status"] integerValue] == 0) {
            
        }else{
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    }];
}



- (void)barButtonItemMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma TextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    _label.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (_textView.text.length == 0) {
        _label.hidden = NO;
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
