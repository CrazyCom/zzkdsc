//
//  DisplayView.h
//  BagChef
//
//  Created by zhangzhi on 15/8/19.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayView : UIView

+ (void)displayNetRequestShowWithTitle:(NSString *)title ;
+ (void)displayShowWithTitle:(NSString *)title;
+ (void)hideTitle;

- (void)displayShowLoading:(UIView *)view ;
- (void)displayHideLoading;
@end
