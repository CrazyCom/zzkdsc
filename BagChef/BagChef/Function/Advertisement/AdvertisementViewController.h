//
//  AdvertisementViewController.h
//  Bazaar
//
//  Created by zz on 15/7/3.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvertisementViewController : UIViewController {
    
    @public NSInteger _currentIndex;
}

@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,copy) NSMutableArray *dataSource;
@property (nonatomic,copy) void(^gesture)();

- (void)setData:(NSMutableArray *)dataSource;
+(instancetype)advertisementViewController:(void(^)())block;

@end
