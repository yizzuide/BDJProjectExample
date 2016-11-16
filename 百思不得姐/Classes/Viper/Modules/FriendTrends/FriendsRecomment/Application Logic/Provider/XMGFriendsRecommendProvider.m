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
        if (recommendUserModel.fans_count > 10000) {
            // 如果是上万位的数据，保留一位小数
            CGFloat fromatNumber = floor((recommendUserModel.fans_count / 10000.0) * 10) / 10;
            // 去除小数为0的情况
            if (fromatNumber - ((int)fromatNumber) >= 0.1) {
                renderItem.fansCount = [NSString stringWithFormat:@"%.1f万人关注",fromatNumber];
            }else{
                renderItem.fansCount = [NSString stringWithFormat:@"%zd万人关注",((int)fromatNumber)];
            }
        }else{
            renderItem.fansCount = [NSString stringWithFormat:@"%zd人关注",recommendUserModel.fans_count];
        }
        renderItem.headPortraitURL = [NSURL URLWithString:recommendUserModel.header];
        return renderItem;
    }] array].mutableCopy;
    XMGRCUserRenderData *renderData = [[XMGRCUserRenderData alloc] init];
    renderData.list = renderList;
    return renderData;
}
@end
