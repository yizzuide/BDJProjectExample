//
//  BDJRecommandUserModel.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/14.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDJRecommandUserModel : NSObject
@property (nonatomic, copy) NSString *uid;
/**
 *  昵称
 */
@property (nonatomic, copy) NSString *screen_name;
@property (nonatomic, copy) NSString *introduction;
/**
 *  粉丝数
 */
@property (nonatomic, assign) NSInteger fans_count;
@property (nonatomic, copy) NSString *tiezi_count;
/**
 *  头像
 */
@property (nonatomic, copy) NSString *header;
/**
 *  性别
 */
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) BOOL is_follow;
@end
