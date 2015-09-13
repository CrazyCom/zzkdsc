//
//  MyEnshrineOfMenuViewTableViewCell.m
//  BagChef
//
//  Created by zhangzhi on 15/8/11.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "MyEnshrineOfMenuViewTableViewCell.h"

@implementation MyEnshrineOfMenuViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //分类名字
        UILabel *classifyNameOfLabel = [[UILabel alloc]init];
        [classifyNameOfLabel setFrame:CGRectMake(10, 12, 100 , 18)];
        [classifyNameOfLabel setText:@"创新小炒"];
        [self.contentView addSubview:classifyNameOfLabel];
        
        UILabel *numberOfSold = [[UILabel alloc]init];
        numberOfSold.text = @"99999999";
        
        UILabel *soldLabel = [[UILabel alloc]init];
        soldLabel.frame = CGRectMake(CGRectGetMaxX(classifyNameOfLabel.frame) + 10 , CGRectGetMinX(classifyNameOfLabel.frame), ScreenWidth - CGRectGetMaxX(classifyNameOfLabel.frame) - 20, 14);
        
        soldLabel.text = [NSString stringWithFormat:@"已售%@份",numberOfSold.text];
        soldLabel.font = [UIFont systemFontOfSize:14];
        soldLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:soldLabel];
        
        ZAdvertisementView *adView = [[ZAdvertisementView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(classifyNameOfLabel.frame) + 12, ScreenWidth - 20, 183)];
        adView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:adView];
        
        
        //头像
        _headerImageView = [[UIImageView alloc]init];
        [_headerImageView setFrame:CGRectMake(11, CGRectGetMaxY(adView.frame) + 11, 46 * ratioX, 46 * ratioY)];
        [_headerImageView setBackgroundColor:[UIColor grayColor]];
        _headerImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_headerImageView];
        
        //订
        _confirmBtn = [[UIButton alloc]init];
        _confirmBtn.frame = CGRectMake(ScreenWidth - 50, CGRectGetMinY(_headerImageView.frame), 40 * ratioX, 40 *ratioX);
        [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"ding"] forState:UIControlStateNormal];
        [_confirmBtn setTitle:@"订" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_confirmBtn];
        
        
        //姓名
        _nameLabel = [[UILabel alloc]init];
        [_nameLabel setFrame:CGRectMake(CGRectGetMaxX(_headerImageView.frame) + 8 , CGRectGetMinY(_headerImageView.frame), 90 * ratioX, 17 * ratioY)];
        [_nameLabel setText:@"吃货的世界"];
        [_nameLabel setTextColor:[UIColor blackColor]];
        [_nameLabel setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:_nameLabel];
        
        //身份证
        _idCardImageView = [[UIImageView alloc]init];
        [_idCardImageView setFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame), CGRectGetMinY(_headerImageView.frame), 30 * ratioX, 15 * ratioY)];
        [_idCardImageView setBackgroundColor:[UIColor orangeColor]];
        [self.contentView addSubview:_idCardImageView];
        
        //健康证
        _healthCardImageView = [[UIImageView alloc]init];
        [_healthCardImageView setFrame:CGRectMake(CGRectGetMaxX(_idCardImageView.frame) + 5, CGRectGetMinY(_headerImageView.frame), 30 * ratioX, 15 * ratioY)];
        [_healthCardImageView setBackgroundColor:[UIColor orangeColor]];
        [self.contentView addSubview:_healthCardImageView];
        
        //star
        for (int i = 0; i < 5; i++) {
            _starImageView = [[UIImageView alloc]init];
            [_starImageView setFrame:CGRectMake(CGRectGetMaxX(_headerImageView.frame) + 8 +21 * i * ratioX, CGRectGetMaxY(_headerImageView.frame) - 18 * ratioY, 18 * ratioX, 18 * ratioY)];
            [_starImageView setImage:[UIImage imageNamed:@"star"]];
            [self.contentView addSubview:_starImageView];
        }
        
        
        
        
        //价格
        UILabel *moneyAndPer = [[UILabel alloc]init];
        moneyAndPer.frame = CGRectMake(CGRectGetMinX(_confirmBtn.frame) - 50 *ratioX, CGRectGetMinY(_starImageView.frame)  , 40 * ratioX, 16 *ratioY);
        moneyAndPer.text = @"元/份";
        moneyAndPer.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:moneyAndPer];
        
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.frame = CGRectMake(CGRectGetMaxX(_starImageView.frame) + 10, CGRectGetMinY(_starImageView.frame) - 1, ScreenWidth - CGRectGetMaxX(_starImageView.frame) - (ScreenWidth - CGRectGetMinX(moneyAndPer.frame)) - 10, 16);
        _priceLabel.text = @"99999999";
        _priceLabel.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_priceLabel];
        
        //地址
        UIImageView *positionImageView = [[UIImageView alloc]init];
        [positionImageView setFrame:CGRectMake(11, CGRectGetMaxY(_headerImageView.frame) + 21, 16 , 16)];
        [positionImageView setImage:[UIImage imageNamed:@"tb4"]];
        [self.contentView addSubview:positionImageView];
        
        _positionLabel = [[UILabel alloc]init];
        [_positionLabel setFrame:CGRectMake(CGRectGetMaxX(positionImageView.frame) + 8, CGRectGetMaxY(positionImageView.frame) - 11, (ScreenWidth - CGRectGetMaxX(positionImageView.frame) - 8 - 10), 10 )];
        [_positionLabel setText:@"成都市高新区创业路火炬大厦B座三楼"];
        [_positionLabel setFont:[UIFont systemFontOfSize:13]];
        [_positionLabel setTextColor:[UIColor colorWithRed:0.482f green:0.478f blue:0.482f alpha:1.00f]];
        [self.contentView addSubview:_positionLabel];
        
        //时间
        UIImageView *timeImageView = [[UIImageView alloc]init];
        [timeImageView setFrame:CGRectMake(CGRectGetMinX(positionImageView.frame), CGRectGetMaxY(positionImageView.frame) + 12, 16 , 16 )];
        [timeImageView setImage:[UIImage imageNamed:@"tb5"]];
        [self.contentView addSubview:timeImageView];
        
        
        //
        _fTimeLabel = [[UILabel alloc]init];
        [_fTimeLabel setText:@"11:30"];
        //
        _tTimeLabel = [[UILabel alloc]init];
        [_tTimeLabel setText:@"12:30"];
        
        UILabel *timeLabel = [[UILabel alloc]init];
        [timeLabel setFrame:CGRectMake(CGRectGetMaxX(timeImageView.frame) + 8, CGRectGetMaxY(timeImageView.frame) - 10 , (ScreenWidth - CGRectGetMaxX(timeImageView.frame) - 8 - 10), 10 )];
        [timeLabel setText:[NSString stringWithFormat:@"今日%@~%@可取",_fTimeLabel.text,_tTimeLabel.text]];
        [timeLabel setFont:[UIFont systemFontOfSize:13]];
        [timeLabel setTextColor:[UIColor colorWithRed:0.482f green:0.478f blue:0.482f alpha:1.00f]];
        [self.contentView addSubview:timeLabel];

    }
    return self;
}

@end
