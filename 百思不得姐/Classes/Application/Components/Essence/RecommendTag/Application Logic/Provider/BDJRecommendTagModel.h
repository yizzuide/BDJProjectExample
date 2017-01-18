//
//  BDJRecommendTagModel.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/16.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDJRecommendTagModel : NSObject

/** 标签图标 */
@property (nonatomic, copy) NSString* image_list;

/** 标签ID */
@property (nonatomic, assign) NSInteger  theme_id;

/** 标签名 */
@property (nonatomic, copy) NSString* theme_name;

/** 是否含有子标签 */
@property (nonatomic, assign) NSInteger  is_sub;

/** 是否是默认的推荐标签 */
@property (nonatomic, assign) NSInteger  is_default;

/** 订阅数量 */
@property (nonatomic, assign) NSInteger  sub_number;
@end
