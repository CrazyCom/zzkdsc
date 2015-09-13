//
//  ZAdvertisementView.m
//  Bazaar
//
//  Created by zz on 15/7/21.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#define AdViewHeight 144
#import "ZAdvertisementView.h"

@interface ZAdvertisementView ()<UIScrollViewDelegate> {
    
    int index;
    UIImageView *topImageView;
    UIImageView *downImageView;
}

@end


@implementation ZAdvertisementView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        index = 0;
        
        [self addAdView];
    }
    return self;
}

//网络请求
- (void)requestAdViewData {
    
    
}


- (void)addAdView {
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    [scrollView setFrame:CGRectMake(0, 0, ScreenWidth, AdViewHeight)];
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setScrollEnabled:NO];
    [scrollView setDelegate:self];
    [self addSubview:scrollView];
    
    NSDictionary *dic = [self.adArray objectAtIndex:0];
    
    topImageView = [[UIImageView alloc]init];
    [topImageView setTag:0];
    [topImageView setFrame:CGRectMake(0, 0, ScreenWidth, AdViewHeight)];
    NSString *path = [dic objectForKey:@"path"];
    path = [NSString stringWithFormat:@"%@%@",@"http://gdk.seventc.com",path];
    [topImageView setImageWithURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"adImage1"]];
    [topImageView setUserInteractionEnabled:YES];
    
    //在广告图上添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAdView:)];
    [topImageView addGestureRecognizer:tap];
    
    
    index = 0;
    [scrollView addSubview:topImageView];
    
    if (self.adArray.count > 1) {
        dic = [self.adArray objectAtIndex:1];
        downImageView = [[UIImageView alloc] init];
        [downImageView setTag:1];
        [downImageView setFrame:CGRectMake(0, 0, ScreenWidth, AdViewHeight)];
        NSString *path = [dic objectForKey:@"path"];
        path = [NSString stringWithFormat:@"%@%@",@"http://gdk.seventc.com",path];
        [downImageView setImageWithURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"adImage1"]];
        [downImageView setUserInteractionEnabled:YES];
        
        //点击广告
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAdView:)];
        [downImageView addGestureRecognizer:tap];
        [scrollView addSubview:downImageView];
        index = 1;
        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(changeAdView) userInfo:nil repeats:YES];
    }
    
    if ([_delegate respondsToSelector:@selector(showAdView:)]) {
       
        //展示广告
        [self.delegate showAdView:self];

    }
    //切换广告


}

- (void)clickAdView:(UITapGestureRecognizer *)gesture {
    
    UIImageView *imageView = (UIImageView *)gesture.view;
    [self.delegate clickAdView:self atIndex:imageView.tag];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.delegate clickAdView:self atIndex:0];
}

//删除广告
- (void)clickHideAdView {
    
    [self.delegate hideAdView:self];
}

//切换广告
- (void)changeAdView {
    
    index = index + 1;
    if (index == self.adArray.count) {
        index = 0;
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSLog(@"----");
}

@end
