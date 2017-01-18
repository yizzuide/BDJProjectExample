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
#import "BDJPicturePostRenderItem.h"

@implementation BDJPostExpressPack

- (id)onMeasureFrameWithItem:(__kindof XFRenderItem *)renderItem index:(NSUInteger)index
{
    BDJPostFrame *postFrame = [[BDJPostFrame alloc] init];
    BDJPostRenderItem *postRenderItem = renderItem;
    CGFloat cellContentWidth = ScreenSize.width - R_Size_PostCellMargin * 4;
    
    CGFloat cellH; // cell累加高度
    // 初始化固定的高度
    CGFloat cellTopH = R_Height_PostCellClip; // cell被裁剪的高度
    CGFloat cellHeaderH =  R_Size_PostCellMargin + R_Height_PostCellHeader; // 头部高
    CGFloat cellBottomH = R_Size_PostCellMargin + R_Height_PostCellBottomBar; // 底部高
    
    // 添加顶部高
    cellH = cellTopH + cellHeaderH;
    // 计算文本
    CGFloat textH = [postRenderItem.text boundingRectWithSize:CGSizeMake(cellContentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    CGFloat textMaxY = cellHeaderH + R_Size_PostCellMargin + textH;
    // 添加文本高
    cellH += R_Size_PostCellMargin + textH;
    
    // 如果是图片子类型
    if ([renderItem isKindOfClass:[BDJPicturePostRenderItem class]]) {
        // 如果是长图，固定它的高度
        if(postRenderItem.type == BDJPostRenderItemTypePictureLong) {
            postFrame.pictureF = CGRectMake(R_Size_PostCellMargin, textMaxY + R_Size_PostCellMargin, cellContentWidth, R_Height_PostPictureBreak);
        } else {
            // 缩放它的比例
            BDJPicturePostRenderItem *item = renderItem;
            // 获得等比例图高
            CGFloat PictureH = cellContentWidth * item.height / item.width;
            
            // 计算图片的Frame
            postFrame.pictureF = CGRectMake(R_Size_PostCellMargin, textMaxY + R_Size_PostCellMargin, cellContentWidth, PictureH);
        }
        // 图片高
        cellH += R_Size_PostCellMargin + postFrame.pictureF.size.height;
    }
    
    // 最热一条评论
    if (postRenderItem.hotCmtContent) {
        cellH += [@"最热评论" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].height;
        CGFloat topCmtH = [postRenderItem.hotCmtRenderContent boundingRectWithSize:CGSizeMake(cellContentWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        cellH += R_Size_PostCellMargin + topCmtH;
    }
    
    // 添加底部高度
    postFrame.cellHeight = cellH + cellBottomH;
    return postFrame;
}
@end
