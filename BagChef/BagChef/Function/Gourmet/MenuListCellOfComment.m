//
//  MenuListCellOfComment.m
//  BagChef
//
//  Created by zhangzhi on 15/8/5.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "MenuListCellOfComment.h"

@implementation MenuListCellOfComment

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //头像
        
        _headerImageView = [[UIImageView alloc]init];
        [_headerImageView setFrame:CGRectMake(11, 11, 35, 35)];
        [_headerImageView setBackgroundColor:[UIColor grayColor]];
        [self addSubview:_headerImageView];
        
        //名称
        _nameOfLabel = [[UILabel alloc]init];
        [_nameOfLabel setFrame:CGRectMake(CGRectGetMaxX(_headerImageView.frame) + 10, CGRectGetMinY(_headerImageView.frame) + 8, 80, 15)];
        [_nameOfLabel setText:@"吃货的世界"];
        [_nameOfLabel setFont:[UIFont systemFontOfSize:14]];
        [_nameOfLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:_nameOfLabel];
        
        //时间
        
        _timeOfLabel = [[UILabel alloc]init];
        [_timeOfLabel setFrame:CGRectMake(ScreenWidth - CGRectGetMaxX(_nameOfLabel.frame) - 10, CGRectGetMaxY(_nameOfLabel.frame) - 10, ScreenWidth - (ScreenWidth - CGRectGetMaxX(_nameOfLabel.frame) - 10) - 10 , 10)];
        [_timeOfLabel setTextAlignment:NSTextAlignmentRight];
        [_timeOfLabel setText:@"2015-01-23 14:25"];
        [_timeOfLabel setTextColor:[UIColor grayColor]];
        [_timeOfLabel setFont:[UIFont systemFontOfSize:13]];
        [self addSubview:_timeOfLabel];
    
        //内容
        _contentOfLabel = [[UILabel alloc]init];
        _contentOfLabel.frame = CGRectMake(11, CGRectGetMaxY(_headerImageView.frame) + 10, ScreenWidth - 20, 35);
        _contentOfLabel.text = @"为什么我用了CGPoint p = ;p.y += 50 ;;说contentOffset不正确呢,UITextView不是继承了UIScrollView属性的吗";
        _contentOfLabel.font = [UIFont systemFontOfSize:12];
        _contentOfLabel.numberOfLines = 2;
        _contentOfLabel.textColor = [UIColor grayColor];
        [self addSubview:_contentOfLabel];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellModel:(MenuListCellOfModel *)model {
    
    //头像
//    NSString *url = model.chef[@"icon"];
//    [_headerImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://kdsc.mmqo.com%@",url]]];
}

@end
