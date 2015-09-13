//
//  GourmetCell.m
//  BagChef
//
//  Created by zhangzhi on 15/8/4.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "GourmetCell.h"

@implementation GourmetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //头像
        _headerImageBtn = [[UIButton alloc]init];
        [_headerImageBtn setFrame:CGRectMake(11, 11, 46 * ratioX, 46 * ratioY)];
        [_headerImageBtn setBackgroundColor:[UIColor grayColor]];
        _headerImageBtn.userInteractionEnabled = YES;
        _headerImageBtn.tag = 60;
        [_headerImageBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_headerImageBtn];
        
       
        //姓名
        _nameLabel = [[UILabel alloc]init];
        [_nameLabel setFrame:CGRectMake(CGRectGetMaxX(_headerImageBtn.frame) + 8 , CGRectGetMinY(_headerImageBtn.frame), 90 * ratioX, 17 * ratioY)];
        [_nameLabel setText:@"吃货的世界"];
        [_nameLabel setTextColor:[UIColor blackColor]];
        [_nameLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:_nameLabel];
        
        //身份证
        _idBtn = [[UIButton alloc]init];
        [_idBtn setFrame:CGRectMake(CGRectGetMaxX(_nameLabel.frame), CGRectGetMinY(_headerImageBtn.frame), 30 * ratioX, 15 * ratioY)];
        [_idBtn setBackgroundColor:[UIColor orangeColor]];
        [_idBtn setTitle:@"身份证" forState:UIControlStateNormal];
        _idBtn.titleLabel.font = [UIFont systemFontOfSize:8];
        [self addSubview:_idBtn];
        
        //健康证
        _healthBtn = [[UIButton alloc]init];
        [_healthBtn setFrame:CGRectMake(CGRectGetMaxX(_idBtn.frame) + 5, CGRectGetMinY(_headerImageBtn.frame), 30 * ratioX, 15 * ratioY)];
        [_healthBtn setBackgroundColor:[UIColor orangeColor]];
        [_healthBtn setTitle:@"健康证" forState:UIControlStateNormal];
        _healthBtn.titleLabel.font = [UIFont systemFontOfSize:8];

        [self addSubview:_healthBtn];
        
        
        
        //star
        for (int i = 0; i < 5; i++) {
           UIImageView  *starImageView = [[UIImageView alloc]init];
            starImageView.tag = 100 + i;
            [starImageView setFrame:CGRectMake(CGRectGetMaxX(_headerImageBtn.frame) + 8 +21 * i * ratioX, CGRectGetMaxY(_headerImageBtn.frame) - 18 * ratioY, 18 * ratioX, 18 * ratioY)];
            [starImageView setImage:[UIImage imageNamed:@"tb9"]];
            [self addSubview:starImageView];
        }
        
        //
        UIImageView *positionImageView = [[UIImageView alloc]init];
        [positionImageView setFrame:CGRectMake(11, CGRectGetMaxY(_headerImageBtn.frame) + 11, 16 * ratioX, 16 * ratioY)];
        [positionImageView setImage:[UIImage imageNamed:@"tb4"]];
        [self addSubview:positionImageView];
        
        _positionLabel = [[UILabel alloc]init];
        [_positionLabel setFrame:CGRectMake(CGRectGetMaxX(positionImageView.frame) + 8, CGRectGetMaxY(positionImageView.frame) - 10, (ScreenWidth - CGRectGetMaxX(positionImageView.frame) - 8 - 10) * ratioX, 10 * ratioY)];
        [_positionLabel setText:@""];
        [_positionLabel setFont:[UIFont systemFontOfSize:13]];
        [_positionLabel setTextColor:[UIColor colorWithRed:0.482f green:0.478f blue:0.482f alpha:1.00f]];
        [self addSubview:_positionLabel];
        
        _nullTopLabel = [[UILabel alloc]init];
        _nullTopLabel.frame = CGRectMake(CGRectGetMinX(positionImageView.frame), CGRectGetMaxY(positionImageView.frame) + 10, ScreenWidth - CGRectGetMinX(positionImageView.frame) - 10, 30);
        _nullTopLabel.text = @"该厨师暂无推荐菜品";
        _nullTopLabel.font = [UIFont systemFontOfSize:16];
        _nullTopLabel.hidden = YES;
        [self addSubview:_nullTopLabel];
        
        
        for (int i = 0; i < 3; i ++) {
           
            //菜品图片
            _menuImageBtn = [[UIButton alloc]init];
            [_menuImageBtn setFrame:CGRectMake(11 + 120 * i * ratioX, CGRectGetMaxY(_positionLabel.frame) + 10, 115 * ratioX, 75 * ratioY)];
            [_menuImageBtn setBackgroundColor:[UIColor whiteColor]];
            [_menuImageBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
            _menuImageBtn.tag = 30 + i;
            _menuImageBtn.hidden = YES;
            [self addSubview:_menuImageBtn];
            
            //菜品名称
            _nameOfMenuLabel = [[UILabel alloc]init];
            [_nameOfMenuLabel setFrame:CGRectMake(11 + 120 * i * ratioX, CGRectGetMaxY(_menuImageBtn.frame) + 10, 115 * ratioX, 15 * ratioY)];
            [_nameOfMenuLabel setText:@""];
            _nameOfMenuLabel.tag = 40 + i;
            [_nameOfMenuLabel setFont:[UIFont systemFontOfSize:13]];
            _nameOfMenuLabel.hidden = YES;
            [self addSubview:_nameOfMenuLabel];
            
            //已售份额
            _numberOfSoldLabel = [[UILabel alloc]init];
            [_numberOfSoldLabel setText:@"0"];
            
            UILabel *soldOfNum = [[UILabel alloc]init];
            [soldOfNum setFrame:CGRectMake(11 + 120 * i * ratioX, CGRectGetMaxY(_menuImageBtn.frame) + 32 * ratioY, 115 * ratioX, 15 * ratioY)];
            [soldOfNum setText:[NSString stringWithFormat:@"已售%@份",_numberOfSoldLabel.text]];
            [soldOfNum setTextAlignment:NSTextAlignmentLeft];
            [soldOfNum setFont:[UIFont systemFontOfSize:11]];
            [soldOfNum setTextColor:[UIColor colorWithRed:0.482f green:0.478f blue:0.482f alpha:1.00f]];
            soldOfNum.tag = 50 + i;
            soldOfNum.hidden = YES;
            [self addSubview:soldOfNum];
        }
        
        
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

-(void)setCellWithModel:(GourmetViewModel *)model {

//    if ([_dataSource[indexPath.section][@"top"] isKindOfClass:[NSNull class]]) {
//        <#statements#>
//    }
    NSLog(@"%@",model.top);
//    if ([model.top isKindOfClass:[NSNull class]]) {
//        
//        _nullTopLabel.hidden = NO;
//    }
    if ([model.top isKindOfClass:[NSString class]]) {
        _nullTopLabel.hidden = NO;
    }
    //头像
    NSString *imageUrlPart = model.icon;
    NSData *headerImageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://kdsc.mmqo.com%@",imageUrlPart]]];
    [_headerImageBtn setBackgroundImage:[UIImage imageWithData:headerImageData] forState:UIControlStateNormal];
    
    
    //姓名
    _nameLabel.text = model.nicename;
    
    //地址
    _positionLabel.text = model.address;
    
    
    //
    if ([model.top isKindOfClass:[NSArray class]]) {
        
        for (int i = 0; i < model.top.count; i++) {
            
            //菜品图片
            //        [imageView1 setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://kdsc.mmqo.com%@",url]]]; //异步加载，图片不能再使用时保证已经下载，所以可能为nil
            NSString *url = model.top[i][@"pic_one"];
            UIButton *imageViewBtn = (UIButton *)[self viewWithTag:30 + i];
            imageViewBtn.hidden = NO;
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://kdsc.mmqo.com%@",url]]];
            [imageViewBtn setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
            
            //菜品名称
            UILabel *nameOfLabel = (UILabel *)[self viewWithTag:40 + i];
            nameOfLabel.hidden = NO;
            nameOfLabel.text = model.top[i][@"name"];
            
            //已售份额
            UILabel *numOfSale = (UILabel *)[self viewWithTag:50 + i];
            numOfSale.hidden = NO;
            numOfSale.text =  [NSString stringWithFormat:@"已售%@份",model.top[i][@"sale_num"]];
            
        }

    }
   
   
    NSString *score = [NSString stringWithFormat:@"%@",model.score];
    [Common  screNumber:score view:self tag:100];
}

- (void)buttonPressed:(UIButton *)sender {
    
    if (self.sendBtn) {
        self.sendBtn(self,(int)(sender.tag));
    }
}

@end
