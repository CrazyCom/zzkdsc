//
//  OrderInfo.h
//  BagChef
//
//  Created by zhangzhi on 15/8/29.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "Model.h"

@interface OrderInfo : Model

@property (nonatomic, strong) NSString *name;       // 商品名称
@property (nonatomic, assign) CGFloat price;        // 价格
@property (nonatomic, assign) int num;              // 份数
@property (nonatomic, strong) NSString *ID;         // 产品ID


@end
