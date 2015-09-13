//
//  Model.h
//  BagChef
//
//  Created by zhangzhi on 15/8/24.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject


/**
 *  json转model
 *
 *  @param param json字典
 *
 *  @return 对象模型
 */
- (id)initWithDictionaryParams:(NSDictionary *)param;

/**
 *  model转json
 *
 *  @return 当前model的字典
 */
- (NSDictionary *)getDictionary;

/**
 *  初始化model
 *
 *  @param param json字典
 */
- (void)initModelWith:(NSDictionary *)param;

/**
 *  model深复制
 *
 *  @param objc model
 *
 *  @return model的deepCopy
 */
+ (id)deepCopy:(Model *)objc;

- (id)initWithDicitonary:(NSDictionary *)dictionary;
// 转为服务器接收的字典
- (NSDictionary *)serverNeededDictionary;
// 获取属性列表
- (NSMutableArray *)properties;
+ (NSMutableArray *)properties;
// 计算完整自身对象数据完整度
- (float)integrity;
// 返回自身对象所有数据的数组集合
- (NSMutableArray *)valueForProperties;

@end

#pragma mark - HadUploadMenuModel

@interface HadUploadMenuModel : Model

@property (nonatomic , strong) NSString *ID;
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSArray *pic;
@property (nonatomic , strong) NSString *price;
@property (nonatomic , strong) NSString *sale_num;
@property (nonatomic , strong) NSString *sell_time_end;
@property (nonatomic , strong) NSString *sell_time_start;
@property (nonatomic , strong) NSString *surplus_num;

@property (nonatomic , strong) NSString *top;
@end

#pragma mark - HomePageModel
@interface HomePageModel : Model


@property (nonatomic , strong) NSString *ID;
@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSArray *pic;
@property (nonatomic , strong) NSString *price;
@property (nonatomic , strong) NSString *sale_num;
@property (nonatomic , strong) NSString *sell_time_end;
@property (nonatomic , strong) NSString *sell_time_start;
@property (nonatomic , strong) NSString *surplus_num;
@property (nonatomic , strong) NSString *top;
@end

#pragma mark - GourmetViewModel

@interface GourmetViewModel :Model

@property (nonatomic , strong) NSString *address;
@property (nonatomic , strong) NSString *age;
@property (nonatomic , strong) NSString *card;
@property (nonatomic , strong) NSString *icon;
@property (nonatomic , strong) NSString *lat;
@property (nonatomic , strong) NSString *lon;
@property (nonatomic , strong) NSString *nicename;
@property (nonatomic , strong) NSString *other;
@property (nonatomic , strong) NSString *sale_num;
@property (nonatomic , strong) NSString *score;
@property (nonatomic , strong) NSArray *top;
@property (nonatomic , strong) NSString *uid;

@end

#pragma mark - MenuListCellOfModel

@interface MenuListCellOfModel :Model

@property (nonatomic , strong) NSDictionary *chef;
@property (nonatomic , strong) NSString *comment;
@property (nonatomic , strong) NSDictionary *dish;



@end

#pragma mark - SendBeSendingViewModel

@interface SendBeSendingViewModel:Model

@property (nonatomic , strong) NSString *address;
@property (nonatomic , strong) NSString *b_address;
@property (nonatomic , strong) NSString *chef_id;
@property (nonatomic , strong) NSString *dish_total;
@property (nonatomic , strong) NSString *express_price;
@property (nonatomic , strong) NSString *length;
@property (nonatomic , strong) NSString *note;
@property (nonatomic , strong) NSString *order_num;
@property (nonatomic , strong) NSString *order_time;
@property (nonatomic , strong) NSString *phone;
@property (nonatomic , strong) NSArray *dish_list;
@property (nonatomic , strong) NSString *place_time;

@property (nonatomic , strong) NSString *start_address;
@property (nonatomic , strong) NSString *status;
@property (nonatomic , strong) NSString *total_price;

@end

#pragma mark - ArmedEscortModel
@interface ArmedEscortModel:Model

@property (nonatomic , strong) NSString *dish_total;
@property (nonatomic , strong) NSString *end_address;
@property (nonatomic , strong) NSString *express_price;
@property (nonatomic , strong) NSString *length;
@property (nonatomic , strong) NSString *order_num;
@property (nonatomic , strong) NSString *order_time;
@property (nonatomic , strong) NSString *start_address;
@end

#pragma mark - DoHavingDeliveryModel
@interface DoHavingDeliveryModel:Model

@property (nonatomic , strong) NSString *address;
@property (nonatomic , strong) NSString *b_address;
@property (nonatomic , strong) NSString *chef_id;
@property (nonatomic , strong) NSArray *dish_list;
@property (nonatomic , strong) NSString *dish_price;
@property (nonatomic , strong) NSString *dish_total;
@property (nonatomic , strong) NSString *express_price;
@property (nonatomic , strong) NSString *note;
@property (nonatomic , strong) NSString *order_num;
@property (nonatomic , strong) NSString *order_time;
@property (nonatomic , strong) NSString *phone;
@property (nonatomic , strong) NSString *place_time;
@property (nonatomic , strong) NSString *status;
@property (nonatomic , strong) NSString *total_price;
@end



#pragma mark - MyEnshrineOfPrivateChefModel

@interface MyEnshrineOfPrivateChefModel :Model

@property (nonatomic , strong) NSString *address;
@property (nonatomic , strong) NSString *age;
@property (nonatomic , strong) NSString *card;
@property (nonatomic , strong) NSString *collection_id;
@property (nonatomic , strong) NSString *guest_id;
@property (nonatomic , strong) NSString *icon;
@property (nonatomic , strong) NSString *ID;

@property (nonatomic , strong) NSString *lat;
@property (nonatomic , strong) NSString *lon;
@property (nonatomic , strong) NSString *nicename;

@property (nonatomic , strong) NSString *oid;
@property (nonatomic , strong) NSString *other;
@property (nonatomic , strong) NSString *sale_num;


@property (nonatomic , strong) NSString *score;
@property (nonatomic , strong) NSArray *top;
@property (nonatomic , strong) NSString *uid;

@property (nonatomic , strong) NSString *type;


@end


#pragma mark - EvaluateDishTableViewCellModel
@interface EvaluateDishTableViewCellModel:Model

@property (nonatomic , strong) NSString *dish_name;
@property (nonatomic , strong) NSString *dish_num;
@property (nonatomic , strong) NSString *dish_price;
@property (nonatomic , strong) NSString *dish_id;

@end