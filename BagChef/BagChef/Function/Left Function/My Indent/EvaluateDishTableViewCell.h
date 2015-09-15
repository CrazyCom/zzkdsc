//
//  EvaluateDishTableViewCell.h
//  BagChef
//
//  Created by zhangzhi on 15/9/12.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvaluateDishTableViewCell : UITableViewCell

@property (nonatomic , strong) UITextView *textView;
@property (nonatomic) float scoreNum;
@property (nonatomic , copy) void(^sendBlock)(EvaluateDishTableViewCell *cell);

- (void)setCellModel:(EvaluateDishTableViewCellModel *)model;

@end
