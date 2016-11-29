//
//  BDJPostCommentModel.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/29.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDJUserModel.h"

@interface BDJPostCommentModel : NSObject

/** 评论id */
@property (nonatomic, assign) NSInteger  ID;

/** precid */
@property (nonatomic, assign) NSInteger  precid;

/** 评论用户 */
@property (nonatomic, strong) BDJUserModel * user;

/** data_id */
@property (nonatomic, assign) NSInteger  data_id;

/** precmt */
@property (nonatomic, strong) NSArray* precmt;

/** 评论类型 文本类型：29 */
@property (nonatomic, assign) NSInteger  cmt_type;

/** 创建时间 */
@property (nonatomic, copy) NSString* ctime;

/** 赞数 */
@property (nonatomic, assign) NSInteger  like_count;

/** 语音时长 */
@property (nonatomic, copy) NSString* voicetime;

/** 语音URL */
@property (nonatomic, copy) NSString* voiceuri;

/** preuid */
@property (nonatomic, assign) NSInteger  preuid;

/** 状态 */
@property (nonatomic, assign) NSInteger  status;

/** 文本内容 */
@property (nonatomic, copy) NSString* content;


@end
