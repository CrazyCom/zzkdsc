//
//  Common.m
//  ManageEverything
//
//  Created by zz on 15/6/5.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "Common.h"
#import "CommonCrypto/CommonDigest.h"
#import "AppDelegate.h"
#import "DefaultViewController.h"
@implementation Common



//md5加密
+(NSString *)md5HexDigest:(NSString *) inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (double)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}
//32位加密
+ (NSString *)md5_32:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5( cStr,  (CC_LONG)strlen(cStr), result );
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];//
    
    for(int i = 0; i<16; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
    
    
}

//记录用户登录状态

+ (void)loginRecord {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES  forKey:KEY_ISLOGIN];
    
}


//是否登录成功
+(BOOL)isHadLogin
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL islogin = [defaults boolForKey:KEY_ISLOGIN];
    
    if (![defaults boolForKey:KEY_ISLOGIN]) {
        return NO;
    }else{
        return YES;
    }
}

//退出账户
+ (void)loginOut {
    
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:KEY_ISLOGIN];
//    [[NSUserDefaults standardUserDefaults]]
    [[NSUserDefaults standardUserDefaults] synchronize];
//    DefaultViewController *dvc = (DefaultViewController *)[UIApplication sharedApplication].delegate;
    
//    UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    UINavigationController *nav = (UINavigationController *)tab.viewControllers[1];
//    [nav popViewControllerAnimated:YES];
    
//    dvc.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    
    //    NSArray *navs = appDelegate.tab.viewControllers;
//    for (UINavigationController *nav in appDelegate.tab.viewControllers) {
//        [nav popToRootViewControllerAnimated:YES];
//    }
    
    

}

//保存用户信息
+(void)saveUserInfo:(id)user
{
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
   
    NSUserDefaults *mdef = [NSUserDefaults standardUserDefaults];
    [mdef setObject:user forKey:KEY_USER_Info];
    [mdef synchronize];
    
    
    
}

//获取用户信息
+(id)getUserInfo {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dict = [userDefaults objectForKey:KEY_USER_Info];
    return dict;
}

//计算字符串长度
+ (int)textLength:(NSString *)text
{
    float number = 0.0;
    for (int index = 0; index < [text length]; index++)
    {
        NSString *character = [text substringWithRange:NSMakeRange(index, 1)];
        
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3)
        {
            number++;
        }
        else
        {
            //限制 中英文都是相同位数
            number++;
        }
    }
    return ceil(number);
}

//+ (UINavigationController *)appRootViewController
//{
//    //xmmm
//    //    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
//    UIViewController *appRootVC = [AppDelegate App].viewController;
//    UIViewController *topVC = appRootVC;
//    while (topVC.presentedViewController) {
//        topVC = topVC.presentedViewController;
//    }
//    UINavigationController *nav = topVC.childViewControllers[0];
//    return nav;
//}


//
+ (UIImage *)scalImageOrientaiton:(UIImageOrientation)UIImageOrientation scalName:(NSString *)imageName {
    
    UIImage * image = [UIImage imageNamed:imageName];
    NSData * tempData;
    if (UIImagePNGRepresentation(image)) {
        tempData = UIImagePNGRepresentation(image);
        NSLog(@"%@",tempData);
    }
    else{
        tempData = UIImageJPEGRepresentation(image, 1);
    }
    CIImage * iImg = [CIImage imageWithData:tempData];
    UIImage * tImg = [UIImage imageWithCIImage:iImg scale:1 orientation:UIImageOrientation];
    return tImg;
    
}

//获取根控件
+ (UIViewController *)RootViewController {
    //xmmm
    //    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *appRootVC = [AppDelegate app].viewController;
    
//    UIViewController *topVC = appRootVC;
//    while (topVC.presentedViewController) {
//        topVC = topVC.presentedViewController;
//    }
    return appRootVC;
}

+ (UINavigationController *)appRootViewController
{
    //xmmm
    //    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *appRootVC = [AppDelegate app].viewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    UINavigationController *nav = topVC.childViewControllers[0];
    return nav;
}

//----------------------加星星逻辑---------------------------
+ (void)screNumber:(NSString *)score view:(UIView *)view tag:(int)tag {
    
    BOOL yes = [score containsString:@"."];
    int intNum = [score intValue];
    for (int i = 0; i < intNum; i ++) {
        UIImageView *starImageView = (UIImageView *)[view viewWithTag:tag + i];
        starImageView.image = [UIImage imageNamed:@"star"];
    }
    if (yes) {
        UIImageView *starImageView = (UIImageView *)[view viewWithTag:tag + intNum ];
        starImageView.image = [UIImage imageNamed:@"tb7_1"];
    }
    
}

+ (BOOL)compareNowDateWithSendDate:(NSDate *)sendDate {
    
    //获取当前时间
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *nowString = [formatter stringFromDate:nowDate];
    NSDate *dateNow = [formatter dateFromString:nowString];
    
    NSString *sendString = [formatter stringFromDate:sendDate];
    NSDate *dateSend = [formatter dateFromString:sendString];
    
    NSComparisonResult result = [dateNow compare:dateSend];
    if (result == NSOrderedAscending) {
        
        return YES;
    }
    else {
        
        return NO;
    }

}

+ (BOOL)compareNowDateWithSendString:(NSString *)sendString {
    
    //获取当前时间
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *nowString = [formatter stringFromDate:nowDate];
    NSDate *dateNow = [formatter dateFromString:nowString];
    
//    NSString *sendString = [formatter stringFromDate:sendDate];
    NSDate *dateSend = [formatter dateFromString:sendString];
    
    NSComparisonResult result = [dateNow compare:dateSend];
    if (result == NSOrderedAscending) {
        
        return YES;
    }
    else {
        
        return NO;
    }
    
}



@end
