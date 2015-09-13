//
//  AFHTTPRequestOperationManager+HTTPBody.h
//  HFAirConditioning
//
//  Created by 严 辉 on 15/8/10.
//  Copyright (c) 2015年 Jpc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@interface AFHTTPRequestOperationManager (HTTPBody)

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                        HTTPBody:(NSString *)httpBody
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                       HTTPBody:(NSString *)httpBody
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
