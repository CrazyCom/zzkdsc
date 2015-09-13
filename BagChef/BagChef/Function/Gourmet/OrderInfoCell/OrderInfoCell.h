//
//  OrderInfoCell.h
//  BagChef
//
//  Created by zhangzhi on 15/8/30.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderInfoCell;

@protocol OrderInfoCellDelegate <NSObject>

@optional

- (void)numChangeWith:(OrderInfoCell *)cell Num:(int)num;

@end

@interface OrderInfoCell : UITableViewCell

@property (nonatomic, strong) UIView *nameCell;
@property (nonatomic, strong) UIView *priceCell;
@property (nonatomic, strong) UIView *numCell;

@property (nonatomic, strong) UILabel *nameOfMenu;
@property (nonatomic, strong) UILabel *priceOfMenu;
@property (nonatomic, strong) UITextField *numberOfPart;

@property (nonatomic, assign) id<OrderInfoCellDelegate> delegate;

- (void)updateCellWith:(OrderInfo *)orderInfo;

@end
