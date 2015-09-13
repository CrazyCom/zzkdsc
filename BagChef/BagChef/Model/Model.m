//
//  Model.m
//  BagChef
//
//  Created by zhangzhi on 15/8/24.
//  Copyright (c) 2015年 ZZ. All rights reserved.
//

#import "Model.h"
#import <objc/message.h>
#import <objc/runtime.h>

const char * getPropertyType(objc_property_t property) {
    const char * ret = "";
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            ret = (const char *)[[NSData dataWithBytes:(attribute + 1) length:strlen(attribute) - 1] bytes];
            break;
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            ret = "id";
            break;
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            ret = (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
            break;
        }
    }
    return ret;
}

NSString *getType(objc_property_t property)
{
    NSString *propertyType = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
    if ([propertyType hasPrefix:@"T@"]) {
        return [propertyType substringWithRange:NSMakeRange(3, [propertyType rangeOfString:@","].location - 4)];
    }
    else if ([propertyType hasPrefix:@"Ti"])
    {
        return @"int";
    }
    else if ([propertyType hasPrefix:@"TF"])
    {
        return @"float";
    }
    else if([propertyType hasPrefix:@"Td"]) {
        return @"double";
    }
    else if([propertyType hasPrefix:@"Tl"])
    {
        return @"long";
    }
    else if ([propertyType hasPrefix:@"Tc"]) {
        return @"char";
    }
    else if([propertyType hasPrefix:@"Ts"])
    {
        return @"short";
    }
    return nil;
}


@implementation Model

- (id)initWithDictionaryParams:(NSDictionary *)param {
    
    self = [super init];
    if (self) {
        
        [self initModelWith:param];
        
    }
    return self;
}

- (void)getAllPropertyList:(Class)cls dict:(NSMutableDictionary *)dict {
    
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList(cls, &propertyCount);
    for ( int i=0; i < propertyCount; i++ )
    {
        objc_property_t *thisProperty = propertyList + i;
        NSString *propertyType = getType(*thisProperty);
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(*thisProperty)];
        [dict setValue:propertyType forKey:propertyName];
    }
    
    const char *superClassName = class_getName(class_getSuperclass(cls));
    int cmp = strncmp(superClassName, "Model", strlen(superClassName));
    if (cmp == 0) {
        
        free(propertyList);
        return;
    }
    
    [self getAllPropertyList:[cls superclass] dict:dict];
}


- (void)initModelWith:(NSDictionary *)param {
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [self getAllPropertyList:[self class] dict:dict];
    
    //    unsigned int propertyCount = 0;
    //    objc_property_t *propertyList = class_copyPropertyList([self class], &propertyCount);
    //    for ( int i=0; i < propertyCount; i++ )
    //    {
    //        objc_property_t *thisProperty = propertyList + i;
    //        NSString *propertyType = getType(*thisProperty);
    //        NSString *propertyName = [NSString stringWithUTF8String:property_getName(*thisProperty)];
    //        [dict setValue:propertyType forKey:propertyName];
    //    }
    
    for (NSString *key in [param allKeys]) {
        
        
        NSString *name = key;
        NSString *value = param[key];
        NSObject *object = dict[name];
        
        if ([value isKindOfClass:[NSNull class]]) {
            [self setValue:nil forKey:name];
            continue;
        }
        if(object != nil)
        {
            NSString *type = (NSString*)object;
            if([type isEqual:@"NSNumber"])
            {
                NSNumber *num = nil;
                if( [value isEqual:@"true"] || [value isEqual:@"flase"] )
                {
                    num = [NSNumber numberWithInteger:[value boolValue]];
                }
                else if( [[NSString stringWithFormat:@"%@", value] rangeOfString:@"."].location != NSNotFound )
                {
                    num = [NSNumber numberWithFloat:[value floatValue]];
                }
                else
                {
                    num = [NSNumber numberWithLongLong:[value longLongValue]];
                }
                [self setValue:num forKey:name];
                
            }
            
            else if([type isEqual:@"NSString"])
            {
                [self setValue:value forKey:name];
            }
            //            else if([type isEqual:@"NSURL"])
            //            {
            //                NSURL *url = nil;
            //                NSRange range = [value rangeOfString:@"http://" options:NSCaseInsensitiveSearch];
            //                if(range.location == NSNotFound)
            //                {
            //                    url =[Unity resourceUrlByResourceName:value];
            //                }
            //                else
            //                {
            //                    url = [NSURL URLWithString:value];
            //                }
            //                [self setValue:url forKey:name];
            //
            //            }
            else if([type isEqual:@"NSDate"])
            {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                //dateFormatter.locale= [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
                //设定时间格式,这里可以设置成自己需要的格式
                //[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:sszzzz"]; // @"1981-10-10T12:22:33+0800"
                [dateFormatter setDateFormat:@"yyyy-MM-dd' 'HH:mm:ss"]; // @"1981-10-10 12:22:33"
                NSDate *date = [dateFormatter dateFromString:value];
                [self setValue:date forKey:name];
            }
            else {
                [self setValue:value forKey:name];
            }
        }
    }
}

+ (id)deepCopy:(Model *)obj
{
    int i;
    unsigned int propertyCount = 0;
    Model *copy = [[[obj class]alloc]init];
    objc_property_t *propertyList = class_copyPropertyList([obj class], &propertyCount);
    for ( i=0; i < propertyCount; i++ ) {
        objc_property_t *thisProperty = propertyList + i;
        //const char *propertyType = getPropertyType(*thisProperty);
        NSString *propertyType = [NSString stringWithUTF8String:getPropertyType(*thisProperty)];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(*thisProperty)];
        [copy setValue:[obj valueForKey:propertyName] forKey:propertyName];
        NSLog(@"Person has a property: '%@', type: '%@'", propertyName,propertyType );
    }
    //    copy.name = obj.name;
    //    copy.sid = obj.sid;
    free(propertyList);
    return copy;
}

- (NSDictionary *)getDictionary {
    
    return [Model dictionaryWithModel:self];
}


+ (NSDictionary *)dictionaryWithModel:(id)model {
    if (model == nil) {
        return nil;
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    // 获取类名/根据类名获取类对象
    NSString *className = NSStringFromClass([model class]);
    id classObject = objc_getClass([className UTF8String]);
    
    // 获取所有属性
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(classObject, &count);
    
    // 遍历所有属性
    for (int i = 0; i < count; i++) {
        // 取得属性
        objc_property_t property = properties[i];
        // 取得属性名
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property)
                                                          encoding:NSUTF8StringEncoding];
        // 取得属性值
        id propertyValue = nil;
        id valueObject = [model valueForKey:propertyName];
        
        if ([valueObject isKindOfClass:[NSDictionary class]]) {
            propertyValue = [NSDictionary dictionaryWithDictionary:valueObject];
        } else if ([valueObject isKindOfClass:[NSArray class]]) {
            propertyValue = [NSArray arrayWithArray:valueObject];
        } else {
            propertyValue = [NSString stringWithFormat:@"%@", [model valueForKey:propertyName]];
        }
        
        [dict setObject:propertyValue forKey:propertyName];
    }
    return [dict copy];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p> %@", [self class], self, [self getDictionary]];
}


- (id)initWithDicitonary:(NSDictionary *)dictionary {
    
    //dictionary setValue:<#(id)#> forKey:<#(NSString *)#>
    if (self = [super init]) {
        [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([obj isKindOfClass:[NSNull class]] || obj == nil) {
                obj = @"";
            }
            if ([key isEqualToString:@"id"]) {
                key = @"ID";
            }
            
            [self setValue:obj forKey:key];//
        }];
    }
    
    return self;
}

- (NSDictionary *)serverNeededDictionary {
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    // 获取本类属性列表字符串数组
    NSMutableArray *propertyArray = [self properties];
    
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        id value = [self valueForKey:obj];
        if ([obj isEqualToString:@"ID"]) {
            obj = @"id";
        }
        if (value == nil || [value isKindOfClass:[NSNull class]]) {
            value = @"";
        }
        
        [dict setObject:value forKey:obj];
        
    }];
    
    return dict;
}

- (BOOL)isEqual:(id)object {
    
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    NSMutableArray *propertyArray = [self properties];
    __block BOOL euqal = YES;
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        euqal = [[self valueForKey:obj] isEqual:[object valueForKey:obj]];
        if (!euqal) {
            *stop = YES;
        }
    }];
    
    return euqal;
}

- (NSUInteger)hash {
    
    NSMutableArray *propertyArray = [self properties];
    __block NSUInteger hashCode = [self hash];
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        hashCode ^= [[self valueForKey:obj] hash];
    }];
    
    return hashCode;
}

#pragma mark - runtime

- (NSMutableArray *)properties {
    
    NSMutableArray *propertyArray = [[NSMutableArray alloc] init];
    u_int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSString *stringName = [NSString  stringWithCString:propertyName
                                                   encoding:NSUTF8StringEncoding];
        [propertyArray addObject:stringName];
    }
    
    return propertyArray;
}

+ (NSMutableArray *)properties {
    
    NSMutableArray *propertyArray = [[NSMutableArray alloc] init];
    u_int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSString *stringName = [NSString  stringWithCString:propertyName
                                                   encoding:NSUTF8StringEncoding];
        [propertyArray addObject:stringName];
    }
    
    return propertyArray;
}

#pragma mark - 判断自身对象完整度

- (float)integrity {
    
    // 需要排除两个界面没有用到的id属性
    // 获取本类属性列表字符串数组
    NSMutableArray *propertyArray = [self properties];
    __block float count = 0;
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        id value = [self valueForKey:obj];
        if (![value isKindOfClass:[NSNull class]] && [value length]) {
            count++;
        };
    }];
    return (count - 2.0) / ((float)propertyArray.count - 2.0);
}

#pragma mark - 返回自身对象所有数据的数组集合

- (NSMutableArray *)valueForProperties {
    
    NSMutableArray *propertyArray = [self properties];
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    [propertyArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [values addObject:[self valueForKey:obj]];
    }];
    
    // 去掉最后两个id元素
    [values removeLastObject];
    [values removeLastObject];
    
    return values;
}


@end


#pragma mark - dishList
@implementation HadUploadMenuModel


@end


#pragma mark - HomePageModel
@implementation HomePageModel

@end



#pragma mark - GourmetViewModel
@implementation GourmetViewModel

@end

#pragma mark - MenuListCellOfModel

@implementation MenuListCellOfModel

@end

#pragma mark - SendBeSendingViewModel

@implementation SendBeSendingViewModel

@end

#pragma mark - ArmedEscortModel

@implementation ArmedEscortModel

@end

#pragma mark - DoHavingDeliveryModel

@implementation DoHavingDeliveryModel

@end

#pragma mark - MyEnshrineOfPrivateChefModel

@implementation MyEnshrineOfPrivateChefModel

@end

#pragma mark - EvaluateDishTableViewCellModel

@implementation EvaluateDishTableViewCellModel

@end
