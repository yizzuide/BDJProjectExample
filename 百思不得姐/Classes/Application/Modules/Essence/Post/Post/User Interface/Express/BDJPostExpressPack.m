//
//  BDJPostExpressPack.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/24.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPostExpressPack.h"
#import "BDJPostFrame.h"
#import "BDJPostRenderItem.h"
#import "BDJPictruePostRenderItem.h"

@implementation BDJPostExpressPack

- (id)onMeasureFrameWithItem:(__kindof XFRenderItem *)renderItem index:(NSUInteger)index
{
    CGFloat cellH = 0;
    BDJPostFrame *postFrame = [[BDJPostFrame alloc] init];
    BDJPostRenderItem *postRenderItem = renderItem;
    CGFloat cellContentWidth = ScreenSize.width - R_Size_PostCellMargin * 4;
    
    // 开始计算cell高度
    cellH += R_Height_PostCellClip; // 添加内部裁剪掉的部分
    CGFloat textMaxY = R_Size_PostCellMargin * 2 + R_Height_PostCellHeader;
    CGFloat textH = [postRenderItem.text boundingRectWithSize:CGSizeMake(cellContentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    textMaxY += textH;
    cellH += textMaxY + R_Size_PostCellMargin; // 头部+文本内容高度
    
    // 如果为短图
    if (postRenderItem.type == BDJPostRenderItemTypePictrue ||
        postRenderItem.type == BDJPostRenderItemTypePictrueGIF) {
        // 缩放它的比例
        BDJPictruePostRenderItem *item = renderItem;
        // 获得等比例图高
        CGFloat pictrueH = cellContentWidth * item.height / item.width;
        cellH += pictrueH + R_Size_PostCellMargin; // 添加图片高度
        
        // 计算图片的Frame
        postFrame.pictrueF = CGRectMake(R_Size_PostCellMargin, textMaxY + R_Size_PostCellMargin, cellContentWidth, pictrueH);
        
        // 如果是长图，固定它的高度
    } else if(postRenderItem.type == BDJPostRenderItemTypePictrueLong) {
        cellH += R_Height_PostPictureBreak + R_Size_PostCellMargin;
        postFrame.pictrueF = CGRectMake(R_Size_PostCellMargin, textMaxY + R_Size_PostCellMargin, cellContentWidth, R_Height_PostPictureBreak);
    }
    
    cellH += R_Height_PostCellBottomBar; // 添加帖子工具条高度
    postFrame.cellHeight = cellH;
    return postFrame;
}
@end
