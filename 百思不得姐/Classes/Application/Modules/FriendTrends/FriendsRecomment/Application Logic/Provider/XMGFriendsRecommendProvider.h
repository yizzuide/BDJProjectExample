//
//  XMGFriendsRecommendProvider.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/13.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XMGRecommendCategoryModel,XMGRecommandUserModel,XMGRecommandUserGroupModel,XMGRCUserRenderData;
@interface XMGFriendsRecommendProvider : NSObject

+ (NSArray *)collectCategoryRenderListFormArray:(NSArray<XMGRecommendCategoryModel *> *)array;
+ (XMGRCUserRenderData *)collectUserRenderDataFormArray:(NSArray<XMGRecommandUserModel *> *)array;
@end
