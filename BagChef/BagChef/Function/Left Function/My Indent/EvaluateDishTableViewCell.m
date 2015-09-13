//
//  EvaluateDishTableViewCell.m
//  BagChef
//
//  Created by zhangzhi on 15/9/12.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "EvaluateDishTableViewCell.h"
#import "EvaluateStarButton.h"

@interface EvaluateDishTableViewCell ()<UITextViewDelegate> {
    
    UILabel *_dishOfName;
    UILabel *_numOfLabel;
    UILabel *_perAndPrice;
    
    UITextView *_textView;
    UILabel *_label;
    float scoreNum;
}

@end

@implementation EvaluateDishTableViewCell

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
        _dishOfName.frame = CGRectMake(12, 10, 80, 21);
        _dishOfName.text = @"电饭煲";
        _dishOfName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_dishOfName];
        
        _numOfLabel = [[UILabel alloc]init];
        _numOfLabel.frame = CGRectMake(CGRectGetMaxX(_dishOfName.frame) + 30, CGRectGetMinY(_dishOfName.frame), 60, 21);
        _numOfLabel.text = @"X1";
        _numOfLabel.textAlignment = NSTextAlignmentCenter;
        _numOfLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_numOfLabel];
        
        _perAndPrice = [[UILabel alloc]init];
        _perAndPrice.frame = CGRectMake(ScreenWidth - 130, CGRectGetMinY(_dishOfName.frame), 120, 21);
        _perAndPrice.text = @"25元/份";
        _perAndPrice.textAlignment = NSTextAlignmentRight;
        _perAndPrice.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_perAndPrice];

        
        UILabel *commentLabel = [[UILabel alloc]init];
        commentLabel.frame = CGRectMake(CGRectGetMinX(_dishOfName.frame), CGRectGetMaxY(_dishOfName.frame) + 20, 80, 20);
        commentLabel.text = @"综合评价";
        [self.contentView addSubview:commentLabel];
        
        
        //star
        for (int i = 0; i < 5; i++) {
            EvaluateStarButton  *button = [[EvaluateStarButton alloc]init];
            button.tag = 100 + i;
            [button setFrame:CGRectMake(CGRectGetMaxX(commentLabel.frame) + 8 +21 * i , CGRectGetMaxY(commentLabel.frame) - 12 , 18 * ratioX, 18 * ratioY)];
            [button setImage:[UIImage imageNamed:@"tb9"] forType:StarTypeNormal];
            [button setImage:[UIImage imageNamed:@"tb7_1"] forType:StarTypeSelected2];
            [button setImage:[UIImage imageNamed:@"star"] forType:StarTypeSelected1];
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
        
        _textView = [[UITextView alloc]init];
        _textView.frame = CGRectMake(10, CGRectGetMaxY(commentLabel.frame) + 22, ScreenWidth - 20, 55);
        _textView.layer.borderColor = [UIColor colorWithRed:0.937f green:0.937f blue:0.957f alpha:1.00f].CGColor;
        _textView.layer.borderWidth = 1.0;
        _textView.delegate = self;
        [self addSubview:_textView];
        
        
        _label = [[UILabel alloc]init];
        _label.frame = CGRectMake(10, 6, 80, 20);
        _label.text = @"我来说两句";
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor = [UIColor grayColor];
        [_textView addSubview:_label];


    }
    
    return self;
}

-(void)setCellModel:(EvaluateDishTableViewCellModel *)model {
    
    _dishOfName.text = model.dish_name;
    _numOfLabel.text = [NSString stringWithFormat:@"%@份", model.dish_num];
    _perAndPrice.text = [NSString stringWithFormat:@"%@元",model.dish_price];
    
}

- (void)buttonPressed:(EvaluateStarButton *)sender {
   
    scoreNum = 0;
    
    if (sender.starType == StarTypeSelected1 && sender.selected) {
        sender.starType = StarTypeSelected2;
        
    }
    else {
        sender.starType = StarTypeSelected1;
       
    }
    
    for (long i = 100; i < sender.tag; i++) {
        EvaluateStarButton *button = (EvaluateStarButton *)[self viewWithTag:i];
        button.starType = StarTypeSelected1;
        button.selected = NO;
        scoreNum = sender.tag - 1;
    }
    for (long i = sender.tag + 1; i <= 105; i++) {
        EvaluateStarButton *button = (EvaluateStarButton *)[self viewWithTag:i];
        button.starType = StarTypeNormal;
        button.selected = NO;
    }
    
    sender.selected = YES;
    
    scoreNum = (sender.tag - 99 - (sender.starType == StarTypeSelected1 ? 0 : 0.5)) * 1;
    
    NSLog(@"score number : %.1f", scoreNum);

}

#pragma TextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    _label.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (_textView.text.length == 0) {
        _label.hidden = NO;
    }
}


@end
