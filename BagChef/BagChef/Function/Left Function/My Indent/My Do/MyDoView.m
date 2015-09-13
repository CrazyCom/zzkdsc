//
//  MyDoView.m
//  BagChef
//
//  Created by zhangzhi on 15/8/10.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "MyDoView.h"
#import "DoWaitForReceiveOrderView.h"
#import "DoHadForReceiveOrderView.h"
#import "DoHavingDeliveryView.h"
#import "DoHaveDoneView.h"

@interface MyDoView() {
    
    UILabel *_animationLabel;
    
    DoWaitForReceiveOrderView *_doWaitForReceiveOrderView;
    DoHadForReceiveOrderView *_doHadForReceiveOrderView;
    DoHavingDeliveryView *_doHavingDeliveryView;
    DoHaveDoneView *_doHaveDoneView;
}

@end

@implementation MyDoView

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
        for (int i =0; i < 4; i++) {
            UIButton *btn = [[UIButton alloc]init];
            btn.frame = CGRectMake(30 +( 60 +((ScreenWidth - 40 - 240) / 4)) * i , 0, 60, 50);
            btn.tag = 60 + i;
            [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            if (i == 0) {
                [btn setTitle:@"待接单" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor colorWithRed:1.000f green:0.294f blue:0.008f alpha:1.00f] forState:UIControlStateSelected];
                btn.selected = YES;
            }
            else if (i == 1) {
                [btn setTitle:@"已接单" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor colorWithRed:1.000f green:0.294f blue:0.008f alpha:1.00f] forState:UIControlStateSelected];
            }
            else if (i == 2) {
                [btn setTitle:@"配送中" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor colorWithRed:1.000f green:0.294f blue:0.008f alpha:1.00f] forState:UIControlStateSelected];
            }
            else {
                [btn setTitle:@"已完成" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor colorWithRed:1.000f green:0.294f blue:0.008f alpha:1.00f] forState:UIControlStateSelected];
            }
            
        }
        
        
        _animationLabel = [[UILabel alloc]init];
        _animationLabel.frame = CGRectMake(0, 50, ScreenWidth / 4, 2);
        _animationLabel.backgroundColor = [UIColor colorWithRed:1.000f green:0.294f blue:0.043f alpha:1.00f];
        [self addSubview:_animationLabel];
        
        
        _doWaitForReceiveOrderView = [[DoWaitForReceiveOrderView alloc]initWithFrame:CGRectMake(0, 52, ScreenWidth, ScreenHeight - 52 )];
        _doWaitForReceiveOrderView.alpha = 1;
        [self addSubview:_doWaitForReceiveOrderView];
        
        _doHadForReceiveOrderView = [[DoHadForReceiveOrderView alloc]initWithFrame:CGRectMake(0, 52, ScreenWidth, ScreenHeight - 52)];
        _doHadForReceiveOrderView.alpha = 0;
        [self addSubview:_doHadForReceiveOrderView];
        
        _doHavingDeliveryView = [[DoHavingDeliveryView alloc]initWithFrame:CGRectMake(0, 52, ScreenWidth, ScreenHeight - 52)];
        _doHavingDeliveryView.alpha = 0;
        [self addSubview:_doHavingDeliveryView];
        
        _doHaveDoneView = [[DoHaveDoneView alloc]initWithFrame:CGRectMake(0, 52, ScreenWidth, ScreenHeight - 52)];
        _doHaveDoneView.alpha = 0;
        [self addSubview:_doHaveDoneView];
        
        [self buttonPressed:(UIButton *)[self viewWithTag:60]];
    }
    return self;
}


- (void)buttonPressed:(UIButton *)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _animationLabel.frame = CGRectMake(ScreenWidth / 4 * (sender.tag - 60), 50, ScreenWidth / 4, 2);
        
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
            _doWaitForReceiveOrderView.alpha = 1;
            _doHadForReceiveOrderView.alpha = 0;
            _doHavingDeliveryView.alpha = 0;
            _doHaveDoneView.alpha = 0;
        
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *pwd = [userDefaults objectForKey:@"pwd"];
            NSString *tel = [userDefaults objectForKey:@"tel"];
            NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"status":@"1",@"type":@"chef"};
            DisplayView *displayView = [[DisplayView alloc] init];
            [displayView displayShowLoading:self];
            [NetWorkHandler orderList:dict completionHandler:^(id content) {
                NSLog(@"orderList:%@",content);
                [displayView displayHideLoading];
                //NSURLError objectForKeyedSubscript:]: unrecognized selector sent to instance 0x17024f3c0'
                if ([content isEqual:[NSNull class]]) {
                    
                    return ;
                }
                else if ([content[@"data"] isKindOfClass:[NSNull class]]) {
                    [DisplayView displayShowWithTitle:content[@"info"]];
                    return ;
                }
                
                [_doWaitForReceiveOrderView updateViewWith:content];
            }];

        }
            break;
        case 1:
        {
            _doWaitForReceiveOrderView.alpha = 0;
            _doHadForReceiveOrderView.alpha = 1;
            _doHavingDeliveryView.alpha = 0;
            _doHaveDoneView.alpha = 0;
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *pwd = [userDefaults objectForKey:@"pwd"];
            NSString *tel = [userDefaults objectForKey:@"tel"];
            NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"status":@"2",@"type":@"chef"};
            DisplayView *displayView = [[DisplayView alloc] init];
            [displayView displayShowLoading:self];
            [NetWorkHandler orderList:dict completionHandler:^(id content) {
                NSLog(@"orderGuest:%@",content);
                [displayView displayHideLoading];
                if ([content isEqual:[NSNull class]]) {
                    
                    return ;
                }
                else if ([content[@"data"] isKindOfClass:[NSNull class]]) {
                    [DisplayView displayShowWithTitle:content[@"info"]];
                    return ;
                }
                
                [_doHadForReceiveOrderView updateViewWith:content];
            }];
            

        }
            break;
        case 2:
        {
            _doWaitForReceiveOrderView.alpha = 0;
            _doHadForReceiveOrderView.alpha = 0;
            _doHavingDeliveryView.alpha = 1;
            _doHaveDoneView.alpha = 0;
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *pwd = [userDefaults objectForKey:@"pwd"];
            NSString *tel = [userDefaults objectForKey:@"tel"];
            NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"status":@"3",@"type":@"chef"};
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
                
                [_doHavingDeliveryView updateViewWith:content];
            }];
            

        }
            break;
        case 3:
        {
            _doWaitForReceiveOrderView.alpha = 0;
            _doHadForReceiveOrderView.alpha = 0;
            _doHavingDeliveryView.alpha = 0;
            _doHaveDoneView.alpha = 1;
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *pwd = [userDefaults objectForKey:@"pwd"];
            NSString *tel = [userDefaults objectForKey:@"tel"];
            NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"status":@"4",@"type":@"chef"};
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
                
                [_doHaveDoneView updateViewWith:content];
            }];
            

        }
            break;
        default:
            break;
    }
    
}


@end
