//
//  NetWorkHandler.h
//  ConvenienceLife
//
//  Created by zz on 15/5/27.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompleteHandler) (id content);
@interface NetWorkHandler : NSObject

@property (nonatomic,copy) CompleteHandler completeHandle;

+ (void)requestPostDict:(NSDictionary *)dict url:(NSString *)url completeHandler:(CompleteHandler)completeHandler;

+ (void)requestPostDict:(NSDictionary *)dict
                          url:(NSString *)url
    constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
              completeHandler:(CompleteHandler)completeHandler;

//帐号登录
+ (void)loginParams:(NSDictionary *)params completionHandler:(CompleteHandler)completion;

//修改密码
+ (void)changePasswdParams:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//验证码——忘记密码
+ (void)forgetPasswdSmsCheckTwoParams:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//忘记密码
+ (void)forgetPasswdParams:(NSDictionary *)params completionHandler:(void (^) (id content))completion;;

//获取用户资料
+ (void)getUserInfoParams:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//修改用户资料
+ (void)modifyUserInfoParams:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block completionHandler:(void (^) (id content))completion;

//注册
+ (void)registerVipParams:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//短信验证码
+ (void)getSmsCheckParams:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//检验验证码
+ (void)checkSmsCheckParams:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//我的银子
+ (void)checkCash:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//投诉建议
+ (void)addFeedback:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

#pragma mark - 厨师接口类

//申请加入厨师
+ (void)joinedChef:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block completionHandler:(void (^) (id content))completion;

//添加菜品
+ (void)addDish:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block completionHandler:(void (^)(id))completion;
//修改菜品
+ (void)saveDish:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//私厨数量
+ (void)countOfChef:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//推荐的菜品
+ (void)topDish:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//推荐菜品&取消推荐
+ (void)setTopDish:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//厨师上传菜品列表
+ (void)dishList:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//厨师主页
+ (void)chefIndex:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//厨师接单
+ (void)pickByChef:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//厨师拒单
+ (void)notPickByChef:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//厨师交付镖师
+ (void)chefSendExpress:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//删除菜品
+ (void)delDish:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

#pragma mark - 镖师类接口

//申请加入镖师
+(void) joinedExpress:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block completionHandler:(void (^) (id content))completion;

//镖师开始送镖
+ (void) expressSendGuest:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//镖师接单
+ (void) pickByExpress:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//获取上传坐标频率
+ (void) getCoordUptime:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//上传镖师坐标
+ (void) updateExpressCoord:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//接镖列表
+ (void) expressOrderList:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

#pragma mark - 吃货接口类 ApiGuest
//厨师列表
+ (void)getChefList:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//菜品详情
+ (void)getDishInfo:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//获取菜品评论
+ (void)getDishComment:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//吃货收藏菜品列表
+ (void)guestDishCollection:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//吃货收藏厨师列表
+ (void)guestChefCollection:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//收藏菜品或私厨&取消收藏
+ (void)manageCollection:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//支出明细
+ (void)payDetailList:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//收到订单
+ (void)receivedOrders:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

#pragma mark - 订单接口类

//订单列表
+ (void)orderList:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//订单详情
+ (void)detailsOfOrder:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//计算单个菜品价格
+ (void)getDishPrice:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//计算菜品运费
+ (void)getDishFreight:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//添加订单
+ (void)addOrder:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//评价订单
+ (void)commentOrder:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//获取镖师坐标
+ (void)getExpressCoordinate:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

//

//baidu
+ (void)getAdressWithParams:(NSDictionary *)params completionHandler:(void (^) (id content))completion;

@end
