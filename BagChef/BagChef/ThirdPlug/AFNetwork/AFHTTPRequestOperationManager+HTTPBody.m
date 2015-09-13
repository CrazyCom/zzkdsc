//
//  AFHTTPRequestOperationManager+HTTPBody.m
//  HFAirConditioning
//
//  Created by 严 辉 on 15/8/10.
//  Copyright (c) 2015年 Jpc. All rights reserved.
//

#import "AFHTTPRequestOperationManager+HTTPBody.h"

@implementation AFHTTPRequestOperationManager (HTTPBpdy)

- (AFHTTPRequestOperation *)POST:(NSString *)URLString HTTPBody:(NSString *)httpBody parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    
    [request setHTTPBody:[httpBody dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    
    [self.operationQueue addOperation:operation];

    return operation;
}

- (AFHTTPRequestOperation *)GET:(NSString *)URLString HTTPBody:(NSString *)httpBody parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {

    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    
    [request setHTTPBody:[httpBody dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    
    [self.operationQueue addOperation:operation];
    
    return operation;
}

@end
