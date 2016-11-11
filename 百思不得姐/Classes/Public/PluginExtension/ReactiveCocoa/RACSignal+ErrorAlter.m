//
//  RACSignal+ErrorAlter.m
//  VIPERGem
//
//  Created by yizzuide on 15/12/28.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import "RACSignal+ErrorAlter.h"

@implementation RACSignal (ErrorAlter)


- (RACSignal *)alterError:(void (^)(NSError **errorPtr))block {
    NSCParameterAssert(block != NULL);
    
    return [[RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        return [self subscribeNext:^(id x) {
            [subscriber sendNext:x];
        } error:^(NSError *error) {
            block(&error);
            [subscriber sendError:error];
        } completed:^{
            [subscriber sendCompleted];
        }];
    }] setNameWithFormat:@"[%@] -alterError:", self.name];
}

- (RACSignal *)mapError:(NSError * (^)(NSError *error))block {
    NSCParameterAssert(block != NULL);
    
    return [[RACSignal createSignal:^(id<RACSubscriber> subscriber) {
        return [self subscribeNext:^(id x) {
            [subscriber sendNext:x];
        } error:^(NSError *error) {
            [subscriber sendError:block(error)];
        } completed:^{
            [subscriber sendCompleted];
        }];
    }] setNameWithFormat:@"[%@] -mapError:", self.name];
}
@end
