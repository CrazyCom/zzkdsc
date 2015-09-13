//
//  HadUploadMenuTableViewCell.m
//  BagChef
//
//  Created by zhangzhi on 15/8/24.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "HadUploadMenuTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@implementation HadUploadMenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.selectButton = selectButton;
        CGFloat height = 24;
        selectButton.frame = CGRectMake((50 - height) / 2, 150 - height / 2, height, height);
        [selectButton setBackgroundImage:[UIImage imageNamed:@"jian"] forState:UIControlStateNormal];
//        [selectButton setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateSelected];
        selectButton.tag = 98;
        [selectButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:selectButton];
        
        _myContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 300)];
        _myContentView.backgroundColor = [UIColor blackColor];
        _myContentView.userInteractionEnabled = YES;
        _myContentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_myContentView];
        
        //分类名字
        _classifyNameOfLabel = [[UILabel alloc]init];
        [_classifyNameOfLabel setFrame:CGRectMake(10, 12, 100 , 18)];
        [_classifyNameOfLabel setText:@"创新小炒"];
        [self.myContentView addSubview:_classifyNameOfLabel];
        
        
        //售出份数
        _numOfSold = [[UILabel alloc]init];
        _numOfSold.text = @"0";
        
        _soldLabel = [[UILabel alloc]init];
        _soldLabel.frame = CGRectMake(CGRectGetMaxX(_classifyNameOfLabel.frame) + 10, 10, ScreenWidth - CGRectGetMaxX(_classifyNameOfLabel.frame) - 10 - 10, 20);
        _soldLabel.text = [NSString stringWithFormat:@"已售%@份",_numOfSold.text];
        _soldLabel.font = [UIFont systemFontOfSize:13];
        
        _soldLabel.textAlignment = NSTextAlignmentRight;
        [self.myContentView addSubview:_soldLabel];

        
        _adImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_classifyNameOfLabel.frame) + 12, ScreenWidth - 20, 183)];
        _adImageView.backgroundColor = [UIColor grayColor];
        [self.myContentView addSubview:_adImageView];
        
    
        //价格
        
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.frame = CGRectMake(10, CGRectGetMaxY(_adImageView.frame) + 10, 70, 16);
        _priceLabel.text = @"0";
//        _priceLabel.layer.borderColor = [UIColor grayColor].CGColor;
//        _priceLabel.layer.borderWidth = 1.0;
        _priceLabel.textColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.font = [UIFont systemFontOfSize:14];
        [self.myContentView addSubview:_priceLabel];
    
        UILabel *moneyAndPer = [[UILabel alloc]init];
        moneyAndPer.frame = CGRectMake(CGRectGetMaxX(_priceLabel.frame), CGRectGetMaxY(_adImageView.frame) + 10, 40 , 16 );
        moneyAndPer.text = @"元/份";
        moneyAndPer.textAlignment = NSTextAlignmentLeft;
        moneyAndPer.font = [UIFont systemFontOfSize:14];
        [self.myContentView addSubview:moneyAndPer];

        
        
        //时间
        UIImageView *timeImageView = [[UIImageView alloc]init];
        [timeImageView setFrame:CGRectMake(10, CGRectGetMaxY(_priceLabel.frame) + 12, 16 , 16 )];
        [timeImageView setImage:[UIImage imageNamed:@"tb5"]];
        [self.myContentView addSubview:timeImageView];

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
        [self.myContentView addSubview:timeLabel];
        
        
        UIButton *recommendBtn = [[UIButton alloc]init];
        recommendBtn.frame = CGRectMake(ScreenWidth - 10 - 120, CGRectGetMaxY(_adImageView.frame) + 15, 120, 39);
        [recommendBtn setBackgroundImage:[UIImage imageNamed:@"button2"] forState:UIControlStateNormal];
        [recommendBtn setTitle:@"设为推荐菜" forState:UIControlStateNormal];
        [recommendBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
         recommendBtn.tag = 99;
        [self.myContentView addSubview:recommendBtn];
       
    }
    return self;
}


- (void)setCellWithModel:(HadUploadMenuModel *)model {
   
    _classifyNameOfLabel.text = model.name;
    _numOfSold.text = model.sale_num;
    _priceLabel.text = model.price;
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

- (void)buttonPressed:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
//    sender.backgroundColor = sender.isSelected ? [UIColor redColor] : [UIColor colorWithWhite:0.7 alpha:1.0];
    
    if (self.buttonClick) {
        self.buttonClick(self, sender.selected,(int)sender.tag);
    }

//    if ([self respondsToSelector:_buttonClick]) {
//        [self performSelector:_buttonClick withObject:self afterDelay:0.0];
//    }
   
}


@end
