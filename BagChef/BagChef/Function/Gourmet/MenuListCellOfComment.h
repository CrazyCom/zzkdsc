//
//  MenuListCellOfComment.h
//  BagChef
//
//  Created by zhangzhi on 15/8/5.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuListCellOfComment : UITableViewCell


@property (nonatomic , strong) UIImageView *headerImageView; //头像
@property (nonatomic , strong) UILabel *nameOfLabel; //名字
@property (nonatomic , strong) UILabel *timeOfLabel; //时间
@property (nonatomic , strong) UILabel *contentOfLabel; //内容

- (void)setCellModel:(MenuListCellOfModel *)model;
@end
