//
//  ConfigURL.h
//  ManageEverything
//
//  Created by zz on 15/6/2.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#ifndef ManageEverything_ConfigURL_h
#define ManageEverything_ConfigURL_h
#endif

//用户信息
#define KEY_USER_Info @"key_user_info"

//是否登录
#define KEY_ISLOGIN @"key_islogin"

//用户密码
#define KEY_USER_PWD @"key_user_pwd"


//服务器地址

#define BaseUrl @"http://kdsc.mmqo.com/index.php?s=/Admin"

//登录
#define Url_login @"/ApiUser/userLogin"

//注册
#define Url_register @"/ApiUser/getUserInfo"

//修改用户资料
#define Url_saveUserInfo @"/ApiUser/saveUserInfo"

//获取用户资料
#define Url_getUserInfo @"/ApiUser/getUserInfo"

//修改密码
#define Url_updateUserPassword @"/ApiUser/updateUserPassword"

//忘记密码
#define Url_saveUserPassword @"/ApiUser/saveUserPassword"

//投诉建议
#define Url_addFeedback @"/ApiUser/addFeedback"

//获取验证码
#define Url_smsCheck @"/ApiUser/smsCheck"

//检验验证码
#define Url_checkSms @"/ApiUser/userRegister"

//验证码——忘记密码
#define Url_smsCheckTwo @"/ApiUser/smsCheckTwo"

// 我的银子
#define Url_checkCash @"/ApiUser/checkCash"



#pragma mark - 厨师接口类

//申请加入厨师

#define Url_joinedChef @"/ApiChef/joinedChef"

//添加菜品

#define Url_addDish @"/ApiChef/addDish"

//修改菜品

#define Url_saveDish @"/ApiChef/saveDish"

//私厨数量

#define Url_countOfChef	@"/ApiChef/countOfChef"

//推荐的菜品

#define Url_topDish @"/ApiChef/topDish"

//推荐菜品&取消推荐

#define Url_setTopDish @"/ApiChef/setTopDish"

//厨师上传菜品列表

#define Url_dishList @"/ApiChef/dishList"

//厨师主页

#define Url_chefIndex @"/ApiChef/chefIndex"

//厨师接单

#define Url_pickByChef @"/ApiChef/pickByChef"

//厨师拒单

#define Url_notPickByChef @"/ApiChef/notPickByChef"

//厨师交付镖师

#define Url_chefSendExpress @"/ApiChef/chefSendExpress"

//删除菜品
#define Url_delDish @"/ApiChef/delDish"


#pragma mark - 镖师接口类
//申请加入镖师
#define Url_joinedExpress @"/ApiExpress/joinedExpress"

//镖师开始送镖
#define Url_expressSendGuest @"/ApiExpress/expressSendGuest"

//镖师接单
#define Url_pickByExpress @"/ApiExpress/pickByExpress"

//获取上传坐标频率
#define Url_getCoordUptime @"/ApiExpress/getCoordUptime"

//上传镖师坐标
#define Url_updateExpressCoord @"/ApiExpress/updateExpressCoord"

//接镖列表
#define Url_expressOrderList @"/ApiExpress/expressOrderList"

#pragma mark - 吃货接口类 ApiGuest

//厨师列表

#define Url_getChefList @"/ApiGuest/getChefList"

//菜品详情

#define Url_getDishInfo @"/ApiGuest/getDishInfo"

//获取菜品评论

#define Url_getDishComment @"/ApiGuest/getDishComment"

//吃货收藏菜品列表

#define Url_guestDishCollection	 @"/ApiGuest/guestDishCollection"

//吃货收藏厨师列表

#define Url_guestChefCollection @"/ApiGuest/guestChefCollection"

//收藏菜品或私厨&取消收藏

#define Url_manageCollection @"/ApiGuest/manageCollection"

//支出明细

#define Url_payDetailList @"/ApiGuest/payDetailList"

//收到订单

#define Url_receivedOrders @"/ApiGuest/receivedOrders"

#pragma mark - 订单接口类

//订单列表
#define Url_orderList @"/ApiOrder/orderList"

//订单详情
#define Url_detailsOfOrder @"/ApiOrder/detailsOfOrder"

//计算单个菜品价格
#define Url_getDishPrice @"/ApiOrder/getDishPrice"

//计算菜品运费
#define Url_getDishFreight @"/ApiOrder/getDishFreight"

//添加订单
#define Url_addOrder @"/ApiOrder/addOrder"

//评价订单
#define Url_commentOrder @"/ApiOrder/commentOrder"

//获取镖师坐标
#define Url_getExpressCoordinate @"/ApiOrder/getExpressCoordinate"

#define Url_baidu @"http://api.map.baidu.com/geocoder/v2/?"


