//
//  IsArmedEscortTableViewCell.h
//  BagChef
//
//  Created by zhangzhi on 15/8/31.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IsArmedEscortTableViewCell : UITableViewCell

@property (nonatomic , copy) void(^ButtonClick)(IsArmedEscortTableViewCell *cell);
- (void)setCellModel:(ArmedEscortModel *)model;


@end
