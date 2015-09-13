//
//  MySendView.m
//  BagChef
//
//  Created by zhangzhi on 15/8/10.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "MySendView.h"
#import "SendWaitForDeliveryView.h"
#import "SendBeSendingView.h"
#import "SendBeDoneView.h"

@interface MySendView() {
    
    UILabel *_animationLabel;
    SendWaitForDeliveryView *_sendWaitForDeliveryView;
    SendBeSendingView *_sendBeSendingView;
    SendBeDoneView *_sendBeDoneView;
}


@end

@implementation MySendView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        //
        for (int i =0; i < 3; i++) {
            UIButton *btn = [[UIButton alloc]init];
            btn.frame = CGRectMake(0 + (ScreenWidth / 3) * i, 0, ScreenWidth / 3, 50);
            btn.tag = 60 + i;
            [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            if (i == 0) {
                [btn setTitle:@"待送镖" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor colorWithRed:1.000f green:0.294f blue:0.008f alpha:1.00f] forState:UIControlStateSelected];
                btn.selected = YES;
            }
            else if (i == 1) {
                [btn setTitle:@"配送中" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor colorWithRed:1.000f green:0.294f blue:0.008f alpha:1.00f] forState:UIControlStateSelected];
            }
            
            else if (i == 2) {
                [btn setTitle:@"已完成" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor colorWithRed:1.000f green:0.294f blue:0.008f alpha:1.00f] forState:UIControlStateSelected];
            }
            
        }
        
        
        _animationLabel = [[UILabel alloc]init];
        _animationLabel.frame = CGRectMake(0, 50, ScreenWidth / 3, 2);
        _animationLabel.backgroundColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
        [self addSubview:_animationLabel];
        
        
        _sendWaitForDeliveryView = [[SendWaitForDeliveryView alloc]initWithFrame:CGRectMake(0, 52, ScreenWidth, ScreenHeight - 52 )];
        _sendWaitForDeliveryView.alpha = 1;
        [self addSubview:_sendWaitForDeliveryView];
        
        _sendBeSendingView = [[SendBeSendingView alloc]initWithFrame:CGRectMake(0, 52, ScreenWidth, ScreenHeight - 52)];
        _sendBeSendingView.alpha = 0;
        [self addSubview:_sendBeSendingView];
        
        _sendBeDoneView = [[SendBeDoneView alloc]initWithFrame:CGRectMake(0, 52, ScreenWidth, ScreenHeight - 52)];
        _sendBeDoneView.alpha = 0;
        [self addSubview:_sendBeDoneView];
        
        
        [self buttonPressed:(UIButton *)[self viewWithTag:60]];
    }
    return self;
}


- (void)buttonPressed:(UIButton *)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _animationLabel.frame = CGRectMake(ScreenWidth / 3 * (sender.tag - 60), 50, ScreenWidth / 3, 2);
        
    }];
    
    for (int i = 0; i < 4; i ++) {
        UIButton *btn = (UIButton *)[self viewWithTag:i + 60];
        btn.selected = NO;
    }
    sender.selected = YES;
    
    switch ((int)sender.tag - 50) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        default:
            break;
    }
    
    switch ((int)sender.tag - 60) {
        case 0:
        {
            _sendWaitForDeliveryView.alpha = 1;
            _sendBeSendingView.alpha = 0;
            _sendBeDoneView.alpha = 0;
            
//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            NSString *pwd = [userDefaults objectForKey:@"pwd"];
//            NSString *tel = [userDefaults objectForKey:@"tel"];
////            NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"page":@"2"};
//            NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"status":@"2",@"type":@"express"};
//            DisplayView *displayView = [[DisplayView alloc] init];
//            [displayView displayShowLoading:self];
//            
//            [NetWorkHandler expressOrderList:dict completionHandler:^(id content) {
//                
//                NSLog(@"orderList:%@",content);
//                [displayView displayHideLoading];
//                if ([content[@"data"] isKindOfClass:[NSNull class]]) {
//                    [DisplayView displayShowWithTitle:content[@"info"]];
//                    return ;
//                }
//                
//                [_sendWaitForDeliveryView updateViewWith:content];
//            }];
            
//            [NetWorkHandler orderList:dict completionHandler:^(id content) {
//                NSLog(@"orderList:%@",content);
//                [displayView displayHideLoading];
//                if ([content[@"data"] isKindOfClass:[NSNull class]]) {
//                    [DisplayView displayShowWithTitle:content[@"info"]];
//                    return ;
//                }
//                
//                [_sendWaitForDeliveryView updateViewWith:content];
//            }];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *pwd = [userDefaults objectForKey:@"pwd"];
            NSString *tel = [userDefaults objectForKey:@"tel"];
            NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"status":@"2",@"type":@"express"};
            DisplayView *displayView = [[DisplayView alloc] init];
            [displayView displayShowLoading:self];
            [NetWorkHandler orderList:dict completionHandler:^(id content) {
                NSLog(@"orderList:%@",content);
                [displayView displayHideLoading];
                if ([content isEqual:[NSNull class]]) {
                    
                    return ;
                }
                else if ([content[@"data"] isKindOfClass:[NSNull class]]) {
                    [DisplayView displayShowWithTitle:content[@"info"]];
                    return ;
                }
                
                [_sendWaitForDeliveryView updateViewWith:content];
            }];


        }
            break;
        case 1:
        {
            _sendWaitForDeliveryView.alpha = 0;
            _sendBeSendingView.alpha = 1;
            _sendBeDoneView.alpha = 0;
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *pwd = [userDefaults objectForKey:@"pwd"];
            NSString *tel = [userDefaults objectForKey:@"tel"];
            NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"status":@"3",@"type":@"express"};
            DisplayView *displayView = [[DisplayView alloc] init];
            [displayView displayShowLoading:self];
            [NetWorkHandler orderList:dict completionHandler:^(id content) {
                NSLog(@"orderList:%@",content);
                [displayView displayHideLoading];
                if ([content isEqual:[NSNull class]]) {
                    
                    return ;
                }
                else if ([content[@"data"] isKindOfClass:[NSNull class]]) {
                    [DisplayView displayShowWithTitle:content[@"info"]];
                    return ;
                }
                
                [_sendBeSendingView updateViewWith:content];
            }];

        }
            break;
        case 2:
        {
            _sendWaitForDeliveryView.alpha = 0;
            _sendBeSendingView.alpha = 0;
            _sendBeDoneView.alpha = 1;
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *pwd = [userDefaults objectForKey:@"pwd"];
            NSString *tel = [userDefaults objectForKey:@"tel"];
            NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"status":@"4",@"type":@"express"};
            DisplayView *displayView = [[DisplayView alloc] init];
            [displayView displayShowLoading:self];
            [NetWorkHandler orderList:dict completionHandler:^(id content) {
                NSLog(@"orderList:%@",content);
                [displayView displayHideLoading];if ([content isEqual:[NSNull class]]) {
                    
                    return ;
                }
                else if ([content[@"data"] isKindOfClass:[NSNull class]]) {
                    [DisplayView displayShowWithTitle:content[@"info"]];
                    return ;
                }
                
                [_sendBeDoneView updateViewWith:content];
            }];

        }
            break;
        default:
            break;
    }
    
}


@end
