//
//  SendWaitForDeliveryViewTableViewCell.h
//  BagChef
//
//  Created by zhangzhi on 15/8/10.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendWaitForDeliveryViewTableViewCell : UITableViewCell

@property (nonatomic , strong) UILabel *distanceLabel; //距离
@property (nonatomic , strong) UILabel *timeLabel; //时间
@property (nonatomic , strong) UILabel *timeOrderLabel; //时间
@property (nonatomic , strong) UILabel *timeOfSend; //送餐时间
@property (nonatomic , strong) UILabel *addressOfTake; //取餐地址
@property (nonatomic , strong) UILabel *addressOfSend; //送餐地址
@property (nonatomic , strong) UILabel *numberOfSold; // 份数
@property (nonatomic , strong) UILabel *priceOfAll; //总价

@property (nonatomic , copy) void(^buttonClick)(SendWaitForDeliveryViewTableViewCell *cell);

- (void)setCellModel:(SendBeSendingViewModel *)model;
@end
