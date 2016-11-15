//
//  XMGHttpRequest.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/13.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGHttpRequest.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking-RACExtensions/RACAFNetworking.h>

@implementation XMGHttpRequest

+ (RACSignal *)postWithURL:(NSString *)url params:(NSDictionary *)params
{
    return [self postWithHeaders:nil url:url params:params];
}

+ (RACSignal *)postWithHeaders:(NSDictionary *)headers url:(NSString *)url params:(NSDictionary *)params {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (headers) {
        NSArray *keys = headers.allKeys;
        NSUInteger count = keys.count;
        for (int i = 0; i < count; i++) {
            NSString *key = keys[i];
            NSString *value = [headers valueForKey:key];
            [[manager requestSerializer] setValue:value forHTTPHeaderField:key];
        }
    }
    
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return [manager rac_POST:url parameters:params];
}

+ (RACSignal *)getWithURL:(NSString *)url params:(NSDictionary *)params
{
    return [self getWithHeaders:nil url:url params:params];
}

+ (RACSignal *)getWithHeaders:(NSDictionary *)headers url:(NSString *)url params:(NSDictionary *)params {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (headers) {
        NSArray *keys = headers.allKeys;
        NSUInteger count = keys.count;
        for (int i = 0; i < count; i++) {
            NSString *key = keys[i];
            NSString *value = [headers valueForKey:key];
            [[manager requestSerializer] setValue:value forHTTPHeaderField:key];
        }
    }
    
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    return [manager rac_GET:url parameters:params];
    
}
@end
