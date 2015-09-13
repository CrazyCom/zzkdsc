//
//  HadUploadMenuTableViewCell.h
//  BagChef
//
//  Created by zhangzhi on 15/8/24.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HadUploadMenuTableViewCell : UITableViewCell {
    
    UILabel *timeLabel;
}

@property (nonatomic , strong) UIView *myContentView;
@property (nonatomic , strong) UIButton *selectButton;
@property (nonatomic , strong) UIImageView *adImageView; //头像
@property (nonatomic , strong) UILabel *classifyNameOfLabel;
@property (nonatomic , strong) UIImageView *headerImageView; //头像
@property (nonatomic , strong) UILabel *nameLabel; // 姓名
@property (nonatomic , strong) UIImageView *idCardImageView; //身份证
@property (nonatomic , strong) UIImageView *healthCardImageView; //健康证
@property (nonatomic , strong) UIImageView *starImageView; //五星
@property (nonatomic , strong) UILabel *positionLabel; //位置
@property (nonatomic , strong) UIButton *confirmBtn; //订
@property (nonatomic , strong) UILabel *priceLabel; //价格
@property (nonatomic , strong) UILabel *fTimeLabel; //起始时间
@property (nonatomic , strong) UILabel *tTimeLabel; //结束时间
@property (nonatomic , strong) UITextView *textView; //菜品介绍
@property (nonatomic , strong) UILabel *timeOfLabel; //时间
@property (nonatomic , strong) UILabel *numberOfBuy; //购买份数
@property (nonatomic , strong) UILabel *numOfSold; // 售出份数
@property (nonatomic , strong) UILabel *soldLabel;
@property (nonatomic , copy)    void (^buttonClick)(HadUploadMenuTableViewCell *cell, BOOL addOrDelete,int tag) ;
//@property (nonatomic , assign) SEL buttonClick;


- (void)setCellWithModel:(HadUploadMenuModel *)model;
@end
