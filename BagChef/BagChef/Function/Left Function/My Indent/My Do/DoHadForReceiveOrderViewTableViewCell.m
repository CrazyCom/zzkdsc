//
//  DoHadForReceiveOrderViewTableViewCell.m
//  BagChef
//
//  Created by zhangzhi on 15/8/10.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "DoHadForReceiveOrderViewTableViewCell.h"
@interface DoHadForReceiveOrderViewTableViewCell() {
    
//    UILabel *dishNameOfLabel;
    
//    UILabel *numOfLabel;
//    UILabel *perAndPrice;
    UILabel *addressOfLabel;
    UILabel *armedPriceOfLabel;
    UILabel *totalOfPrice;
}

@end

@implementation DoHadForReceiveOrderViewTableViewCell

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
        _dishOfName.frame = CGRectMake(10, 12, 120, 21);
        _dishOfName.font = [UIFont systemFontOfSize:15];
        _dishOfName.text = @"电饭煲";
        [self.contentView addSubview:_dishOfName];
        
        _numOfLabel = [[UILabel alloc]init];
        _numOfLabel.frame = CGRectMake(CGRectGetMaxX(_dishOfName.frame) + 20, CGRectGetMinY(_dishOfName.frame), 50, 21);
        _numOfLabel.textColor = [UIColor grayColor];
        _numOfLabel.text = @"100份";
        _numOfLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_numOfLabel];
        
        
        _perAndPrice = [[UILabel alloc]init];
        _perAndPrice.frame = CGRectMake(ScreenWidth - 100, CGRectGetMinY(_dishOfName.frame), 90, 21);
        _perAndPrice.textColor = [UIColor grayColor];
        _perAndPrice.textAlignment = NSTextAlignmentRight;
        _perAndPrice.font = [UIFont systemFontOfSize:15];
        _perAndPrice.text = @"1000元/份";
        [self.contentView addSubview:_perAndPrice];
        
        
        UILabel *line = [[UILabel alloc]init];
        line.frame = CGRectMake(10, CGRectGetMaxY(_dishOfName.frame) + 12, ScreenWidth - 20, 0.5);
        line.backgroundColor = [UIColor colorWithRed:0.867f green:0.867f blue:0.867f alpha:1.00f];
        [self.contentView addSubview:line];
        
        
        
        
//        //分类名字
//        UILabel *classifyNameOfLabel = [[UILabel alloc]init];
//        [classifyNameOfLabel setFrame:CGRectMake(10, 12, 100 , 18)];
//        [classifyNameOfLabel setText:@"创新小炒"];
//        [self addSubview:classifyNameOfLabel];
//        
//        
//        //时间
//        
//        _timeOfLabel = [[UILabel alloc]init];
//        [_timeOfLabel setFrame:CGRectMake(CGRectGetMaxX(classifyNameOfLabel.frame) + 10 , CGRectGetMinX(classifyNameOfLabel.frame), ScreenWidth - CGRectGetMaxX(classifyNameOfLabel.frame) - 20, 14)];
//        
//        [_timeOfLabel setTextAlignment:NSTextAlignmentRight];
//        [_timeOfLabel setText:@"2015-01-23 14:25"];
//        [_timeOfLabel setTextColor:[UIColor grayColor]];
//        [_timeOfLabel setFont:[UIFont systemFontOfSize:13]];
//        [self addSubview:_timeOfLabel];
//        
//        //购买份数
//        UILabel *numberOfBuy = [[UILabel alloc]init];
//        numberOfBuy.frame = CGRectMake(CGRectGetMinX(classifyNameOfLabel.frame), CGRectGetMaxY(classifyNameOfLabel.frame) + 22, 100, 18);
//        numberOfBuy.text = @"购买份数";
//        numberOfBuy.font = [UIFont systemFontOfSize:14];
//        numberOfBuy.textAlignment = NSTextAlignmentLeft;
//        [self addSubview:numberOfBuy];
//        
//        
//        UILabel *buylabel = [[UILabel alloc]init];
//        buylabel.frame = CGRectMake(ScreenWidth - 10 - 15, CGRectGetMaxY(numberOfBuy.frame) - 18, 15, 18);
//        buylabel.text = @"份";
//        buylabel.font = [UIFont systemFontOfSize:14];
//        buylabel.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
//        [self addSubview:buylabel];
//        
//        
//        _numberOfBuy = [[UILabel alloc]init];
//        _numberOfBuy.frame = CGRectMake(CGRectGetMaxX(classifyNameOfLabel.frame) + 10 ,  CGRectGetMaxY(numberOfBuy.frame) - 18 , ScreenWidth - CGRectGetMaxX(numberOfBuy.frame)  - 48, 18);
//        _numberOfBuy.textAlignment = NSTextAlignmentRight;
//        _numberOfBuy.text = @"11";
//        _numberOfBuy.textColor =  [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
//        [_numberOfBuy setFont:[UIFont systemFontOfSize:14]];
//        [self addSubview:_numberOfBuy];
//        
//        //合计
//        UILabel *allLabel = [[UILabel alloc]init];
//        allLabel.frame = CGRectMake(CGRectGetMinX(classifyNameOfLabel.frame), CGRectGetMaxY(buylabel.frame) + 20, 100, 18);
//        allLabel.text = @"合     计";
//        [self addSubview:allLabel];
//        
//        UILabel *pricelabel = [[UILabel alloc]init];
//        pricelabel.frame = CGRectMake(ScreenWidth - 10 - 15, CGRectGetMaxY(allLabel.frame) - 18, 15, 18);
//        pricelabel.text = @"元";
//        pricelabel.font = [UIFont systemFontOfSize:14];
//        pricelabel.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
//        [self addSubview:pricelabel];
//        
//        
//        _priceLabel = [[UILabel alloc]init];
//        _priceLabel.frame = CGRectMake(CGRectGetMaxX(allLabel.frame) + 10 ,  CGRectGetMaxY(allLabel.frame) - 18 , ScreenWidth - CGRectGetMaxX(allLabel.frame)  - 48, 18);
//        _priceLabel.textAlignment = NSTextAlignmentRight;
//        _priceLabel.text = @"25";
//        _priceLabel.textColor =  [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
//        [_priceLabel setFont:[UIFont systemFontOfSize:14]];
//        [self addSubview:_priceLabel];
//        
//        
//        //地址
//        UIImageView *positionImageView = [[UIImageView alloc]init];
//        [positionImageView setFrame:CGRectMake(CGRectGetMinX(classifyNameOfLabel.frame), CGRectGetMaxY(allLabel.frame) + 20, 16 , 16)];
//        [positionImageView setImage:[UIImage imageNamed:@"tb4"]];
//        [self addSubview:positionImageView];
//        
//        _positionLabel = [[UILabel alloc]init];
//        [_positionLabel setFrame:CGRectMake(CGRectGetMaxX(positionImageView.frame) + 8, CGRectGetMaxY(positionImageView.frame) - 11, (ScreenWidth - CGRectGetMaxX(positionImageView.frame) - 8 - 10), 10 )];
//        [_positionLabel setText:@"成都市高新区创业路火炬大厦B座三楼"];
//        [_positionLabel setFont:[UIFont systemFontOfSize:13]];
//        [_positionLabel setTextColor:[UIColor colorWithRed:0.482f green:0.478f blue:0.482f alpha:1.00f]];
//        [self addSubview:_positionLabel];
//        
//        //时间
//        UIImageView *timeImageView = [[UIImageView alloc]init];
//        [timeImageView setFrame:CGRectMake(CGRectGetMinX(positionImageView.frame), CGRectGetMaxY(positionImageView.frame) + 12, 16 , 16 )];
//        [timeImageView setImage:[UIImage imageNamed:@"tb5"]];
//        [self addSubview:timeImageView];
//        
//        
//        //
//        _fTimeLabel = [[UILabel alloc]init];
//        [_fTimeLabel setText:@"11:30"];
//        //
//        _tTimeLabel = [[UILabel alloc]init];
//        [_tTimeLabel setText:@"12:30"];
//        
//        UILabel *timeLabel = [[UILabel alloc]init];
//        [timeLabel setFrame:CGRectMake(CGRectGetMaxX(timeImageView.frame) + 8, CGRectGetMaxY(timeImageView.frame) - 10 , (ScreenWidth - CGRectGetMaxX(timeImageView.frame) - 8 - 10), 10 )];
//        [timeLabel setText:[NSString stringWithFormat:@"今日%@~%@可取",_fTimeLabel.text,_tTimeLabel.text]];
//        [timeLabel setFont:[UIFont systemFontOfSize:13]];
//        [timeLabel setTextColor:[UIColor colorWithRed:0.482f green:0.478f blue:0.482f alpha:1.00f]];
//        [self addSubview:timeLabel];
//        
//        
//        //灰线
//        UILabel *grayLabel = [[UILabel alloc]init];
//        grayLabel.frame = CGRectMake(0, CGRectGetMaxY(timeImageView.frame) + 12, ScreenWidth, 1);
//        grayLabel.backgroundColor = [UIColor colorWithRed:0.867f green:0.867f blue:0.867f alpha:1.00f];
//        [self addSubview:grayLabel];
//        
//        UIButton *sendBtn = [[UIButton alloc]init];
//        sendBtn.frame = CGRectMake(50, CGRectGetMaxY(grayLabel.frame) + 14, ScreenWidth - 100, 39);
//        [sendBtn setTitle:@"餐已送出" forState:UIControlStateNormal];
//        [sendBtn setTintColor:[UIColor whiteColor]];
//        [sendBtn setBackgroundImage:[UIImage imageNamed:@"button-dingdan-1"] forState:UIControlStateNormal];
//        [self addSubview:sendBtn];
        
    }
    return self;
}

@end
