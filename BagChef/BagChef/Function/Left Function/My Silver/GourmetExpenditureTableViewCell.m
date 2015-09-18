//
//  GourmetExpenditureTableViewCell.m
//  BagChef
//
//  Created by zhangzhi on 15/9/15.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "GourmetExpenditureTableViewCell.h"
@interface GourmetExpenditureTableViewCell() {
    
//    UILabel *dishOfName;
//    UILabel *timeOfPay;
//    UILabel *routeOfPay;
//    UILabel *priceOfLabel;
//
}

//@synthesize _dishOfName = dishName;
//@synthesize _timeOfPay = timeOfPay;
//@synthesize _routeOfPay = routeOfPay;
//@synthesize _priceOfLabel = priceOfLabel;

@end
@implementation GourmetExpenditureTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _dishOfName = [[UILabel alloc]init];
        _dishOfName.frame = CGRectMake(10, 10, 150, 20);
        _dishOfName.text = @"创新小炒";
        _dishOfName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_dishOfName];
        
        _timeOfPay = [[UILabel alloc]init];
        _timeOfPay.frame = CGRectMake(CGRectGetMaxX(_dishOfName.frame) + 10, 10, ScreenWidth - CGRectGetMaxX(_dishOfName.frame) - 10 - 10, 20);
        _timeOfPay.text = @"2015-1-1";
        _timeOfPay.textAlignment = NSTextAlignmentRight;
        _timeOfPay.textColor = [UIColor grayColor];
        _timeOfPay.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_timeOfPay];

        
        
       
    }
    
    return self;
}

@end
