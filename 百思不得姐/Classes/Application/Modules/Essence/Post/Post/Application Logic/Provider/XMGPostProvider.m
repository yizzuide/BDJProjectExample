//
//  XMGPostProvider.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/22.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGPostProvider.h"
#import "XMGPostModel.h"
#import "XFRenderData.h"
#import "XMGPostRenderItem.h"
#import "XMGPictruePostRenderItem.h"

@implementation XMGPostProvider

+ (XFRenderData *)collectPostRenderDataFromArray:(NSArray<XMGPostModel *> *)array {
	NSMutableArray *list = [[array.rac_sequence map:^id(XMGPostModel *postModel) {
        XMGPostRenderItem *renderItem;
        switch (postModel.type) {
            case XMGPostDataMediaTypePictrue:
                renderItem = [self _collectWordsPostRenderItemFrom:postModel];
                break;
            default:
                // 其它为纯文本类型
                renderItem = [[XMGPostRenderItem alloc] init];
                renderItem.type = XMGPostRenderItemTypeWords;
                break;
        }
        renderItem.userName = postModel.screen_name;
        renderItem.ProfileUrl = [NSURL URLWithString:postModel.profile_image];
        renderItem.createTime = postModel.create_time;
        renderItem.love = [NSString stringWithFormat:@"%zd", postModel.love];
        renderItem.hate = [NSString stringWithFormat:@"%zd", postModel.hate];
        renderItem.rePost = [NSString stringWithFormat:@"%zd",postModel.repost];
        renderItem.comment = [NSString stringWithFormat:@"%zd",postModel.comment];
        renderItem.sina_v = postModel.sina_v;
        return renderItem;
    }] array].mutableCopy;
    XFRenderData *renderData = [[XFRenderData alloc] init];
    renderData.list = list;
    return renderData;
}

+ (XMGPictruePostRenderItem *)_collectWordsPostRenderItemFrom:(XMGPostModel *)postModel
{
    XMGPictruePostRenderItem *renderItem = [[XMGPictruePostRenderItem alloc] init];
    // 是否为长图
    
    // 是否为gif图
    if (postModel.is_gif) {
        renderItem.type = XMGPostRenderItemTypePictrueGIF;
        return renderItem;
    }
    renderItem.type = XMGPostRenderItemTypePictrue;
    renderItem.width = postModel.width;
    renderItem.height = postModel.height;
    renderItem.url = [NSURL URLWithString:postModel.image_large];
    return renderItem;
}
@end
