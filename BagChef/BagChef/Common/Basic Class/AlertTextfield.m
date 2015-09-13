//
//  AlertTextfield.m
//  WuZi
//
//  Created by mac on 15/4/3.
//  Copyright (c) 2015年 chenfeng. All rights reserved.
//

#import "AlertTextfield.h"
@interface AlertTextfield()<UITextFieldDelegate>
@end
@implementation AlertTextfield

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithRed:0.949f green:0.949f blue:0.949f alpha:1.00f];
        _titleLabel = [[UILabel  alloc]initWithFrame:CGRectMake(0, 10, frame.size.width, 30)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_titleLabel.frame)+20, frame.size.width-20, 40)];
//        _textField.layer.borderWidth = 1;
        _textField.delegate = self;
        [_textField setBorderStyle:UITextBorderStyleRoundedRect];
        _textField.returnKeyType = UIReturnKeyDone;
//        _textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self addSubview:_textField];
        
        UIView  * line = [[UIView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(_textField.frame)+5, frame.size.width-10, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame)+1, frame.size.width, frame.size.height - CGRectGetMaxY(line.frame)+1)];
        [btn setTitle:@"确定" forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
        [btn addTarget:self action:@selector(cancel) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:btn];
    }
    return self;
}

- (void)cancel
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
    [self removeFromSuperview];

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
