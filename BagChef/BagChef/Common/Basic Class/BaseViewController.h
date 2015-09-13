//
//  BaseViewController.h
//  BagChef
//
//  Created by zhangzhi on 15/7/28.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UINavigationControllerDelegate>


@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

//右边第一个按键
@property (nonatomic, strong) UIButton *rightButton1;

// Title Label
@property (nonatomic, strong) UILabel *titleLabel;


// leftButtonImage 赋值为 nil 时，隐藏left按钮
// leftButtonImage 赋值非 nil 时，设置left按钮
- (void)setLeftButtonImage:(UIImage *)leftButtonImage;

// rightButtonImage 赋值为 nil 时，隐藏right按钮，默认隐藏right按钮
// rightButtonImage 赋值非 nil 时，设置right按钮
- (void)setRightButtonImage:(UIImage *)rightButtonImage;

//设置左按钮
-(void)setLeftButtonView:(UIView*)lv;

-(void)setLeftMenuButtonWithVertical:(BOOL)b;

//设置左按钮
-(void)setLeftButton:(UIImage*)backgroundImage btnText:(NSString*)btnText;
//设置右按钮
-(void)setRightButtonView:(UIView*)rv;

//设置右按钮
-(void)setRightButton:(UIImage*)backgroundImage btnText:(NSString*)btnText;

-(void)setRightButton1:(UIImage *)backgroundImage1 withRightButton2:(UIImage *)backgroundImage2;

// 通过override改方法，来修改right/left按钮的点击行为
//- (void)rightBtnClick:(id)sender;
- (void)leftButtonClick:(id)sender;

-(void)LeftMenuBt;


//添加Activity加载效果
-(void)showLoadingActivityViewWithString:(NSString *)titleString;

//取消activity效果
-(void)hideLoadingActivityView;
- (void)hideLoadingActivityViewText:(NSString *)text;


@end
