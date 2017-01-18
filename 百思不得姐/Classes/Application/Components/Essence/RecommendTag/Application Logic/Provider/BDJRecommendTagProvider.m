//
//  BDJRecommendTagProvider.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/16.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJRecommendTagProvider.h"
#import "BDJRCTagRenderItem.h"
#import "BDJRecommendTagModel.h"

@implementation BDJRecommendTagProvider

+ (XFRenderData *)collectRenderDataFromArray:(NSArray<BDJRecommendTagModel *> *)array {
    NSArray *list = [[array.rac_sequence map:^id(BDJRecommendTagModel *recommendTagModel) {
        BDJRCTagRenderItem *renderItem = [[BDJRCTagRenderItem alloc] init];
        renderItem.imageURL = [NSURL URLWithString:recommendTagModel.image_list];
        renderItem.tagName = recommendTagModel.theme_name;
        if (recommendTagModel.sub_number > 10000) {
            // 如果是上万位的数据，保留一位小数
            CGFloat fromatNumber = floor((recommendTagModel.sub_number / 10000.0) * 10) / 10;
            // 去除小数为0的情况
            if (fromatNumber - ((int)fromatNumber) >= 0.1) {
                renderItem.subscribeAmount = [NSString stringWithFormat:@"已有%.1f万人订阅",fromatNumber];
            }else{
                renderItem.subscribeAmount = [NSString stringWithFormat:@"已有%zd万人订阅",((int)fromatNumber)];
            }
        }else{
            renderItem.subscribeAmount = [NSString stringWithFormat:@"已有%zd人订阅",recommendTagModel.sub_number];
        }
        return renderItem;
    }] array];
    XFRenderData *renderData = [[XFRenderData alloc] init];
    renderData.list = list.mutableCopy;
    return renderData;
}
@end
