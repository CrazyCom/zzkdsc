//
//  Common.h
//  ManageEverything
//
//  Created by zz on 15/6/5.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <Foundation/Foundation.h>

#define user_islogin @"user_islogin"


@interface Common : NSObject

#define IsIOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7


//用户信息
+ (id)getUserInfo;
+ (id)getAccountANDpasswd;

//记录用户登录状态
+ (void)loginRecord;
+(void)saveUserInfo:(id)user;

//是否登录成功
+(BOOL)isHadLogin;

//退出账户
+ (void)loginOut;

//md5加密
+(NSString *)md5HexDigest:(NSString *)inPutText;
//32位加密
+ (NSString *)md5_32:(NSString *)str;

//获取用户Token
+(NSString *)getUserToken;
;

//计算字符串长度
+ (int)textLength:(NSString *)text;

/**
 * 给视图打星星评分 ->加星星的逻辑 只适合加5个星星
 */
+ (void)screNumber:(NSString *)score view:(UIView *)view tag:(int)tag;



//比较时间戳,当前时间比传入时间早，则返回YES,否则返回NO
+ (BOOL)compareNowDateWithSendDate:(NSDate *)sendDate ;

+ (BOOL)compareNowDateWithSendString:(NSString *)sendString;


//获取根控件
+ (UIViewController *)RootViewController;

+ (UINavigationController *)appRootViewController;

+ (UIImage *)scalImageOrientaiton:(UIImageOrientation)UIImageOrientation scalName:(NSString *)imageName;
@end
