//
//  XMGPostExpressPack.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/24.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGPostExpressPack.h"
#import "XMGPostFrame.h"
#import "XMGPostRenderItem.h"
#import "XMGPictruePostRenderItem.h"

@implementation XMGPostExpressPack

- (id)onMeasureFrameWithItem:(__kindof XFRenderItem *)renderItem index:(NSUInteger)index
{
    CGFloat cellH = 0;
    XMGPostFrame *frame = [[XMGPostFrame alloc] init];
    XMGPostRenderItem *postRenderItem = renderItem;
    CGFloat cellContentWidth = ScreenSize.width - R_Size_PostCellMargin * 4;
    
    // 开始计算cell高度
    cellH += R_Height_PostCellClip; // 添加内部裁剪掉的部分
    cellH += R_Size_PostCellMargin * 2 + R_Height_PostCellHeader; // 添加头部
    CGFloat textH = [postRenderItem.text boundingRectWithSize:CGSizeMake(cellContentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    cellH += textH + R_Size_PostCellMargin; // 文本内容高度
    
    // 如果为短图
    if (postRenderItem.type == XMGPostRenderItemTypePictrue || postRenderItem.type == XMGPostRenderItemTypePictrueGIF) {
        // 缩放它的比例
        XMGPictruePostRenderItem *item = renderItem;
        item.height = cellContentWidth * item.height / item.width;
        cellH += item.height; // 添加图片高度
        // 如果是长图，固定它的高度
    } else if(postRenderItem.type == XMGPostRenderItemTypePictrueLong) {
        cellH += R_Height_PostPictureBreak;
    }
    
    cellH += R_Height_PostCellBottomBar; // 添加帖子工具条高度
    frame.cellHeight = cellH;
    return frame;
}
@end
