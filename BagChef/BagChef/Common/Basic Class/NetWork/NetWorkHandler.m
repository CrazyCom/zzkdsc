//
//  NetWorkHandler.m
//  ConvenienceLife
//
//  Created by zz on 15/5/27.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "NetWorkHandler.h"
#import "AFNetworking.h"

@implementation NetWorkHandler

+ (void)requestPostDict:(NSDictionary *)dict url:(NSString *)url completeHandler:(CompleteHandler)completeHandler {
    
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseUrl,url];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //Server那邊的人有可能沒把head內的 meta的content格式指定好 完整的head
//    manager.requestSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",nil];
    
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//     [manager.requestSerializer setValue:@"MDAwMDAwMDAwMH292Wd-h62bg5mibw" forHTTPHeaderField:@"people_id"];
    
    
    if ([Common getUserInfo] && [[Common getUserInfo] isKindOfClass:[NSDictionary class]] && ((NSDictionary *)[Common getUserInfo]).count > 0) {
        NSString *string = [[NSString stringWithFormat:@"%@",[Common getUserInfo][@"people_id"]] mutableCopy];
        [manager.requestSerializer setValue:string forHTTPHeaderField:@"people_id"];
    }
    
    
    [manager POST:URL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completeHandler(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        completeHandler(error);
        NSLog(@"Error:%@",error);
        NSLog(@"operation:%@",operation.responseString);
    }];
}

+ (void)requestPostDict:(NSDictionary *)dict url:(NSString *)url constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block completeHandler:(CompleteHandler)completeHandler {

    
    NSString *URL = [NSString stringWithFormat:@"%@%@",BaseUrl,url];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",nil];
    
    
    if ([Common getUserInfo] && [[Common getUserInfo] isKindOfClass:[NSDictionary class]] && ((NSDictionary *)[Common getUserInfo]).count > 0) {
        NSString *string = [[NSString stringWithFormat:@"%@",[Common getUserInfo][@"people_id"]] mutableCopy];
        [manager.requestSerializer setValue:string forHTTPHeaderField:@"people_id"];
    }
    
    [manager POST:URL parameters:dict constructingBodyWithBlock:block success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completeHandler) {
            completeHandler(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error:%@",error);
        NSLog(@"operation:%@",operation.responseString);
    }];
    
}

+ (void)requestPostDict1:(NSDictionary *)dict url:(NSString *)url completeHandler:(CompleteHandler)completeHandler {
    
    NSString *URL = [NSString stringWithFormat:@"%@",url];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",nil];
    
    if ([Common getUserInfo] && [[Common getUserInfo] isKindOfClass:[NSDictionary class]] && ((NSDictionary *)[Common getUserInfo]).count > 0) {
        NSString *string = [[NSString stringWithFormat:@"%@",[Common getUserInfo][@"people_id"]] mutableCopy];
        [manager.requestSerializer setValue:string forHTTPHeaderField:@"people_id"];
    }
    
    
    [manager POST:URL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completeHandler(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error:%@",error);
        NSLog(@"operation:%@",operation.responseString);
    }];
}



//+ (void)serviceImageWithMothedName:(NSString *)mothedName params:(NSDictionary *)params imageDatas:(NSArray *)imageDatas name:(NSArray *)name fileNames:(NSArray *)fileNames mimeType:(NSString *)mimeType succeed:(void (^)(id response))successBlock fail:(void (^)(void))failBlock
//{
//    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",nil];
//    
//    AFHTTPRequestOperation *operation = [manager POST:[NSString stringWithFormat:@"%@%@",BaseUrl,mothedName] parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        if (imageDatas.count ==0) {
//            return ;
//        }
//        for (int i = 0; i < imageDatas.count; i ++) {
//            [formData appendPartWithFileData:imageDatas[i] name:name[i] fileName:fileNames[i] mimeType:mimeType];
//        }
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        successBlock(responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"responseString == %@",operation.responseString);
//        
////        //失败的返回
////        [RequestData reachability:error];
////        failBlock();
//    }];
//    //获得上传进度
//    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//        NSLog(@"上传进度:%f",totalBytesWritten*1.0/totalBytesExpectedToWrite);
//    }];
//
//}

#pragma mark - 登录，注册，修改,验证码
//登录

+ (void)loginParams:(NSDictionary *)params completionHandler:(CompleteHandler)completion {
    
    [self requestPostDict:params url:Url_login completeHandler:completion];
}

//注册
+ (void)registerVipParams:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_register completeHandler:completion];
}


//修改密码
+ (void)changePasswdParams:(NSDictionary *)params completionHandler:(void (^)(id))completion {
    
    
}

//验证码——忘记密码
+ (void)forgetPasswdSmsCheckTwoParams:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_smsCheckTwo completeHandler:completion];
}

//忘记密码
+ (void)forgetPasswdParams:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_saveUserPassword completeHandler:completion];
}

//获取用户资料
+ (void)getUserInfoParams:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_getUserInfo completeHandler:completion];
}

//修改用户资料
+ (void)modifyUserInfoParams:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block completionHandler:(void (^)(id))completion {
    
    [self requestPostDict:params url:Url_saveUserInfo constructingBodyWithBlock:block completeHandler:completion];
}


//短信验证码
+ (void)getSmsCheckParams:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_smsCheck completeHandler:completion];
}

//检验验证码
+ (void)checkSmsCheckParams:(NSDictionary *)params completionHandler:(void (^) (id content))completion{
    [self requestPostDict:params url:Url_checkSms completeHandler:completion];
}

//我的银子
+ (void)checkCash:(NSDictionary *)params completionHandler:(void (^)(id))completion {
    
    [self requestPostDict:params url:Url_checkCash completeHandler:completion];

}

//投诉建议
+ (void)addFeedback:(NSDictionary *)params completionHandler:(void (^) (id content))completion {

    [self requestPostDict:params url:Url_addFeedback completeHandler:completion];
}

#pragma mark - 厨师接口类

//申请加入厨师
+ (void)joinedChef:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block completionHandler:(void (^)(id))completion {
    
    
    [self requestPostDict:params url:Url_joinedChef constructingBodyWithBlock:block completeHandler:completion];
}

//添加菜品
+ (void)addDish:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block completionHandler:(void (^)(id))completion {
    
    
    [self requestPostDict:params url:Url_addDish constructingBodyWithBlock:block completeHandler:completion];
}

//修改菜品
+ (void)saveDish:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_saveDish completeHandler:completion];
}

//私厨数量
+ (void)countOfChef:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_countOfChef completeHandler:completion];
}

//推荐的菜品
+ (void)topDish:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_topDish completeHandler:completion];
}

//推荐菜品&取消推荐
+ (void)setTopDish:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_setTopDish completeHandler:completion];
}

//厨师上传菜品列表
+ (void)dishList:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_dishList completeHandler:completion];
}

//厨师主页
+ (void)chefIndex:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_chefIndex completeHandler:completion];
}

//厨师接单
+ (void)pickByChef:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_pickByChef completeHandler:completion];
}

//厨师拒单
+ (void)notPickByChef:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_notPickByChef completeHandler:completion];
}

//厨师交付镖师
+ (void)chefSendExpress:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_chefSendExpress completeHandler:completion];
}

//删除菜品
+ (void)delDish:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_delDish completeHandler:completion];
}


#pragma mark - 镖师接口类

//申请加入镖师
+(void) joinedExpress:(NSDictionary *)params constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_joinedExpress constructingBodyWithBlock:block completeHandler:completion];
}

//镖师开始送镖
+ (void) expressSendGuest:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_expressSendGuest completeHandler:completion];
}

//镖师接单
+ (void) pickByExpress:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_pickByExpress completeHandler:completion];
}

//获取上传坐标频率
+ (void) getCoordUptime:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_getCoordUptime completeHandler:completion];
}

//上传镖师坐标
+ (void) updateExpressCoord:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_updateExpressCoord completeHandler:completion];
}

//接镖列表
+ (void) expressOrderList:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_expressOrderList completeHandler:completion];
}



#pragma mark - 吃货接口类 ApiGuest
//厨师列表
+ (void)getChefList:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_getChefList completeHandler:completion];
}

//菜品详情
+ (void)getDishInfo:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_getDishInfo completeHandler:completion];
}

//获取菜品评论
+ (void)getDishComment:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_getDishComment completeHandler:completion];
}

//吃货收藏菜品列表
+ (void)guestDishCollection:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_guestDishCollection completeHandler:completion];
}

//吃货收藏厨师列表
+ (void)guestChefCollection:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_guestChefCollection completeHandler:completion];
}

//收藏菜品或私厨&取消收藏
+ (void)manageCollection:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_manageCollection completeHandler:completion];
}

//支出明细
+ (void)payDetailList:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_payDetailList completeHandler:completion];
}

//收到订单
+ (void)receivedOrders:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_receivedOrders completeHandler:completion];
}

#pragma mark - 订单接口类

//订单列表
+ (void)orderList:(NSDictionary *)params completionHandler:(void (^) (id content))completion{
    [self requestPostDict:params url:Url_orderList completeHandler:completion];
}

//订单详情
+ (void)detailsOfOrder:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    [self requestPostDict:params url:Url_detailsOfOrder completeHandler:completion];
}

//计算单个菜品价格
+ (void)getDishPrice:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    [self requestPostDict:params url:Url_getDishPrice completeHandler:completion];
}

//计算菜品运费
+ (void)getDishFreight:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    [self requestPostDict:params url:Url_getDishFreight completeHandler:completion];
}

//添加订单
+ (void)addOrder:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    [self requestPostDict:params url:Url_addOrder completeHandler:completion];
}

//评价订单
+ (void)commentOrder:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    [self requestPostDict:params url:Url_commentOrder completeHandler:completion];
}

//获取镖师坐标
+ (void)getExpressCoordinate:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict:params url:Url_getExpressCoordinate completeHandler:completion];
}


////baidu
//+ (void)getAdressWithParams:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
//    [self requestPostDict:params url:Url_getAdressWithParams completeHandler:completion];
//}
//
//baidu
+ (void)getAdressWithParams:(NSDictionary *)params completionHandler:(void (^) (id content))completion {
    
    [self requestPostDict1:params url:Url_baidu completeHandler:completion];
}



@end

