//
//  DoHavingDeliveryViewTableViewCell.m
//  BagChef
//
//  Created by zhangzhi on 15/8/10.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "DoHavingDeliveryViewTableViewCell.h"
@interface DoHavingDeliveryViewTableViewCell () {
    
//    UILabel *dishNameOfLabel;
//    
//    UILabel *numOfLabel;
//    UILabel *perAndPrice;
//    UILabel *addressOfLabel;
//    UILabel *armedPriceOfLabel;
//    UILabel *totalOfPriceLabel;
//    UILabel *eatOfTimeLabel;
    
}

@end


@implementation DoHavingDeliveryViewTableViewCell

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
        
        
    }
    return self;
}

-(void)setCellModel:(DoHavingDeliveryModel *)model {
    
    
}

@end
