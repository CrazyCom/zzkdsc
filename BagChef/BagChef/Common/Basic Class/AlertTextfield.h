//
//  AlertTextfield.h
//  WuZi
//
//  Created by mac on 15/4/3.
//  Copyright (c) 2015年 chenfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertTextfield : UIView
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UITextField * textField;
@property (nonatomic ,copy) void (^cancelBlock)();
@end
