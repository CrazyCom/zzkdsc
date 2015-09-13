//
//  ZAdvertisementView.h
//  Bazaar
//
//  Created by zz on 15/7/21.
//  Copyright (c) 2015年 zz. All rights reserved.
//

@class ZAdvertisementView;

@protocol ZAdvertisementViewDelegate <NSObject>

- (void)clickAdView:(ZAdvertisementView *)zAdvertisementView atIndex:(NSInteger)index;
- (void)showAdView:(ZAdvertisementView *)zAdvertisementView;
- (void)hideAdView:(ZAdvertisementView *)zAdvertisementView;

@end

#import <UIKit/UIKit.h>

@interface ZAdvertisementView : UIView

@property (nonatomic,strong) NSArray *adArray;
@property (nonatomic,assign) id<ZAdvertisementViewDelegate> delegate;
- (void)requestAdViewData;
@end
