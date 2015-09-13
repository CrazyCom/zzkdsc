//
//  OrderDetailTableViewCell.h
//  BagChef
//
//  Created by zhangzhi on 15/9/1.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailTableViewCell : UITableViewCell

@property (nonatomic , strong) UILabel *perAndPrice; //每份价格
@property (nonatomic , strong) UILabel *dishOfName; //菜品名称
@property (nonatomic , strong) UILabel *numOfLabel; //售出份数

- (void)setCellModel:(NSMutableDictionary *)dictionary;

@end
