//
//  AdvertisementView.m
//  Bazaar
//
//  Created by zz on 15/7/3.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "AdvertisementView.h"

@interface AdvertisementView () {
    
    NSTimer *_timer;
}

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIView *adView;
@property (nonatomic,strong) UIPageControl *pageControl;

//获取实际图片展示索引
- (NSInteger)realIndexWithIndex:(NSInteger)index;

@end

@implementation AdvertisementView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
