//
//  BDJTopicService.h
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/6.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDJTopicService : NSObject

- (RACSignal *)pullTopics;
@end
