//
//  BDJPostProvider.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/22.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPostProvider.h"
#import "BDJPostModel.h"
#import "XFRenderData.h"
#import "BDJPostRenderItem.h"
#import "BDJPictruePostRenderItem.h"

@implementation BDJPostProvider

+ (XFRenderData *)collectPostRenderDataFromArray:(NSArray<BDJPostModel *> *)array {
	NSMutableArray *list = [[array.rac_sequence map:^id(BDJPostModel *postModel) {
        BDJPostRenderItem *renderItem;
        switch (postModel.type) {
            case BDJPostDataMediaTypePictrue:
                renderItem = [self _collectWordsPostRenderItemFrom:postModel];
                break;
            default:
                // 其它为纯文本类型
                renderItem = [[BDJPostRenderItem alloc] init];
                renderItem.type = BDJPostRenderItemTypeWords;
                break;
        }
        renderItem.userName = postModel.screen_name;
        renderItem.ProfileUrl = [NSURL URLWithString:postModel.profile_image];
        // 这里要使用审核通过时间，不能直接使用用户创建时间，不然会造成时间上的混乱排列
        renderItem.createTime = postModel.passtime;
        renderItem.love = [NSString stringWithFormat:@"%zd", postModel.love];
        renderItem.hate = [NSString stringWithFormat:@"%zd", postModel.hate];
        renderItem.rePost = [NSString stringWithFormat:@"%zd",postModel.repost];
        renderItem.comment = [NSString stringWithFormat:@"%zd",postModel.comment];
        renderItem.sina_v = postModel.sina_v;
        renderItem.text = postModel.text;
        return renderItem;
    }] array].mutableCopy;
    XFRenderData *renderData = [[XFRenderData alloc] init];
    renderData.list = list;
    return renderData;
}

+ (BDJPictruePostRenderItem *)_collectWordsPostRenderItemFrom:(BDJPostModel *)postModel
{
    BDJPictruePostRenderItem *renderItem = [[BDJPictruePostRenderItem alloc] init];
    
    renderItem.width = postModel.width;
    renderItem.height = postModel.height;
    renderItem.url = [NSURL URLWithString:postModel.image_large];
    // 是否为长图
    if (postModel.height > R_Height_PostPictureMax) {
        renderItem.type = BDJPostRenderItemTypePictrueLong;
        return renderItem;
    }
    
    // 是否为gif图
    if (postModel.is_gif) {
        renderItem.type = BDJPostRenderItemTypePictrueGIF;
        return renderItem;
    }
    
    // 一般图片
    renderItem.type = BDJPostRenderItemTypePictrue;
    return renderItem;
}
@end
