//
//  BDJFriendsRecommendProvider.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/13.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BDJRecommendCategoryModel,BDJRecommandUserModel,BDJRecommandUserGroupModel,BDJRCUserRenderData;
@interface BDJFriendsRecommendProvider : NSObject

+ (NSArray *)collectCategoryRenderListFormArray:(NSArray<BDJRecommendCategoryModel *> *)array;
+ (BDJRCUserRenderData *)collectUserRenderDataFormArray:(NSArray<BDJRecommandUserModel *> *)array;
@end
