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
 *  @param isNew               是否为新帖
 */
- (RACSignal *)pullPostsForType:(BDJPostDataMediaType)postSeviceMediaType isNew:(BOOL)isNew;

/**
 *  加载下一页帖子
 *
 *  @param postSeviceMediaType 帖子数据枚举
 *  @param maxtime             上一次最大时间
 *  @param page                页数
 *  @param isNew               是否为新帖
 *
 */
- (RACSignal *)pullPostsForType:(BDJPostDataMediaType)postSeviceMediaType maxtime:(NSInteger)maxtime atPage:(NSInteger)page  isNew:(BOOL)isNew;
/**
 *  加载帖子评论
 *
 *  @param ID 帖子ID
 *
 */
- (RACSignal *)pullPostCommentsWithPostID:(NSString *)ID;
/**
 *  加载下一页帖子评论
 *
 *  @param ID        帖子ID
 *  @param lastCmtID 最近的评论ID
 *  @param page      页数
 *
 */
- (RACSignal *)pullPostCommentsWithWithPostID:(NSString *)ID lastCommentID:(NSString *)lastCmtID atPage:(NSInteger)page;
@end
