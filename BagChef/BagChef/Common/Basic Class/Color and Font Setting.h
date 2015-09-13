//
//  Color and Font Setting.h
//  Bazaar
//
//  Created by zz on 15/7/2.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#ifndef Bazaar_Color_and_Font_Setting_h
#define Bazaar_Color_and_Font_Setting_h


#endif

// 颜色16进制转换
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


//定义字体
#define FONT_BEBASNEUE(fontsize) [UIFont fontWithName:@"BebasNeue" size:fontsize];