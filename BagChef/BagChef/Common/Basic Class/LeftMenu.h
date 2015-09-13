//
//  LeftMenu.h
//  Bazaar
//
//  Created by zz on 15/7/2.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SendTag)(NSUInteger index);

@class LeftMenu;

@protocol leftItemScrollViewDelegate <NSObject>
/**
 * @method categoryDidSelected:
 * @brief 点击栏目时回调方法
 * @param index : 点击的栏目索引
 **/
- (void)leftItermButtonDidSelected:(int)index repeat:(BOOL)b;



@end


@interface LeftMenu : UIView {
    
    UIImageView *bgView;
    
}

@property (nonatomic,assign) BOOL isLogin;
@property (nonatomic,assign) id<leftItemScrollViewDelegate>delegate;
@property (nonatomic,copy) SendTag send;



@end
