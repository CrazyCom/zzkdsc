//
//  ADScrollView.h
//  MaiokStore
//
//  Created by maiok on 15/9/17.
//  Copyright (c) 2015年 maiok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADScrollView : UIView {

    NSInteger _currentIndex;
}
/**
 *  @author DQ, 15-07-15
 *
 *  是否需要定时循环滚动
 */
@property (nonatomic,assign) BOOL isNeedCycleRoll;

@property (nonatomic,copy)void (^gesturePress)();
@property (nonatomic,copy) NSMutableArray *dataSource; //配置数据源
///视图初始化方法
+ (instancetype)adScrollViewWithFrame:(CGRect)frame block:(void(^)())block;

@end
