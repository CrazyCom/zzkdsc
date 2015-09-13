//
//  ZNavigationViewController.h
//  Bazaar
//
//  Created by zz on 15/7/2.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZNavigationViewController : UIViewController

@property (nonatomic,strong) UILabel *titleLabel; // title Label

//左边按钮
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *leftButton1;

//右边按钮
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UIButton *rightButton1;

//设置左按钮，为nil时隐藏
- (void)setLeftButtonImage:(UIImage *)leftButtonImage;
- (void)setLeftButtonView:(UIView *)leftView;
- (void)setLeftButton:(UIImage *)backgroundImage btnText:(NSString *)btnText;

//设置右按钮，为nil时隐藏
- (void)setRightButtonImage:(UIImage *)rightButtonImage;
- (void)setRightButtonView:(UIView *)rightView;
- (void)setRightButton:(UIImage *)backgroundImage btnText:(NSString *)btnText;

//设置是否可以左右滑动
- (void)setLeftMenuButtonCanVertical:(BOOL)b;
- (void)setRightMenuButtonCanVertical:(BOOL)b;

- (void)leftMenuBtn;
- (void)rightMenuBtn;

//通过override方法，修改right/left按钮的点击行为
- (void)leftButtonClick:(id)sender;
- (void)rightButtonClick:(id)sender;


//添加Activity加载效果
- (void)showLoadingActivityViewWithString:(NSString *)textString;

//取消Activity效果
- (void)hideLoadingActivityView;
- (void)hideLoadingActivityViewWithString:(NSString *)textString;

@end
