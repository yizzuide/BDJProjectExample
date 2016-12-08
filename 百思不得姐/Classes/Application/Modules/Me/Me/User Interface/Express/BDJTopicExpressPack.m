//
//  BDJTopicExpressPack.m
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/8.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJTopicExpressPack.h"
#import "BDJTopicFrame.h"

@implementation BDJTopicExpressPack

- (id)onMeasureFrameWithItem:(__kindof XFRenderItem *)renderItem index:(NSUInteger)index
{
    NSInteger maxCols = 4;
    CGFloat sqaureW = ScreenSize.width / maxCols;
    CGFloat sqaureH = sqaureW;

    NSInteger row = index / maxCols;
    NSInteger col = index % maxCols;
    CGFloat x = col * sqaureW;
    CGFloat y = row * sqaureH;
    CGRect frame = CGRectMake(x, y, sqaureW, sqaureH);
    
    BDJTopicFrame *topicFrame = [BDJTopicFrame new];
    topicFrame.topicF = frame;
    
    return topicFrame;
}

- (void)onMeasureAfter
{
    NSInteger maxCols = 4;
    CGFloat sqaureW = ScreenSize.width / maxCols;
    CGFloat sqaureH = sqaureW;
    
    // 计算行数类似计算页数：总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
    NSInteger rows = (self.renderData.list.count + maxCols - 1)  / maxCols;
    ((BDJTopicFrame *)self.expressPieces.lastObject.uiFrame).maxH = rows * sqaureH;
}
@end
