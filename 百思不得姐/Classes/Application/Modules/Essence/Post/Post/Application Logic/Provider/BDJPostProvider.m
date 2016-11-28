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
#import "BDJPicturePostRenderItem.h"
#import "BDJAVPostRenderItem.h"

@implementation BDJPostProvider

+ (XFRenderData *)collectPostRenderDataFromArray:(NSArray<BDJPostModel *> *)array {
	NSMutableArray *list = [[array.rac_sequence map:^id(BDJPostModel *postModel) {
        BDJPostRenderItem *renderItem;
        switch (postModel.type) {
            case BDJPostDataMediaTypePicture:
                renderItem = [[BDJPicturePostRenderItem alloc] init];
                [self _collectPicturePostRenderItem:(id)renderItem from:postModel];
                break;
            case BDJPostDataMediaTypeVoice:
                renderItem = [[BDJAVPostRenderItem alloc] init];
                [self _collectVoicePostRenderItem:(id)renderItem from:postModel];
                break;
            case BDJPostDataMediaTypeVideo:
                renderItem = [[BDJAVPostRenderItem alloc] init];
                [self _collectVideoPostRenderItem:(id)renderItem from:postModel];
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

+ (void)_collectPicturePostRenderItem:(BDJPicturePostRenderItem *)renderItem from:(BDJPostModel *)postModel
{
    renderItem.width = postModel.width;
    renderItem.height = postModel.height;
    renderItem.url = [NSURL URLWithString:postModel.image_large];
    // 一般图片
    renderItem.type = BDJPostRenderItemTypePicture;
    
    // 是否为长图
    if (postModel.height > R_Height_PostPictureMax) {
        renderItem.type = BDJPostRenderItemTypePictureLong;
    }
    
    // 是否为gif图
    if (postModel.is_gif) {
        renderItem.type = BDJPostRenderItemTypePictureGIF;
    }
}

+ (void)_collectVoicePostRenderItem:(BDJAVPostRenderItem *)renderItem from:(BDJPostModel *)postModel
{
    [self _collectPicturePostRenderItem:renderItem from:postModel];
    renderItem.playURL = [NSURL URLWithString:postModel.voiceuri];
    renderItem.playCount = [NSString stringWithFormat:@"%zd",postModel.playcount];
    renderItem.playTimeLen = [NSString stringWithFormat:@"%zd",postModel.voicetime];
    renderItem.type = BDJPostRenderItemTypeVoice;
}

+ (void)_collectVideoPostRenderItem:(BDJAVPostRenderItem *)renderItem from:(BDJPostModel *)postModel
{
    [self _collectPicturePostRenderItem:renderItem from:postModel];
    renderItem.playURL = [NSURL URLWithString:postModel.videouri];
    renderItem.playCount = [NSString stringWithFormat:@"%zd",postModel.playcount];
    renderItem.playTimeLen = [NSString stringWithFormat:@"%zd",postModel.videotime];
    renderItem.type = BDJPostRenderItemTypeVideo;
}

@end
