//
//  OrderInfoCell.m
//  BagChef
//
//  Created by zhangzhi on 15/8/30.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "OrderInfoCell.h"

@interface OrderInfoCell () {

    OrderInfo *_orderInfo;
}

@end


@implementation OrderInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.nameCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 47)];
        
        UILabel *nameTL = [[UILabel alloc] initWithFrame:CGRectMake(12, 13, 80, 21)];
        nameTL.font = [UIFont systemFontOfSize:15];
        nameTL.text = @"菜品名称";
        [self.nameCell addSubview:nameTL];
        
        _nameOfMenu = [[UILabel alloc]init];
        _nameOfMenu.textColor = [UIColor grayColor];
        _nameOfMenu.frame = CGRectMake(100, 17, 100, 13);
    
        [self.nameCell addSubview:_nameOfMenu];
        
        
        self.priceCell = [[UIView alloc] initWithFrame:CGRectMake(0, 47, ScreenWidth, 47)];
        
        UILabel *priceTL = [[UILabel alloc] initWithFrame:CGRectMake(12, 13, 80, 21)];
        priceTL.font = [UIFont systemFontOfSize:15];
        priceTL.text = @"菜品单价";
        [self.priceCell addSubview:priceTL];
        
        _priceOfMenu = [[UILabel alloc]init];
        _priceOfMenu.frame = CGRectMake(100, 17, 100, 13);
        _priceOfMenu.textColor = [UIColor grayColor];
        [self.priceCell addSubview:_priceOfMenu];
        
        UILabel *priceAndPer = [[UILabel alloc]init];
        priceAndPer.frame = CGRectMake(ScreenWidth - 65, 17, 55, 13);
        priceAndPer.textAlignment = NSTextAlignmentRight;
        priceAndPer.textColor = [UIColor grayColor];
        priceAndPer.text = @"元/份";
        [self.priceCell addSubview:priceAndPer];
        
        
        self.numCell = [[UIView alloc] initWithFrame:CGRectMake(0, 47 * 2, ScreenWidth, 47)];
        
        UILabel *numTL = [[UILabel alloc] initWithFrame:CGRectMake(12, 13, 80, 21)];
        numTL.font = [UIFont systemFontOfSize:15];
        numTL.text = @"购买份数";
        [self.numCell addSubview:numTL];
        
        _numberOfPart = [[UITextField alloc]init];
        _numberOfPart.frame = CGRectMake(145, 16, 52, 13);
        [_numberOfPart setUserInteractionEnabled:NO];
        _numberOfPart.textAlignment = NSTextAlignmentCenter;
        _numberOfPart.font = [UIFont systemFontOfSize:14];
        [self.numCell addSubview:_numberOfPart];
        
        UILabel *partOfLabel = [[UILabel alloc]init];
        partOfLabel.frame = CGRectMake(ScreenWidth - 35, 17, 25, 13);
        partOfLabel.textAlignment = NSTextAlignmentRight;
        partOfLabel.textColor = [UIColor grayColor];
        partOfLabel.text = @"份";
        [self.numCell addSubview:partOfLabel];
        
        //减
        UIButton *subtractBtn = [[UIButton alloc]init];
        subtractBtn.frame = CGRectMake(100, 8, 40, 35);
        subtractBtn.backgroundColor = [UIColor grayColor];
        [subtractBtn setBackgroundImage:[UIImage imageNamed:@"jian"] forState:UIControlStateNormal];
        subtractBtn.tag = 20;
        [subtractBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.numCell addSubview:subtractBtn];
        
        
        //加
        UIButton *addBtn = [[UIButton alloc]init];
        addBtn.frame = CGRectMake(200, 8, 40, 35);
        addBtn.backgroundColor = [UIColor grayColor];
        [addBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        addBtn.tag = 21;
        [addBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.numCell addSubview:addBtn];
            
        
        
        
        [self addSubview:self.nameCell];
        [self addSubview:self.priceCell];
        [self addSubview:self.numCell];
        
    }
    return self;
    
}

- (void)buttonPressed:(UIButton *)sender {
    
    int i = (int)sender.tag - 20;
    if (i == 0 && [_numberOfPart.text integerValue] >= 0) {
        
        
        if ([_numberOfPart.text integerValue] != 0) {
            _numberOfPart.text = [NSString stringWithFormat:@"%i",(int)[_numberOfPart.text integerValue] - 1];
            
        }
    }
    else {
        
        _numberOfPart.text = [NSString stringWithFormat:@"%i",(int)[_numberOfPart.text integerValue] + 1];
        
        
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(numChangeWith:Num:)]) {
        [_delegate numChangeWith:self Num:[_numberOfPart.text intValue]];
    }

}

- (void)updateCellWith:(OrderInfo *)orderInfo {

    if (!orderInfo) {
        // 数据异常
        return;
    }
    
    _orderInfo = orderInfo;
    _nameOfMenu.text = orderInfo.name;
    _priceOfMenu.text = [NSString stringWithFormat:@"%.2lf", orderInfo.price];
    _numberOfPart.text = [NSString stringWithFormat:@"%i", orderInfo.num];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
