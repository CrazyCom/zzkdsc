//
//  PrivateReceivedOrderDetailTableViewCell.m
//  BagChef
//
//  Created by zhangzhi on 15/9/4.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "PrivateReceivedOrderDetailTableViewCell.h"

@interface PrivateReceivedOrderDetailTableViewCell() {
    
    UILabel *dishNameOfLabel;       //菜品名称
    UILabel *numOfLabel;            //份数
    UILabel *perAndPrice;     //
}

@end


@implementation PrivateReceivedOrderDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        _dishOfName = [[UILabel alloc]init];
        _dishOfName.frame = CGRectMake(10, 10, 80, 20);
        _dishOfName.text = @"电饭煲";
        _dishOfName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_dishOfName];
        
        
        _numOfLabel = [[UILabel alloc]init];
        _numOfLabel.frame = CGRectMake(CGRectGetMaxX(_dishOfName.frame) + 20, CGRectGetMinY(_dishOfName.frame), 50, 21);
        _numOfLabel.text = @"X1";
        _numOfLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_numOfLabel];
        
        _perAndPrice = [[UILabel alloc]init];
        _perAndPrice.frame = CGRectMake(ScreenWidth - 150, CGRectGetMinY(_dishOfName.frame), 140, 21);
        _perAndPrice.font = [UIFont systemFontOfSize:15];
        _perAndPrice.textAlignment = NSTextAlignmentRight;
        _perAndPrice.text = @"1000元/份";
        [self.contentView addSubview:_perAndPrice];
        
    }
    return self;
}


@end
