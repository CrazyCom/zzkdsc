//
//  ADLoopView.h
//  MaiokStore
//
//  Created by maiok on 15/7/15.
//  Copyright (c) 2015年 maiok. All rights reserved.
//

/**
 *  网络图片 ...exp
 CGFloat width = [UIScreen mainScreen].bounds.size.width;
 
 NSArray *imagesURL = @[
 @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
 @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
 @"http://www.5858baypgs.com/img/aHR0cDovL3BpYzE4Lm5pcGljLmNvbS8yMDEyMDEwNS8xMDkyOTU0XzA5MzE1MTMzOTExNF8yLmpwZw==.jpg"
 ];
 
 // 图片配文字(可选)
 NSArray *titles = @[@"感谢您的支持，如果下载的",
 @"代码在使用过程中出现问题",
 @"您可以发邮件到qzycoder@163.com",
 ];
 
 //如果你的这个广告视图是添加到导航控制器子控制器的View上,请添加此句,否则可忽略此句
 self.automaticallyAdjustsScrollViewInsets = NO;
 
 adView = [AdView adScrollViewWithFrame:CGRectMake(0, 64, width, 172)  \
 imageLinkURL:imagesURL\
 placeHoderImageName:@"placeHoder.jpg" \
 pageControlShowStyle:UIPageControlShowStyleLeft];
 
 //    是否需要支持定时循环滚动，默认为YES
 //    adView.isNeedCycleRoll = YES;
 
 [adView setAdTitleArray:titles withShowStyle:AdTitleShowStyleRight];
 //    设置图片滚动时间,默认3s
 //    adView.adMoveTime = 2.0;
 
 //图片被点击后回调的方法
 adView.callBack = ^(NSInteger index,NSString * imageURL)
 {
 NSLog(@"被点中图片的索引:%ld---地址:%@",index,imageURL);
 };
 [self.view addSubview:adView];
 
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UIPageControlShowStyle)
{
    /**
     *  @author DQ, 15-07-15
     *
     *  不显示PageControl
     */
    UIPageControlShowStyleNone,//default
    UIPageControlShowStyleLeft,
    UIPageControlShowStyleCenter,
    UIPageControlShowStyleRight,
};

typedef NS_ENUM(NSUInteger, AdTitleShowStyle)
{
    /**
     *  @author DQ, 15-07-15
     *
     *  不显示标题
     */
    AdTitleShowStyleNone,
    AdTitleShowStyleLeft,
    AdTitleShowStyleCenter,
    AdTitleShowStyleRight,
};

@interface ADLoopView : UIView <UIScrollViewDelegate>
{
    UILabel * _centerAdLabel;
    CGFloat _adMoveTime;
}

/*
 可以在adScrollView上添加一些不随广告滚动的控件
 */
@property (retain,nonatomic,readonly) UIScrollView * adScrollView;
@property (retain,nonatomic,readonly) UIPageControl * pageControl;
@property (retain,nonatomic,readonly) NSArray * imageLinkURL; //图片 url str
@property (retain,nonatomic,readonly) NSArray * adTitleArray; //文字 内容
/**
 *  @author DQ, 15-07-15
 *
 *  设置page显示位置
 */
@property (assign,nonatomic) UIPageControlShowStyle  PageControlShowStyle;
/**
 *  @author DQ, 15-07-15
 *
 *  设置标题对应的位置
 */
@property (assign,nonatomic,readonly) AdTitleShowStyle  adTitleStyle;

/**
 *  @author DQ, 15-07-15
 *
 *  设置占位图片
 */
@property (nonatomic,strong) UIImage * placeHoldImage;

/**
 *  @author DQ, 15-07-15
 *
 *  是否需要定时循环滚动
 */
@property (nonatomic,assign) BOOL isNeedCycleRoll;

/**
 *  @author DQ, 15-07-15
 *
 *  @brief  图片移动计时器
 */
@property (nonatomic,assign) CGFloat  adMoveTime;
/**
 *  @author DQ, 15-07-15
 *
 *  @brief  在这里修改Label的一些属性
 */
@property (nonatomic,strong,readonly) UILabel * centerAdLabel;

/**
 *  @author DQ, 15-07-15
 *
 *  @brief  给图片创建点击后的回调方法
 */
@property (nonatomic,strong) void (^callBack)(NSInteger index,NSString * imageURL);

/**
 *  @author DQ, 15-07-15
 *
 *  @brief  设置每个图片下方的标题
 *
 *  @param adTitleArray 标题数组
 *  @param adTitleStyle 标题显示风格
 */
- (void)setAdTitleArray:(NSArray *)adTitleArray withShowStyle:(AdTitleShowStyle)adTitleStyle;

/**
 *  @author DQ, 15-07-15
 *
 *  @brief  创建ADLoopView对象
 *
 *  @param frame                设置Frame
 *  @param imageLinkURL         图片链接地址数组,数组的每一项均为字符串
 *  @param imageName            占位图片
 *  @param PageControlShowStyle PageControl显示位置
 *  @param object 控件在那个类文件中
 *  @return 广告视图
 */
+ (id)adScrollViewWithFrame:(CGRect)frame imageLinkURL:(NSArray *)imageLinkURL placeHoderImageName:(NSString *)imageName pageControlShowStyle:(UIPageControlShowStyle)PageControlShowStyle;

/**
 *  @author DQ, 15-07-15
 *
 *  @brief  创建ADLoopView对象
 *
 *  @param frame                设置Frame
 *  @param imageLinkURL         本地图片名称数组
 *  @param PageControlShowStyle PageControl显示位置
 *  @param object 控件在那个类文件中
 *  @return 广告视图
 */
+ (id)adScrollViewWithFrame:(CGRect)frame localImageLinkURL:(NSArray *)imageLinkURL pageControlShowStyle:(UIPageControlShowStyle)PageControlShowStyle;

@end
