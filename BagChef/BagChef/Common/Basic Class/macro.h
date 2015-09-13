//
//  macro.h
//  Bazaar
//
//  Created by zz on 15/7/2.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#ifndef Bazaar_macro_h
#define Bazaar_macro_h


#endif


#define IOS7   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending)

#define VALID_STRING(str) ((str) && [str isKindOfClass:[NSString class]] && ([(str) length]>0))
#define VALID_ARRAY(arr) ((arr) && ([(arr) isKindOfClass:[NSArray class]]) && ([(arr) count]>0))
#define VALID_DICT(str) ((str) && [str isKindOfClass:[NSDictionary class]])