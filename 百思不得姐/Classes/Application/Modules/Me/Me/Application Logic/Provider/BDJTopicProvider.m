//
//  BDJTopicProvider.m
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/6.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJTopicProvider.h"
#import "XFRenderData.h"
#import "BDJTopicModel.h"
#import "BDJTopicRenderItem.h"

@implementation BDJTopicProvider

+ (XFRenderData *)collectRenderDataFromArray:(NSArray<BDJTopicModel *> *)array {
    XFRenderData *renderData = [XFRenderData new];
    renderData.list = [[array.rac_sequence map:^id(BDJTopicModel *topicModel) {
        BDJTopicRenderItem *renderItem = [BDJTopicRenderItem new];
        renderItem.topicIconURL = [NSURL URLWithString:topicModel.icon];
        renderItem.topicName = topicModel.name;
        renderItem.openURL = topicModel.url;
        return renderItem;
    }] array].mutableCopy;
    return renderData;
}

@end
