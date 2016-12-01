//
//  BDJPostCmtProvider.m
//  百思不得姐
//
//  Created by Yizzuide on 2016/11/30.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPostCmtProvider.h"
#import "XFRenderData.h"
#import "BDJMetaPostCmtModel.h"
#import "BDJPostCmtRenderItem.h"
#import "BDJPostCmtModel.h"
#import "BDJPostCmtRenderData.h"

@implementation BDJPostCmtProvider

+ (XFRenderData *)collectRenderDataFromModel:(BDJMetaPostCmtModel *)metaPostCmtModel
{
    // 收集最热评论的显示数据
    NSArray *hotList = [[metaPostCmtModel.hot.rac_sequence map:^id(BDJPostCmtModel *postCmtModel) {
        return [self _collectRenderItemFromModel:postCmtModel];
    }] array];
    // 收集最新评论的显示数据
    NSArray *newList = [[metaPostCmtModel.data.rac_sequence map:^id(BDJPostCmtModel *postCmtModel) {
        BDJPostCmtRenderItem *renderItem = [self _collectRenderItemFromModel:postCmtModel];
        // 引用评论
        if (postCmtModel.precmt) {
            renderItem.refUserName = postCmtModel.precmt.user.username;
        }
        return renderItem;
    }] array];
    BDJPostCmtRenderData *renderData = [[BDJPostCmtRenderData alloc] init];
    renderData.list = @[].mutableCopy;
    renderData.hotCount = hotList.count; // 记录最热评论的个数
    if (hotList.count) {
        [renderData.list addObjectsFromArray:hotList];
    }
    [renderData.list addObjectsFromArray:newList];
    return renderData;
}

+ (BDJPostCmtRenderItem *)_collectRenderItemFromModel:(BDJPostCmtModel *)postCmtModel
{
    BDJPostCmtRenderItem *renderItem = [[BDJPostCmtRenderItem alloc] init];
    renderItem.profile = [NSURL URLWithString:postCmtModel.user.profile_image];
    renderItem.userName = postCmtModel.user.username;
    renderItem.sexType = [postCmtModel.user.sex isEqualToString:@"m"] ? PostCmtRenderItemSexTypeMan : PostCmtRenderItemSexTypeFemale;
    renderItem.commentContent = postCmtModel.content;
    renderItem.likeCount = [NSString stringWithFormat:@"%zd", postCmtModel.like_count];
    return renderItem;
}

@end
