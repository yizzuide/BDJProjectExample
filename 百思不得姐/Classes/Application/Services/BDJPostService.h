//
//  BDJPostService.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/21.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJMetaPostModel.h"

@interface BDJPostService : NSObject

/**
 *  远程获取所有帖子
 *
 *  @param postSeviceMediaType 帖子数据枚举
 *
 */
- (RACSignal *)pullPostsForType:(BDJPostDataMediaType)postSeviceMediaType;

/**
 *  加载下一页帖子
 *
 *  @param postSeviceMediaType 帖子数据枚举
 *  @param maxtime             上一次最大时间
 *  @param page                页数
 *
 */
- (RACSignal *)pullPostsForType:(BDJPostDataMediaType)postSeviceMediaType maxtime:(NSInteger)maxtime atPage:(NSInteger)page;
@end
