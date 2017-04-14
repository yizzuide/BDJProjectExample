//
//  BDJTopicTagDataDriverProtocol.h
//  百思不得姐
//
//  Created by Yizzuide on 2017/2/13.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#ifndef BDJTopicTagDataDriverProtocol_h
#define BDJTopicTagDataDriverProtocol_h
#import "LEDataDriverProtocol.h"

@protocol BDJTopicTagDataDriverProtocol <LEDataDriverProtocol>

/**
 *  返回数据到上一个界面
 *
 *  @param tagNames 标签组
 */
- (void)backActionWithTagArray:(NSArray<NSString *> *)tagNames;

@end

#endif /* BDJTopicTagDataDriverProtocol_h */
