//
//  XMGFriendsRecommendProvider.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/13.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGFriendsRecommendProvider.h"
#import "XMGCategoryRenderItem.h"
#import "XMGRecommendCategoryModel.h"
#import "XMGRecommandUserModel.h"
#import "XMGRCUserRenderItem.h"
#import "XMGRCUserRenderData.h"

@implementation XMGFriendsRecommendProvider


+ (NSArray *)collectCategoryRenderListFormArray:(NSArray<XMGRecommendCategoryModel *> *)array {
	return [[array.rac_sequence map:^id(XMGRecommendCategoryModel *recommendCategoryModel) {
        XMGCategoryRenderItem *renderItem = [[XMGCategoryRenderItem alloc] init];
        renderItem.name = recommendCategoryModel.name;
        return renderItem;
    }] array];
}

+ (XMGRCUserRenderData *)collectUserRenderDataFormArray:(NSArray<XMGRecommandUserModel *> *)array {
    NSMutableArray *renderList = [[array.rac_sequence map:^id(XMGRecommandUserModel *recommendUserModel) {
        XMGRCUserRenderItem *renderItem = [[XMGRCUserRenderItem alloc] init];
        renderItem.nikeName = recommendUserModel.screen_name;
        renderItem.fansCount = [NSString stringWithFormat:@"%zd", recommendUserModel.fans_count];
        renderItem.headPortraitURL = [NSURL URLWithString:recommendUserModel.header];
        return renderItem;
    }] array].mutableCopy;
    XMGRCUserRenderData *renderData = [[XMGRCUserRenderData alloc] init];
    renderData.list = renderList;
    return renderData;
}
@end
