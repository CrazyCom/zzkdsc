//
//  AdvertisementViewController.m
//  Bazaar
//
//  Created by zz on 15/7/3.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "AdvertisementViewController.h"

@interface AdvertisementViewController ()<UIScrollViewDelegate> {
    
    UIView *adView; //展示广告
    UIScrollView *adScrollView; //滑动广告
    UIPageControl *pageControl;
    NSTimer *_timer;
}

- (void)initializeInterface;

//获取实际图片展示索引
- (NSInteger)realIndexWithIndex:(NSInteger)index;

@end

@implementation AdvertisementViewController

+(instancetype)advertisementViewController:(void (^)())block {
    
    AdvertisementViewController *adVC = [[AdvertisementViewController alloc]init];
    adVC.scrollView.clipsToBounds = YES;
    [adVC->adView addSubview:adVC.scrollView];
    adVC.scrollView.contentSize = adVC.scrollView.frame.size;
    adVC.scrollView.delegate = adVC;
    adVC.scrollView.showsHorizontalScrollIndicator = NO;
    adVC.scrollView.showsVerticalScrollIndicator = NO;
    adVC.gesture = block;
    
    return adVC;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeInterface];
}



- (void)initializeInterface {
    
    adView = [[UIView alloc]init];
    adView.backgroundColor = [UIColor clearColor];
    [adView setFrame:CGRectMake(0, 0, ScreenWidth, 110)];
    
    //广告图
    adScrollView = [[UIScrollView alloc]init];
    [adScrollView setFrame:CGRectMake(0, 0, ScreenWidth, 160)];
    adScrollView.pagingEnabled = YES;
    [adScrollView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"home_ad_bg"]]];
    adScrollView.delegate = self;
    [adScrollView setShowsHorizontalScrollIndicator:NO];
    [adView addSubview:adScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
