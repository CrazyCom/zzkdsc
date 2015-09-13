//
//  AboutUsViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/8/12.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

- (void)initializeDataSource;
- (void)initializeInterface;
@end

@implementation AboutUsViewController

- (void)initializeDataSource {
    
    
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
    
}


-(void)initializeInterface {
        
    self.view.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
    self.leftButton.hidden = NO;
    self.titleLabel.text = @"投诉建议";
    [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(barButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.frame = CGRectMake(10, 300, ScreenWidth - 20, 48 + [NSString getTextHeightWithFont:[UIFont systemFontOfSize:13] forWidth:ScreenWidth - 20 text:@"如果您在使用过程中，有任何问题或建议，请给我们留言或者联系我们的客服，我们会及时改进，感谢您对我们的支持。"]);
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

}

- (void)barButtonItemMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
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
