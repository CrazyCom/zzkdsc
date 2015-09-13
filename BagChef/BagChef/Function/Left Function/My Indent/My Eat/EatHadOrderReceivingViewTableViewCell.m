//
//  EatHadOrderReceivingViewTableViewCell.m
//  BagChef
//
//  Created by zhangzhi on 15/8/10.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "EatHadOrderReceivingViewTableViewCell.h"
@interface EatHadOrderReceivingViewTableViewCell() {
    
    
}


@property (nonatomic, strong) OrderInfo *orderInfo;
@end
@implementation EatHadOrderReceivingViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
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
//        
//        ZAdvertisementView *adView = [[ZAdvertisementView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(classifyNameOfLabel.frame) + 12, ScreenWidth - 20, 183)];
//        adView.backgroundColor = [UIColor grayColor];
//        [self addSubview:adView];
//        
//        
//        //头像
//        _headerImageView = [[UIImageView alloc]init];
//        [_headerImageView setFrame:CGRectMake(11, CGRectGetMaxY(adView.frame) + 11, 46 * ratioX, 46 * ratioY)];
//        [_headerImageView setBackgroundColor:[UIColor grayColor]];
//        _headerImageView.userInteractionEnabled = YES;
//        [self addSubview:_headerImageView];
//        
//        //订
//        //        _confirmBtn = [[UIButton alloc]init];
//        //        _confirmBtn.frame = CGRectMake(ScreenWidth - 50, CGRectGetMinY(_headerImageView.frame), 40 * ratioX, 40 *ratioX);
//        //        [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"ding"] forState:UIControlStateNormal];
//        //        [_confirmBtn setTitle:@"订" forState:UIControlStateNormal];
//        //        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        //        [_confirmBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
//        //        [self addSubview:_confirmBtn];
//        
//        
//        //姓名
//        _nameLabel = [[UILabel alloc]init];
//        [_nameLabel setFrame:CGRectMake(CGRectGetMaxX(_headerImageView.frame) + 8 , CGRectGetMinY(_headerImageView.frame), 90 * ratioX, 17 * ratioY)];
//        [_nameLabel setText:@"吃货的世界"];
//        [_nameLabel setTextColor:[UIColor blackColor]];
//        [_nameLabel setFont:[UIFont systemFontOfSize:14]];
//        [self addSubview:_nameLabel];
//        
//        
//        //身份证
//        _idCardImageView = [[UIImageView alloc]init];
//        [_idCardImageView setFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame), CGRectGetMinY(_headerImageView.frame), 30 * ratioX, 15 * ratioY)];
//        [_idCardImageView setBackgroundColor:[UIColor orangeColor]];
//        [self addSubview:_idCardImageView];
//        
//        //健康证
//        _healthCardImageView = [[UIImageView alloc]init];
//        [_healthCardImageView setFrame:CGRectMake(CGRectGetMaxX(_idCardImageView.frame) + 5, CGRectGetMinY(_headerImageView.frame), 30 * ratioX, 15 * ratioY)];
//        [_healthCardImageView setBackgroundColor:[UIColor orangeColor]];
//        [self addSubview:_healthCardImageView];
//        
//        //售出份数
//        _numOfSold = [[UILabel alloc]init];
//        _numOfSold.text = @"99999999";
//        
//        UILabel *numOfSold = [[UILabel alloc]init];
//        numOfSold.frame = CGRectMake(CGRectGetMaxX(_healthCardImageView.frame) + 10, CGRectGetMaxY(_healthCardImageView.frame) - 20, ScreenWidth - 10 - CGRectGetMaxX(_healthCardImageView.frame) - 10, 20);
//        numOfSold.text = [NSString stringWithFormat:@"已定%@份",_numOfSold.text];
//        numOfSold.textAlignment = NSTextAlignmentRight;
//        numOfSold.textColor = [UIColor colorWithRed:1.000f green:0.424f blue:0.310f alpha:1.00f];
//        numOfSold.font = [UIFont systemFontOfSize:14];
//        [self addSubview:numOfSold];
//        
//        //star
//        for (int i = 0; i < 5; i++) {
//            _starImageView = [[UIImageView alloc]init];
//            [_starImageView setFrame:CGRectMake(CGRectGetMaxX(_headerImageView.frame) + 8 +21 * i * ratioX, CGRectGetMaxY(_headerImageView.frame) - 18 * ratioY, 18 * ratioX, 18 * ratioY)];
//            [_starImageView setImage:[UIImage imageNamed:@"star"]];
//            [self addSubview:_starImageView];
//        }
//        
//        
//        
//        
//        //价格
//        UILabel *moneyAndPer = [[UILabel alloc]init];
//        moneyAndPer.frame = CGRectMake(ScreenWidth - 50 , CGRectGetMinY(_starImageView.frame), 40 , 16 );
//        moneyAndPer.text = @"元/份";
//        moneyAndPer.textAlignment = NSTextAlignmentRight;
//        moneyAndPer.font = [UIFont systemFontOfSize:14];
//        [self addSubview:moneyAndPer];
//        
//        _priceLabel = [[UILabel alloc]init];
//        _priceLabel.frame = CGRectMake(CGRectGetMaxX(_starImageView.frame) + 10, CGRectGetMinY(_starImageView.frame) - 1, ScreenWidth - CGRectGetMaxX(_starImageView.frame) - 60, 16);
//        _priceLabel.text = @"99999999";
//        _priceLabel.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
//        _priceLabel.textAlignment = NSTextAlignmentRight;
//        _priceLabel.font = [UIFont systemFontOfSize:14];
//        [self addSubview:_priceLabel];
//        
        _dishOfName = [[UILabel alloc]init];
        _dishOfName.frame = CGRectMake(12, 10, 80, 21);
        _dishOfName.text = @"电饭煲";
        _dishOfName.font = [UIFont systemFontOfSize:15];
        _dishOfName.textColor = [UIColor grayColor];
        [self.contentView addSubview:_dishOfName];
        
        _numOfLabel = [[UILabel alloc]init];
        _numOfLabel.frame = CGRectMake(CGRectGetMaxX(_dishOfName.frame), CGRectGetMinY(_dishOfName.frame), 60, 21);
        _numOfLabel.text = @"1000 份";
        _numOfLabel.textAlignment = NSTextAlignmentCenter;
        _numOfLabel.font = [UIFont systemFontOfSize:15];
        _numOfLabel.textColor = [UIColor grayColor];
        [self.contentView addSubview:_numOfLabel];
        
        _perAndPrice = [[UILabel alloc]init];
        _perAndPrice.frame = CGRectMake(ScreenWidth - 90, CGRectGetMinY(_dishOfName.frame), 80, 21);
        _perAndPrice.text = @"25元/份";
        _perAndPrice.textAlignment = NSTextAlignmentRight;
        _perAndPrice.font = [UIFont systemFontOfSize:15];
        _perAndPrice.textColor = [UIColor grayColor];
        [self.contentView addSubview:_perAndPrice];
    }
    
    return self;
}

- (void)updateCellWith:(OrderInfo *)orderInfo {
    
    if (!orderInfo) {
        // 数据异常
        return;
    }
    
    _orderInfo = orderInfo;
//    _nameOfMenu.text = orderInfo.name;
//    _priceOfMenu.text = [NSString stringWithFormat:@"%.2lf", orderInfo.price];
//    _numberOfPart.text = [NSString stringWithFormat:@"%i", orderInfo.num];
}


@end
