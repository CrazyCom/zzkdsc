//
//  GourmetCell.h
//  BagChef
//
//  Created by zhangzhi on 15/8/4.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GourmetCell : UITableViewCell


@property (nonatomic , strong) UIButton *headerImageBtn; //头像
@property (nonatomic , strong) UILabel *nameLabel; // 姓名
@property (nonatomic , strong) UIButton *idBtn;  //身份证
@property (nonatomic , strong) UIButton *healthBtn; //健康证
@property (nonatomic , strong) UIImageView *starImageView; //五星
@property (nonatomic , strong) UILabel *positionLabel; //位置
@property (nonatomic , strong) UIButton *menuImageBtn; //菜品图片
@property (nonatomic , strong) UILabel *nameOfMenuLabel; //菜品名称
@property (nonatomic , strong) UILabel *numberOfSoldLabel; //已售份数
@property (nonatomic , strong) UILabel *nullTopLabel;
@property (nonatomic , copy) void(^sendBtn)(GourmetCell *cell ,int tag);
- (void)setCellWithModel:(GourmetViewModel *)model;


@end
