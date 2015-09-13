//
//  EatHavingDeliveryViewTableViewCell.m
//  BagChef
//
//  Created by zhangzhi on 15/8/10.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "EatHavingDeliveryViewTableViewCell.h"

@implementation EatHavingDeliveryViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//        //灰线
//        UILabel *grayLabel = [[UILabel alloc]init];
//        grayLabel.frame = CGRectMake(0, CGRectGetMaxY(_headerImageView.frame) + 12, ScreenWidth, 1);
//        grayLabel.backgroundColor = [UIColor colorWithRed:0.867f green:0.867f blue:0.867f alpha:1.00f];
//        [self addSubview:grayLabel];
//        

        _dishOfName = [[UILabel alloc]init];
        _dishOfName.frame = CGRectMake(12, 10, 80, 21);
        _dishOfName.text = @"电饭煲";
        _dishOfName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_dishOfName];
        
        _numOfLabel = [[UILabel alloc]init];
        _numOfLabel.frame = CGRectMake(CGRectGetMaxX(_dishOfName.frame), CGRectGetMinY(_dishOfName.frame), 60, 21);
        _numOfLabel.text = @"X1";
        _numOfLabel.textAlignment = NSTextAlignmentCenter;
        _numOfLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_numOfLabel];
        
        _perAndPrice = [[UILabel alloc]init];
        _perAndPrice.frame = CGRectMake(ScreenWidth - 90, CGRectGetMinY(_dishOfName.frame), 80, 21);
        _perAndPrice.text = @"25元/份";
        _perAndPrice.textAlignment = NSTextAlignmentRight;
        _perAndPrice.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_perAndPrice];

    }
    
    return self;
}


@end
