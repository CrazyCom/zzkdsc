//
//  HomePageCellOfPrivateChef.m
//  BagChef
//
//  Created by zhangzhi on 15/7/30.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "HomePageCellOfPrivateChef.h"

@interface HomePageCellOfPrivateChef () {

    HomePageModel *_hpModel;
}


@end

@implementation HomePageCellOfPrivateChef

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //分类名字
        _classifyNameOfLabel = [[UILabel alloc]init];
        [_classifyNameOfLabel setFrame:CGRectMake(10, 12, 100 , 18)];
        [_classifyNameOfLabel setText:@"创新小炒"];
        [self.contentView addSubview:_classifyNameOfLabel];
        
        
        //售出份数
        _numOfSold = [[UILabel alloc]init];
        _numOfSold.text = @"0";
        
        _soldLabel = [[UILabel alloc]init];
        _soldLabel.frame = CGRectMake(CGRectGetMaxX(_classifyNameOfLabel.frame) + 10, 10, ScreenWidth - CGRectGetMaxX(_classifyNameOfLabel.frame) - 10 - 10, 20);
        _soldLabel.text = [NSString stringWithFormat:@"已售%@份",_numOfSold.text];
        _soldLabel.font = [UIFont systemFontOfSize:13];
        
        _soldLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_soldLabel];
        
        
        _adImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_classifyNameOfLabel.frame) + 12, ScreenWidth - 20, 183)];
        _adImageView.backgroundColor = [UIColor grayColor];
        _adImageView.contentMode = UIViewContentModeScaleAspectFill;
        _adImageView.clipsToBounds = YES;
        [self.contentView addSubview:_adImageView];
        
        
        //价格
        
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.frame = CGRectMake(10, CGRectGetMaxY(_adImageView.frame) + 10, 70, 16);
        _priceLabel.text = @"0";
        //        _priceLabel.layer.borderColor = [UIColor grayColor].CGColor;
        //        _priceLabel.layer.borderWidth = 1.0;
        _priceLabel.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_priceLabel];
        
        UILabel *moneyAndPer = [[UILabel alloc]init];
        moneyAndPer.frame = CGRectMake(CGRectGetMaxX(_priceLabel.frame), CGRectGetMaxY(_adImageView.frame) + 10, 40 , 16 );
        moneyAndPer.text = @"元/份";
        moneyAndPer.textAlignment = NSTextAlignmentLeft;
        moneyAndPer.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:moneyAndPer];
        
        
        
        //时间
        UIImageView *timeImageView = [[UIImageView alloc]init];
        [timeImageView setFrame:CGRectMake(10, CGRectGetMaxY(_priceLabel.frame) + 12, 16 , 16 )];
        [timeImageView setImage:[UIImage imageNamed:@"tb5"]];
        [self.contentView addSubview:timeImageView];
        
        //
        _fTimeLabel = [[UILabel alloc]init];
        [_fTimeLabel setText:@"00:00"];
        //
        _tTimeLabel = [[UILabel alloc]init];
        [_tTimeLabel setText:@"00:00"];
        
        timeLabel  = [[UILabel alloc]init];
        [timeLabel setFrame:CGRectMake(CGRectGetMaxX(timeImageView.frame) + 5, CGRectGetMaxY(timeImageView.frame) - 12 , ScreenWidth -120 - 10 - 16 - 10 - 5 , 10 )];
        [timeLabel setText:[NSString stringWithFormat:@"今日%@~%@可取",_fTimeLabel.text,_tTimeLabel.text]];
        [timeLabel setFont:[UIFont systemFontOfSize:13]];
        [timeLabel setTextColor:[UIColor colorWithRed:0.482f green:0.478f blue:0.482f alpha:1.00f]];
        [self.contentView addSubview:timeLabel];
        
        
//        UIButton *recommendBtn = [[UIButton alloc]init];
//        recommendBtn.frame = CGRectMake(ScreenWidth - 10 - 120, CGRectGetMaxY(_adImageView.frame) + 15, 120, 39);
//        [recommendBtn setBackgroundImage:[UIImage imageNamed:@"button2"] forState:UIControlStateNormal];
//        [recommendBtn setTitle:@"设为推荐菜" forState:UIControlStateNormal];
//        [self.myContentView addSubview:recommendBtn];
        
        
        //加
        UIButton *addBtn = [[UIButton alloc]init];
        addBtn.frame = CGRectMake(ScreenWidth - 30, CGRectGetMaxY(_adImageView.frame) + 20, 20, 20);
        addBtn.backgroundColor = [UIColor grayColor];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        addBtn.tag = 21;
        [addBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:addBtn];
        
        //减
        UIButton *subtractBtn = [[UIButton alloc]init];
        subtractBtn.frame = CGRectMake(ScreenWidth - 30 - 50 - 20 , CGRectGetMaxY(_adImageView.frame) + 20, 20, 20);
        subtractBtn.backgroundColor = [UIColor grayColor];
        [subtractBtn setBackgroundImage:[UIImage imageNamed:@"jian"] forState:UIControlStateNormal];
        subtractBtn.tag = 20;
        [subtractBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:subtractBtn];
        
        _numberOfPart = [[UITextField alloc]init];
        _numberOfPart.frame = CGRectMake(ScreenWidth - 30 - 50, CGRectGetMaxY(_adImageView.frame) + 23, 50, 13);
        _numberOfPart.textAlignment = NSTextAlignmentCenter;
        _numberOfPart.text = @"0";
        [_numberOfPart setUserInteractionEnabled:NO];
        _numberOfPart.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_numberOfPart];
        
       

    }
    return self;
}

- (void)buttonPressed:(UIButton *)sender {
    
    if ([Common compareNowDateWithSendString:_hpModel.sell_time_end]) {
        
        int i = (int)sender.tag - 20;
        if (i == 0 && [_numberOfPart.text integerValue] >= 0) {
            
            
            if ([_numberOfPart.text integerValue] != 0) {
                _numberOfPart.text = [NSString stringWithFormat:@"%i",(int)[_numberOfPart.text integerValue] - 1];
                
            }
        }
        else {
            
            _numberOfPart.text = [NSString stringWithFormat:@"%i",(int)[_numberOfPart.text integerValue] + 1];
            
            
        }
        
        if (_buttonClick) {
            _buttonClick(_hpModel, [_numberOfPart.text intValue]);
        }
        

    }
    
    else {
        
        UIAlertView *mAlertView = [[UIAlertView alloc]initWithTitle:@"此菜品已超过预订时间" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [mAlertView show];
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellWithModel:(HomePageModel *)model {
    
    _hpModel = model;
    
    _classifyNameOfLabel.text = model.name;
    _numOfSold.text = model.sale_num;
    _priceLabel.text = [NSString stringWithFormat:@"%.2f",[model.price floatValue]];
    _fTimeLabel.text = model.sell_time_start;
    _tTimeLabel.text = model.sell_time_end;
    [timeLabel setText:[NSString stringWithFormat:@"今日%@~%@可取",_fTimeLabel.text,_tTimeLabel.text]];
    [_soldLabel setText:[NSString stringWithFormat:@"已售%@份",_numOfSold.text]];
    
    if ([model.pic isKindOfClass:[NSArray class]] && model.pic.count > 0) {
        
        NSString *imageUrlPart = model.pic[0][@"path"];
        [_adImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://kdsc.mmqo.com%@",imageUrlPart]]];
        
    }
    else {
        
        [_adImageView setImage:nil];
        
    }

}
@end
