// 
//  BDJPostInfo.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/21.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDJPostInfo : NSObject

/** 最大的帖子id */
@property (nonatomic, assign) NSInteger  maxid;

/** 提供节点 */
@property (nonatomic, copy) NSString* vendor;

/** 总数 */
@property (nonatomic, assign) NSInteger  count;

/** 每次加载下一页的时候，需要传入上一页返回参数中对应的此内容 */
@property (nonatomic, assign) NSInteger  maxtime;

/** 一页20个帖子情况下的最大页数 */
@property (nonatomic, assign) NSInteger  page;
@end
