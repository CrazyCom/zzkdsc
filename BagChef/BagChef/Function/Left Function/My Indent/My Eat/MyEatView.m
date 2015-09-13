//
//  MYEatView.m
//  BagChef
//
//  Created by zhangzhi on 15/8/10.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "MyEatView.h"

#import "EatHadOverBookView.h"
#import "EatHadOrderReceivingView.h"
#import "EatHavingDeliveryView.h"
#import "EatHaveDoneView.h"

@interface MyEatView() {
    
    
    UILabel *_animationLabel;
    
    
    EatHadOverBookView *_eatHadOverBookV;
    EatHadOrderReceivingView *_eatHadOrderReceiveV;
    EatHavingDeliveryView *_eatHavingDeliveryV;
    EatHaveDoneView *_eatHaveDoneView;
 
}
@end

@implementation MyEatView

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
        for (int i = 0; i < 4; i++) {
            UIButton *btn = [[UIButton alloc]init];
            btn.frame = CGRectMake(30 +( 60 +((ScreenWidth - 40 - 240) / 4)) * i , 0, 60, 50);
            btn.tag = 60 + i;
            [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            if (i == 0) {
                [btn setTitle:@"已下单" forState:UIControlStateNormal];
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
        
        
        _eatHadOverBookV = [[EatHadOverBookView alloc]initWithFrame:CGRectMake(0, 52, ScreenWidth, ScreenHeight - 52 )];
        _eatHadOverBookV.alpha = 1;
        [self addSubview:_eatHadOverBookV];
        
        _eatHadOrderReceiveV = [[EatHadOrderReceivingView alloc]initWithFrame:CGRectMake(0, 52, ScreenWidth, ScreenHeight - 52)];
        _eatHadOrderReceiveV.alpha = 0;
        [self addSubview:_eatHadOrderReceiveV];
        
        _eatHavingDeliveryV = [[EatHavingDeliveryView alloc]initWithFrame:CGRectMake(0, 52, ScreenWidth, ScreenHeight - 52)];
        _eatHavingDeliveryV.alpha = 0;
        [self addSubview:_eatHavingDeliveryV];
        
        _eatHaveDoneView = [[EatHaveDoneView alloc]initWithFrame:CGRectMake(0, 52, ScreenWidth, ScreenHeight - 52)];
        _eatHaveDoneView.alpha = 0;
        [self addSubview:_eatHaveDoneView];

        
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
            _eatHadOverBookV.alpha = 1;
            _eatHadOrderReceiveV.alpha = 0;
            _eatHavingDeliveryV.alpha = 0;
            _eatHaveDoneView.alpha = 0;
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *pwd = [userDefaults objectForKey:@"pwd"];
            NSString *tel = [userDefaults objectForKey:@"tel"];
            NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"status":@"1",@"type":@"guest"};
            DisplayView *displayView = [[DisplayView alloc] init];
            [displayView displayShowLoading:_eatHadOverBookV];
            [NetWorkHandler orderList:dict completionHandler:^(id content) {
                [displayView displayHideLoading];
                NSLog(@"orderGuest:%@",content);
                if ([content isEqual:[NSNull class]]) {
                    
                    return ;
                }
                else if ([content[@"data"] isKindOfClass:[NSNull class]]) {
                    [DisplayView displayShowWithTitle:content[@"info"]];
                    return ;
                }

                [_eatHadOverBookV updateViewWith:content];
            }];
            
            
        }
            break;
        case 1:
        {
            _eatHadOverBookV.alpha = 0;
            _eatHadOrderReceiveV.alpha = 1;
            _eatHavingDeliveryV.alpha = 0;
            _eatHaveDoneView.alpha = 0;
            
        
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *pwd = [userDefaults objectForKey:@"pwd"];
            NSString *tel = [userDefaults objectForKey:@"tel"];
            NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"status":@"2",@"type":@"guest"};
            DisplayView *displayView = [[DisplayView alloc] init];
            [displayView displayShowLoading:_eatHadOrderReceiveV];
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
                [_eatHadOrderReceiveV updateViewWith:content];
            }];

            
        }
            
            break;
        case 2:
        {
            _eatHadOverBookV.alpha = 0;
            _eatHadOrderReceiveV.alpha = 0;
            _eatHavingDeliveryV.alpha = 1;
            _eatHaveDoneView.alpha = 0;
            
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *pwd = [userDefaults objectForKey:@"pwd"];
            NSString *tel = [userDefaults objectForKey:@"tel"];
            NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"status":@"3",@"type":@"guest"};
            DisplayView *displayView = [[DisplayView alloc] init];
            [displayView displayShowLoading:_eatHavingDeliveryV];
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
                [_eatHavingDeliveryV updateViewWith:content];
            }];

        }
            break;
        case 3:
        {
            _eatHadOverBookV.alpha = 0;
            _eatHadOrderReceiveV.alpha = 0;
            _eatHavingDeliveryV.alpha = 0;
            _eatHaveDoneView.alpha = 1;
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *pwd = [userDefaults objectForKey:@"pwd"];
            NSString *tel = [userDefaults objectForKey:@"tel"];
            NSDictionary *dict = @{@"tel":tel,@"pwd":pwd,@"status":@"4",@"type":@"guest"};
            DisplayView *displayView = [[DisplayView alloc] init];
            [displayView displayShowLoading:_eatHaveDoneView];
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
                [_eatHaveDoneView updateViewWith:content];
            }];

        }
            break;
        default:
            break;
    }

}
@end
