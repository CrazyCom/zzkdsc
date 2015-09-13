//
//  IsArmedEscortTableViewCell.m
//  BagChef
//
//  Created by zhangzhi on 15/8/31.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "IsArmedEscortTableViewCell.h"

@interface IsArmedEscortTableViewCell () {
    
    UILabel *routeLine;          //路线距离
    UILabel *priceOfLabel;       //价格
    UILabel *numOfLabel;         //送餐份数
    UILabel *timeOfLabel;
    UILabel *eatAddress;
    UILabel *doAddress;
}

@end

@implementation IsArmedEscortTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *lujingImageView = [[UIImageView alloc]init];
        lujingImageView.frame =  CGRectMake(10, 10, 20, 20);
        lujingImageView.image = [UIImage imageNamed:@"lujing"];
        [self.contentView addSubview:lujingImageView];
        
        //下划线
        UILabel *line = [[UILabel alloc]init];
        line.frame = CGRectMake(10, CGRectGetMaxY(lujingImageView.frame) +10, ScreenWidth - 20, 1);
        line.backgroundColor = [UIColor colorWithRed:0.867f green:0.867f blue:0.867f alpha:1.00f];
        [self.contentView addSubview:line];
        
        routeLine = [[UILabel alloc]init];
        routeLine.frame = CGRectMake(CGRectGetMaxX(lujingImageView.frame)+ 10, CGRectGetMinY(lujingImageView.frame), ScreenWidth - CGRectGetMaxX(lujingImageView.frame) - 10 - 60, 20);
        routeLine.text = [NSString stringWithFormat:@"路径3千米"];
        [self.contentView addSubview:routeLine];
        
        priceOfLabel = [[UILabel alloc]init];
        priceOfLabel.frame = CGRectMake(ScreenWidth - 120, CGRectGetMinY(lujingImageView.frame), 110, 20);
        priceOfLabel.textAlignment = NSTextAlignmentRight;
        priceOfLabel.text = @"100元";
        priceOfLabel.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
        [self.contentView addSubview:priceOfLabel];
        
        UILabel *numLabel = [[UILabel alloc]init];
        numLabel.frame = CGRectMake(CGRectGetMinX(lujingImageView.frame) , CGRectGetMaxY(line.frame) + 10, 80, 20);
        numLabel.text = @"送餐份数:";
        numLabel.font = [UIFont systemFontOfSize:15];
        numLabel.textColor = [UIColor grayColor];
        numLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:numLabel];
        
        //订
        UIButton *confirmBtn = [[UIButton alloc]init];
        confirmBtn.frame = CGRectMake(ScreenWidth - 40 - 10, CGRectGetMinY(numLabel.frame), 40, 40);
        confirmBtn.layer.cornerRadius = 5.0;
        
        [confirmBtn setBackgroundColor:[UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f]];
        [confirmBtn setTitle:@"接" forState:UIControlStateNormal];
        [confirmBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:confirmBtn];
        
        //份数
        numOfLabel = [[UILabel alloc]init];
        numOfLabel.frame = CGRectMake(CGRectGetMaxX(numLabel.frame), CGRectGetMinY(numLabel.frame), 100, 20);
        numOfLabel.font = [UIFont systemFontOfSize:15];
        numOfLabel.textColor = [UIColor grayColor];
        numOfLabel.text = @"4份";
        [self.contentView addSubview:numOfLabel];
        
        
        UILabel *timeLabel = [[UILabel alloc]init];
        timeLabel.frame = CGRectMake(CGRectGetMinX(numLabel.frame), CGRectGetMaxY(numLabel.frame) + 15, 80, 20);
        timeLabel.text = @"送餐时间:";
        timeLabel.font = [UIFont systemFontOfSize:15];
        timeLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:timeLabel];
        
        //时间
        timeOfLabel = [[UILabel alloc]init];
        timeOfLabel.frame = CGRectMake(CGRectGetMaxX(timeLabel.frame), CGRectGetMinY(timeLabel.frame), 100, 20);
        timeOfLabel.font = [UIFont systemFontOfSize:15];
        timeOfLabel.textColor = [UIColor grayColor];
        timeOfLabel.text = @"12:00";
        [self.contentView addSubview:timeOfLabel];
        
        //取餐地址
        UILabel *getAddressLabel = [[UILabel alloc]init];
        getAddressLabel.frame = CGRectMake(CGRectGetMinX(timeLabel.frame), CGRectGetMaxY(timeLabel.frame) + 20, 80, 20);
        getAddressLabel.text = @"取餐地址";
        getAddressLabel.textColor = [UIColor grayColor];
        getAddressLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:getAddressLabel];
        
        eatAddress = [[UILabel alloc]init];
        eatAddress.frame = CGRectMake(CGRectGetMaxX(getAddressLabel.frame), CGRectGetMinY(getAddressLabel.frame), ScreenWidth - 10 - CGRectGetMaxX(getAddressLabel.frame), 20);
        eatAddress.text = @"成都市 武侯区 创业路";
        eatAddress.textColor = [UIColor grayColor];
        eatAddress.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:eatAddress];
        
        //送餐地址
        UILabel *sendAddressLabel = [[UILabel alloc]init];
        sendAddressLabel.frame = CGRectMake(CGRectGetMinX(getAddressLabel.frame), CGRectGetMaxY(getAddressLabel.frame) + 12, 80, 20);
        sendAddressLabel.text = @"送餐地址";
        sendAddressLabel.textColor = [UIColor grayColor];
        sendAddressLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:sendAddressLabel];
        
        doAddress = [[UILabel alloc]init];
        doAddress.frame = CGRectMake(CGRectGetMaxX(sendAddressLabel.frame) , CGRectGetMinY(sendAddressLabel.frame), ScreenWidth - 10 - CGRectGetMaxX(sendAddressLabel.frame), 20);
        doAddress.text = @"成都市 武侯区 创业路1号";
        doAddress.textColor = [UIColor grayColor];
        doAddress.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:doAddress];
        
    }
    
    return self;
}

- (void)setCellModel:(ArmedEscortModel *)model {
    
    routeLine.text = [NSString stringWithFormat:@"路径%@千米",model.length];
    priceOfLabel.text = [NSString stringWithFormat:@"%@元",model.express_price];
    numOfLabel.text = [NSString stringWithFormat:@"%@份",model.dish_total];
    
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    fomatter.dateFormat = @"HH:mm";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[model.order_time doubleValue]];
    [timeOfLabel setText:[NSString stringWithFormat:@"%@",[fomatter stringFromDate:date]]];

    eatAddress.text = model.end_address;
    doAddress.text = model.start_address;
}

- (void)buttonPressed:(UIButton *)sender {
    
    if (self.ButtonClick) {
        self.ButtonClick(self);
    }
}

@end
