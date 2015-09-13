//
//  ConfirmIndentViewController.h
//  BagChef
//
//  Created by zhangzhi on 15/8/5.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "RootViewController.h"

static NSString const* kSumPrice    = @"priceSum";
static NSString const* kSumNum      = @"numSum";


@interface ConfirmIndentViewController : RootViewController

@property (nonatomic, strong) NSMutableDictionary *selectedOrderList;

@property (nonatomic , strong) NSDictionary *cellData;
@property (nonatomic , strong) UILabel *priceOfLabel; //价格
@property (nonatomic , strong) UITextField *numberOfPart; //份数

@end
