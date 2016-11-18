//
//  RACSignal+ErrorAlter.h
//
//
//  Created by yizzuide on 15/12/28.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RACSignal (ErrorAlter)
/**
 *  修改返回的错误为自定义错误，使用二级指针方式
 *
 *  @param block 修改操作回调
 *
 *  @return 返回信号
 */
- (RACSignal *)alterError:(void (^)(NSError **errorPtr))block;
/**
 *  修改返回的错误为自定义错误，使用返回覆盖方式
 *
 *  @param block 修改操作回调
 *
 *  @return 返回信号
 */
- (RACSignal *)mapError:(NSError * (^)(NSError *error))block;

@end
