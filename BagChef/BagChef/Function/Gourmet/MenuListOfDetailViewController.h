//
//  MenuListOfDetailViewController.h
//  BagChef
//
//  Created by zhangzhi on 15/8/4.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "RootViewController.h"

@interface MenuListOfDetailViewController : RootViewController

@property (nonatomic , strong) UIImageView *headerImageView; //头像
@property (nonatomic , strong) UILabel *nameLabel; // 姓名
@property (nonatomic , strong) UIButton *idImageBtn; //身份证
@property (nonatomic , strong) UIButton *healthImageBtn; //健康证
@property (nonatomic , strong) UIImageView *starImageView; //五星
@property (nonatomic , strong) UILabel *positionLabel; //位置
@property (nonatomic , strong) UIButton *confirmBtn; //订
@property (nonatomic , strong) UILabel *priceLabel; //价格
@property (nonatomic , strong) UILabel *fTimeLabel; //起始时间
@property (nonatomic , strong) UILabel *tTimeLabel; //结束时间
@property (nonatomic , strong) UITextView *textView; //菜品介绍

- (id)initWithDishId:(NSString *)dishId;
@end
