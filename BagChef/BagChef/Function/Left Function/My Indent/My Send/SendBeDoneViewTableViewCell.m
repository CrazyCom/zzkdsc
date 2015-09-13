//
//  SendBeDoneViewTableViewCell.m
//  BagChef
//
//  Created by zhangzhi on 15/8/11.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "SendBeDoneViewTableViewCell.h"

@implementation SendBeDoneViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *headerImageView = [[UIImageView alloc]init];
        headerImageView.frame = CGRectMake(11, 11, 20, 20);
        [headerImageView setImage:[UIImage imageNamed:@"lujing"]];
        [self addSubview:headerImageView];
        
        //距离
        //        _distanceOfLabel = [[UILabel alloc]init];
        //        _distanceOfLabel.text = @"10000";
        
        _distanceLabel = [[UILabel alloc]init];
        _distanceLabel.frame = CGRectMake(CGRectGetMaxX(headerImageView.frame) + 12, CGRectGetMinY(headerImageView.frame), 140, 20);
        _distanceLabel.font = [UIFont systemFontOfSize:15];
        _distanceLabel.textAlignment = NSTextAlignmentLeft;
        //        _distanceLabel.text = [NSString stringWithFormat:@"路径%@千米"];
        [self.contentView addSubview:_distanceLabel];
        
        //时间
        _timeOrderLabel = [[UILabel alloc]init];
        _timeOrderLabel.frame = CGRectMake(CGRectGetMaxX(_distanceLabel.frame) + 10, CGRectGetMaxY(_distanceLabel.frame) - 20, ScreenWidth - CGRectGetMaxX(_distanceLabel.frame) - 10 - 10  , 20);
        
        //        _timeOrderLabel.text = @"2015-07-20 11:00";
        _timeOrderLabel.textAlignment = NSTextAlignmentRight;
        _timeOrderLabel.textColor = [UIColor grayColor];
        _timeOrderLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_timeOrderLabel];
        //送餐时间
        UILabel *sendTimeLabel = [[UILabel alloc]init];
        sendTimeLabel.text = @"送餐时间:";
        sendTimeLabel.frame = CGRectMake(CGRectGetMinX(headerImageView.frame), CGRectGetMaxY(headerImageView.frame) + 12, 80, 20);
        sendTimeLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:sendTimeLabel];
        
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.frame = CGRectMake(CGRectGetMaxX(sendTimeLabel.frame) + 10, CGRectGetMaxY(sendTimeLabel.frame) - 20, self.frame.size.width - CGRectGetMaxX(sendTimeLabel.frame) - 10 - 10, 20);
        _timeLabel.text = @"今天 12:00";
        _timeLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_timeLabel];
        //取餐地址
        UILabel *addressOfTake = [[UILabel alloc]init];
        addressOfTake.frame = CGRectMake(CGRectGetMinX(headerImageView.frame), CGRectGetMaxY(sendTimeLabel.frame) + 20, 80, 20);
        addressOfTake.font = [UIFont systemFontOfSize:14];
        addressOfTake.textAlignment = NSTextAlignmentLeft;
        addressOfTake.text = @"取餐地址:";
        [self addSubview:addressOfTake];
        
        _addressOfTake = [[UILabel alloc]init];
        _addressOfTake.frame = CGRectMake(CGRectGetMaxX(addressOfTake.frame), CGRectGetMaxY(sendTimeLabel.frame) + 8, ScreenWidth - CGRectGetMaxX(addressOfTake.frame) - 10 , 20);
        _addressOfTake.textAlignment = NSTextAlignmentLeft;
        _addressOfTake.numberOfLines = 2;
        _addressOfTake.text = @"成都市 武侯区 创业路火炬大厦B座3楼";
        _addressOfTake.font = [UIFont systemFontOfSize:14];
        [self addSubview:_addressOfTake];
        
        //送餐地址
        UILabel *addressOfSend = [[UILabel alloc]init];
        addressOfSend.frame = CGRectMake(CGRectGetMinX(addressOfTake.frame), CGRectGetMaxY(addressOfTake.frame) + 20, 80, 20);
        addressOfSend.font = [UIFont systemFontOfSize:14];
        addressOfSend.textAlignment = NSTextAlignmentLeft;
        addressOfSend.text = @"送餐地址:";
        [self addSubview:addressOfSend];
        
        _addressOfSend = [[UILabel alloc]init];
        _addressOfSend.frame = CGRectMake(CGRectGetMaxX(addressOfSend.frame), CGRectGetMaxY(addressOfTake.frame) + 8, ScreenWidth - CGRectGetMaxX(addressOfSend.frame) - 10 , 44);
        _addressOfSend.textAlignment = NSTextAlignmentLeft;
        _addressOfTake.numberOfLines = 2;
        _addressOfSend.text = @"成都市 武侯区 创业路火炬大厦B座3楼";
        _addressOfSend.font = [UIFont systemFontOfSize:14];
        [self addSubview:_addressOfSend];
        
        //总价
        //        _priceOfAll = [[UILabel alloc]init];
        //        _priceOfAll.text = @"10000";
        
        _priceOfAll = [[UILabel alloc]init];
        _priceOfAll.frame = CGRectMake(ScreenWidth - 180, CGRectGetMaxY(_addressOfSend.frame) + 15, 170, 20);
        _priceOfAll.text = [NSString stringWithFormat:@"合计%@元",_priceOfAll.text];
        _priceOfAll.textColor = [UIColor colorWithRed:1.000f green:0.357f blue:0.110f alpha:1.00f];
        _priceOfAll.textAlignment = NSTextAlignmentRight;
        [self addSubview:_priceOfAll];
        
        //份数
        //        _numberOfSold = [[UILabel alloc]init];
        //        _numberOfSold.text = @"10000";
        
        _numberOfSold = [[UILabel alloc]init];
        _numberOfSold.frame = CGRectMake(CGRectGetMinX(_priceOfAll.frame) - 160 - 10, CGRectGetMaxY(_addressOfSend.frame) + 15, 160, 20);
        //        numOfLabel.text = [NSString stringWithFormat:@"共%@份",_numberOfSold.text];
        _numberOfSold.textColor = [UIColor colorWithRed:1.000f green:0.357f blue:0.110f alpha:1.00f];
        _numberOfSold.textAlignment = NSTextAlignmentRight;
        [self addSubview:_numberOfSold];
        
//        UILabel *grayLabel = [[UILabel alloc]init];
//        grayLabel.backgroundColor = [UIColor colorWithRed:0.867f green:0.867f blue:0.867f alpha:1.00f];
//        grayLabel.frame = CGRectMake(0, CGRectGetMaxY(_numberOfSold.frame) + 10, ScreenWidth, 1);
//        [self addSubview:grayLabel];
        
//        UIButton *btn = [[UIButton alloc]init];
//        btn.frame = CGRectMake(40, CGRectGetMaxY(grayLabel.frame) + 12, ScreenWidth - 80, 39);
//        [btn setTitle:@"镖已送到啦" forState:UIControlStateNormal];
//        [btn setTintColor:[UIColor whiteColor]];
//        [btn setBackgroundImage:[UIImage imageNamed:@"button-dingdan-1"] forState:UIControlStateNormal];
//        [self addSubview:btn];
    }
    
    return self;
}

- (void)setCellModel:(SendBeSendingViewModel *)model {
    
    _distanceLabel.text = [NSString stringWithFormat:@"路径%@千米",model.length];
    
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    fomatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.place_time doubleValue]];
    [_timeLabel setText:[NSString stringWithFormat:@"今天%@",[fomatter stringFromDate:date]]];
    
    date = [NSDate dateWithTimeIntervalSince1970:[model.order_time doubleValue]];
    [_timeOrderLabel setText:[NSString stringWithFormat:@"%@",[fomatter stringFromDate:date]]];
    
    _addressOfTake.text = model.address;
    _addressOfSend.text = model.b_address;
    
    _priceOfAll.text = [NSString stringWithFormat:@"合计%@元",model.total_price];
    _numberOfSold.text = [NSString stringWithFormat:@"合计%lu份",(unsigned long)[model.dish_list count]];
}





@end
