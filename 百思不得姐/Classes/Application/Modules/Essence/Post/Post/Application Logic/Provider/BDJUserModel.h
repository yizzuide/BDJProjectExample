//
//  BDJUserModel.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/29.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BDJUserModel : NSObject

/** 是否是VIP */
@property (nonatomic, assign) NSInteger  is_vip;

/** qq_uid */
@property (nonatomic, copy) NSString* qq_uid;

/** 用户ID */
@property (nonatomic, assign) NSInteger  ID;

/** 个人主页 */
@property (nonatomic, copy) NSString* personal_page;

/** 微博UID */
@property (nonatomic, copy) NSString* weibo_uid;

/** 用户名 */
@property (nonatomic, copy) NSString* username;

/** qzone_uid */
@property (nonatomic, copy) NSString* qzone_uid;

/** 评论Like总数 */
@property (nonatomic, assign) NSInteger  total_cmt_like_count;

/** 性别 */
@property (nonatomic, copy) NSString* sex;

/** 图像 */
@property (nonatomic, copy) NSString* profile_image;
@end
