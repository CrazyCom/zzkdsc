//
//  EatHadOverBookTableViewCell.m
//  BagChef
//
//  Created by zhangzhi on 15/8/10.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "EatHadOverBookTableViewCell.h"
@interface EatHadOverBookTableViewCell() {
    
    
    UILabel *dishNameOfLabel;
    UILabel *telOfLabel;
    UILabel *numOfLabel;
    UILabel *perAndPrice;
    UILabel *addressOfLabel;
    UILabel *armedPriceOfLabel;
    UILabel *totalOfPrice;
    
}

@end

@implementation EatHadOverBookTableViewCell

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
//        
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
        
        //
//        dishNameOfLabel = [[UILabel alloc]init];
//        dishNameOfLabel.frame = CGRectMake(10, 12, 120, 21);
//        dishNameOfLabel.font = [UIFont systemFontOfSize:15];
//        dishNameOfLabel.text = @"电饭煲";
//        [self.contentView addSubview:dishNameOfLabel];
//        
//        numOfLabel = [[UILabel alloc]init];
//        numOfLabel.frame = CGRectMake(CGRectGetMaxX(dishNameOfLabel.frame) + 20, CGRectGetMinY(dishNameOfLabel.frame), 50, 21);
//        numOfLabel.textColor = [UIColor grayColor];
//        numOfLabel.text = @"100份";
//        numOfLabel.font = [UIFont systemFontOfSize:15];
//        [self.contentView addSubview:numOfLabel];
//        
//        
//        perAndPrice = [[UILabel alloc]init];
//        perAndPrice.frame = CGRectMake(ScreenWidth - 80, CGRectGetMinY(dishNameOfLabel.frame), 70, 21);
//        perAndPrice.textColor = [UIColor grayColor];
//        perAndPrice.font = [UIFont systemFontOfSize:15];
//        perAndPrice.text = @"1000元/份";
//        [self.contentView addSubview:perAndPrice];
//        
//        UILabel *line1 = [[UILabel alloc]init];
//        line1.frame = CGRectMake(10, CGRectGetMaxY(dishNameOfLabel.frame) + 12, ScreenWidth - 20, 0.5);
//        line1.backgroundColor = [UIColor colorWithRed:0.784f green:0.780f blue:0.800f alpha:1.00f];
//        [self.contentView addSubview:line1];
//        
//        
//        //电话
//        UILabel *telLabel = [[UILabel alloc]init];
//        telLabel.frame = CGRectMake(CGRectGetMinX(line1.frame), CGRectGetMaxY(line1.frame) + 12, 80, 21);
//        telLabel.font = [UIFont systemFontOfSize:15];
//        telLabel.text = @"电      话";
//        [self.contentView addSubview:telLabel];
//
//        telOfLabel = [[UILabel alloc]init];
//        telOfLabel.frame = CGRectMake(CGRectGetMaxX(telLabel.frame), CGRectGetMinY(telLabel.frame), ScreenWidth - 10 - CGRectGetMaxX(telLabel.frame), 21);
//        telOfLabel.font = [UIFont systemFontOfSize:15];
//        telOfLabel.text = @"";
//        [self.contentView addSubview:telOfLabel];
//
//        
//        UILabel *line2 = [[UILabel alloc]init];
//        line2.frame = CGRectMake(CGRectGetMinX(line1.frame), CGRectGetMaxY(telLabel.frame) + 12, ScreenWidth - 20, 0.5);
//        line2.backgroundColor = [UIColor colorWithRed:0.784f green:0.780f blue:0.800f alpha:1.00f];
//        [self.contentView addSubview:line2];
//
//        //送餐地址
//        UILabel *addressLabel = [[UILabel alloc]init];
//        addressLabel.frame = CGRectMake(CGRectGetMinX(line1.frame), CGRectGetMaxY(line2.frame) + 12, 80, 21);
//        addressLabel.font = [UIFont systemFontOfSize:15];
//        addressLabel.text = @"送餐地址";
//        [self.contentView addSubview:addressLabel];
//        
//        addressOfLabel = [[UILabel alloc]init];
//        addressOfLabel.frame = CGRectMake(CGRectGetMaxX(addressLabel.frame), CGRectGetMinY(addressLabel.frame) - 8, ScreenWidth - 10 - CGRectGetMaxX(addressLabel.frame), 42);
//        addressOfLabel.font = [UIFont systemFontOfSize:15];
//        addressOfLabel.text = @"";
//        addressOfLabel.numberOfLines = 2;
//        [self.contentView addSubview:addressOfLabel];
//        
//        UILabel *line3 = [[UILabel alloc]init];
//        line3.frame = CGRectMake(CGRectGetMinX(line2.frame), CGRectGetMaxY(addressLabel.frame) + 12, ScreenWidth - 20, 0.5);
//        line3.backgroundColor = [UIColor colorWithRed:0.784f green:0.780f blue:0.800f alpha:1.00f];
//        [self.contentView addSubview:line3];
//
//        //配送费
//        UILabel *armedLabel = [[UILabel alloc]init];
//        armedLabel.frame = CGRectMake(CGRectGetMinX(line3.frame), CGRectGetMaxY(line3.frame) + 12, 80, 21);
//        armedLabel.font = [UIFont systemFontOfSize:15];
//        armedLabel.text = @"配  送  费";
//        [self.contentView addSubview:armedLabel];
//        
//        armedPriceOfLabel = [[UILabel alloc]init];
//        armedPriceOfLabel.frame = CGRectMake(CGRectGetMaxX(armedLabel.frame) + 10, CGRectGetMinY(armedLabel.frame), ScreenWidth - 10 - CGRectGetMaxX(armedLabel.frame) - 10, 21);
//        armedPriceOfLabel.font = [UIFont systemFontOfSize:15];
//        armedPriceOfLabel.text = @"34.03元";
//        armedPriceOfLabel.textAlignment = NSTextAlignmentRight;
//        [self.contentView addSubview:armedPriceOfLabel];
//        
//        UILabel *line4 = [[UILabel alloc]init];
//        line4.frame = CGRectMake(CGRectGetMinX(line3.frame), CGRectGetMaxY(armedLabel.frame) + 12, ScreenWidth - 20, 0.5);
//        line4.backgroundColor = [UIColor colorWithRed:0.784f green:0.780f blue:0.800f alpha:1.00f];
//        [self.contentView addSubview:line4];
//        
//        //合计
//        UILabel *totalLabel = [[UILabel alloc]init];
//        totalLabel.frame = CGRectMake(CGRectGetMinX(line4.frame), CGRectGetMaxY(line4.frame) + 12 , 80 , 21);
//        totalLabel.font = [UIFont systemFontOfSize:15];
//        totalLabel.text = @"总     计";
//        [self.contentView addSubview:totalLabel];
//        
//        totalOfPrice = [[UILabel alloc]init];
//        totalOfPrice.frame = CGRectMake(CGRectGetMaxX(totalLabel.frame) + 10, CGRectGetMinY(totalLabel.frame), ScreenWidth - CGRectGetMaxX(totalLabel.frame) - 10 - 10, 21);
//        totalOfPrice.font = [UIFont systemFontOfSize:15];
//        totalOfPrice.text = @"￥59.03元";
//        totalOfPrice.textAlignment = NSTextAlignmentRight;
//        totalOfPrice.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
//        [self.contentView addSubview:totalOfPrice];
//
    }
    
    return self;
}

- (void)setCellModel:(NSMutableDictionary *)dictionary {
    
    NSLog(@"%@",dictionary);
    
    dishNameOfLabel.text = dictionary[@"dish_list"][0][@"dish_name"];
    numOfLabel.text = [NSString stringWithFormat:@"%li份",[dictionary[@"dish_total"] integerValue]];
    perAndPrice.text = [NSString stringWithFormat:@"%li元/份",[dictionary[@"dish_list"][0][@"dish_price"] integerValue]];
    
    telOfLabel.text = dictionary[@"phone"];
    addressOfLabel.text = dictionary[@"b_address"];
//    addressOfLabel.text = [NSString getTextHeightWithFont:[UIFont systemFontOfSize:13] forWidth:<#(CGFloat)#> text:<#(NSString *)#>]
    armedPriceOfLabel.text = dictionary[@"express_price"];
    totalOfPrice.text = dictionary[@"total_price"];
}

@end
