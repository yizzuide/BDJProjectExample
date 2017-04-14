//
//  BDJHttpRequest.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/13.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDJHttpRequest : NSObject

+ (RACSignal *)postWithURL:(NSString *)url params:(NSDictionary *)params;
+ (RACSignal *)postWithHeaders:(NSDictionary *)headers url:(NSString *)url params:(NSDictionary *)params;
+ (RACSignal *)getWithURL:(NSString *)url params:(NSDictionary *)params;
+ (RACSignal *)getWithHeaders:(NSDictionary *)headers url:(NSString *)url params:(NSDictionary *)params;
@end
