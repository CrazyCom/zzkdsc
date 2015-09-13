//
//  DisplayView.m
//  BagChef
//
//  Created by zhangzhi on 15/8/19.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "DisplayView.h"

static DisplayView *displayView = nil;


@interface DisplayView() <UIAlertViewDelegate>{
    
}

@end

@implementation DisplayView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        self.bounds = CGRectMake(0, 0, 200, 100);
        self.center = CGPointMake(ScreenWidth / 2.0, ScreenHeight / 2.0 - 64);
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.layer.cornerRadius = 10;
        
        UIActivityIndicatorView * indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        indicatorView.bounds = CGRectMake(0, 0, 20, 20);
        indicatorView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2 - 20);
        [indicatorView startAnimating];
        [self addSubview:indicatorView];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)displayShowWithTitle:(NSString *)title {
    
    UIViewController *viewController = [Common RootViewController];
    NSLog(@"%@",viewController);
    
    [displayView removeFromSuperview];
    displayView = [[DisplayView alloc]initWithFrame: CGRectMake(ScreenWidth/2 - 100, (ScreenHeight-64 - 100)/2, 200, 100)];
    displayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    displayView.layer.cornerRadius = 10;
    [viewController.view addSubview:displayView];
//    UIActivityIndicatorView * load = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(20, 40, 20, 20)];
//    [load startAnimating];
//    [view addSubview:load];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 180, 20)];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    [displayView addSubview:label];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [displayView removeFromSuperview];
    });
 }

- (void)displayNetRequestShowWithTitle:(NSString *)title {
    
    UIView * view = [[UIView alloc]initWithFrame: CGRectMake((ScreenWidth-200)/2, (ScreenHeight-64 - 100)/2, 200, 100)];
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    view.layer.cornerRadius = 10;
    [self addSubview:view];
    UIActivityIndicatorView * load = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(20, 40, 20, 20)];
    [load startAnimating];
    [view addSubview:load];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(60, 40, 140, 20)];
    label.text = title;
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    
    
}



+ (void)hideTitle {
    
    UIViewController *vc = [Common RootViewController];
//    [vc.view removeFromSuperview];
}


- (void)displayShowLoading:(UIView *)view {
    
    
    [view addSubview:self];
    
//    UIViewController *viewController = [Common RootViewController];
//    NSLog(@"%@",viewController);
    

    
//    [self.view bringSubviewToFront:_indicatorView];
//    [self.indicatorView startAnimating];
}


- (void)displayHideLoading{
    
    [self removeFromSuperview];
}


@end
