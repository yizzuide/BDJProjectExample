//
//  BDJSquare.h
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/6.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDJTopicModel : NSObject

/** 支持平台版本 */
@property (nonatomic, copy) NSString* iphone;

/** 市场名 */
@property (nonatomic, copy) NSString* market;

/** 话题名 */
@property (nonatomic, copy) NSString* name;

/** 话题ID */
@property (nonatomic, assign) NSInteger  ID;

/** 应用打开URL */
@property (nonatomic, copy) NSString* url;

/** 支持平台版本 */
@property (nonatomic, copy) NSString* ipad;

/** 支持平台版本 */
@property (nonatomic, copy) NSString* android;

/** 话题图标 */
@property (nonatomic, copy) NSString* icon;

@end
