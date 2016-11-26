//
//  BDJFriendsRecommentInteractorPort.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/12.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFInteractorPort.h"

@class RACSignal;
@protocol BDJFriendsRecommentInteractorPort <XFInteractorPort>
/**
 *  获得分类数据
 *
 */
- (RACSignal *)fetchRecommendCategory;
/**
 *  根据分类索引获得对应用户组
 *
 *  @param index 分类索引
 *
 */
- (RACSignal *)fetchRecommendUserForCategoryIndex:(NSInteger)index;
/**
 *  根据分类索引获得下一页用户组数据
 *
 *  @param index 分类索引
 *
 */
- (RACSignal *)fetchNextPageRecommendUserForCategoryIndex:(NSInteger)index;
@end
