//
//  AdvertisementView.h
//  Bazaar
//
//  Created by zz on 15/7/3.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AdvertisementView;

@protocol AdvertisementView <NSObject>

- (void)clickAdView:(AdvertisementView *)adView atIndex:(int)index;
- (void)showAdView:(AdvertisementView *)adView;
- (void)hideAdView:(AdvertisementView *)adView;
@end


@interface AdvertisementView : UIView {
    
@public NSInteger _currentIndex;
    
}

@property (nonatomic,strong)NSMutableArray *dataArray;


- (void)setData:(NSMutableArray *)dataSource;
+(instancetype)advertisementView:(void(^)())block;
@end
