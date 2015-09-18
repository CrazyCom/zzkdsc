//
//  ExtractDepositViewController.m
//  BagChef
//
//  Created by zhangzhi on 15/9/15.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "ExtractDepositViewController.h"

@interface ExtractDepositViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *_tableView;
    UIButton *getBtn;
    
    UILabel *bankLabel;
    UILabel *alipayLabel;
    UIButton *btn3;
    UIButton *btn4;
    
    UILabel *extractLabel;
    UILabel *extractOfLabel;
}

- (void)initializeInterface;
- (void)initializeDataSource;
@end

@implementation ExtractDepositViewController

-(void)initializeDataSource {
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeDataSource];
    [self initializeInterface];
}

- (void)initializeInterface {
    
    self.titleLabel.text = @"提现";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.leftButton.hidden = NO;
    [self.leftButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(barButtonItemMethod) forControlEvents:UIControlEventTouchUpInside];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    //footView
    UIView *footerView = [[UIView alloc]init];
    footerView.frame = CGRectMake(0, 0, ScreenWidth, 60);
    footerView.backgroundColor = [UIColor colorWithRed:0.953f green:0.949f blue:0.953f alpha:1.00f];
    _tableView.tableFooterView = footerView;
    
    UIView *upFooterView = [[UIView alloc]init];
    upFooterView.frame = CGRectMake(0, 14, ScreenWidth, 46);
    upFooterView.backgroundColor = [UIColor colorWithRed:0.937f green:0.937f blue:0.957f alpha:1.00f];
    [footerView addSubview:upFooterView];
    
    getBtn = [[UIButton alloc]init];
    getBtn.frame = CGRectMake(50, 8, ScreenWidth - 100, 30);
    [getBtn setTitle:@"确认提现" forState:UIControlStateNormal];
    getBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [getBtn setBackgroundImage:[UIImage imageNamed:@"button-dingdan-1"] forState:UIControlStateNormal];
    [getBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [upFooterView addSubview:getBtn];
    

}

- (void)barButtonItemMethod {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buttonPressed:(UIButton *)sender {
    
    
    if (sender.tag == 24) {
        
        btn3.selected = YES;
        btn4.selected = NO;
    }
    else if (sender.tag == 25) {
        
        btn3.selected = NO;
        btn4.selected = YES;
    }

}


#pragma mark - 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    else if (section == 1) {
        
        return 2;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellID = @"CELLID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        
        if (!extractLabel) {
            
            extractLabel = [[UILabel alloc]init];
            extractLabel.frame = CGRectMake(10, 12, 80, 20);
            extractLabel.font = [UIFont systemFontOfSize:15];
            extractLabel.text = @"提现金额";
            [cell.contentView addSubview:extractLabel];
            
        }
        if (!extractOfLabel) {
            
            extractOfLabel = [[UILabel alloc]init];
            extractOfLabel.frame = CGRectMake(CGRectGetMaxX(extractLabel.frame), 12, ScreenWidth - 10 - CGRectGetMaxX(extractLabel.frame), 20);
            extractOfLabel.font = [UIFont systemFontOfSize:15];
            extractOfLabel.text = @"当前余额为30.00元";
            extractOfLabel.textColor = [UIColor grayColor];
            [cell.contentView addSubview:extractOfLabel];
        }
        
    }
    else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            if (!bankLabel) {
                btn3 = [[UIButton alloc]init];
                btn3.tag = 24;
                btn3.frame = CGRectMake(11, 13, 21, 21);
                [btn3 setImage:[UIImage imageNamed:@"choose-n"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"choose"] forState:UIControlStateSelected];
                [btn3 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:btn3];
                [self buttonPressed:btn3];
                
                bankLabel = [[UILabel alloc]init];
                bankLabel.frame = CGRectMake(CGRectGetMaxX(btn3.frame) + 10, CGRectGetMaxY(btn3.frame) - 17, 200, 15);
                bankLabel.font = [UIFont systemFontOfSize:15];
                bankLabel.text = @"支付宝";
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
                alipayLabel.frame = CGRectMake(CGRectGetMaxX(btn4.frame) + 10, 12, ScreenWidth - 10 - CGRectGetMaxX(extractLabel.frame), 20);
                alipayLabel.font = [UIFont systemFontOfSize:15];
                alipayLabel.text = @"中国工商银行 尾号6201 储蓄卡";
                alipayLabel.textColor = [UIColor blackColor];
                [cell.contentView addSubview:alipayLabel];
            }
            
        }

    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 10;
    }
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        UIView *headerView = [[UIView alloc]init];
        headerView.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
        headerView.frame = CGRectMake(0, 0, ScreenWidth, 43);
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(11, 13, 150, 15);
        label.text = @"提现帐号";
        [headerView addSubview:label];
        
        return headerView;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
    
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
