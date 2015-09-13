//
//  DefautViewController.h
//  BagChef
//
//  Created by zhangzhi on 15/7/29.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "ZTabBarController.h"
@interface DefaultViewController : UIViewController {
    
   
}

@property (nonatomic , strong)  ZTabBarController *ztabBarController;

@property (nonatomic , strong) UINavigationController *mainNavController;


- (void)addOrRemoveTapGesture:(BOOL)addOrRemove;
- (void)leftMenu;
@end
