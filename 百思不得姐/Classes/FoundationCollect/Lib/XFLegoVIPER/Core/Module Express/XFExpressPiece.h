//
//  XFRenderItem.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/10/20.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFRenderItem.h"
#import "XFExpressPack.h"

// 重新计算子视图渲染数据的Frame
#define XF_ReMeasure_ExpressPiece() \
[self.expressPiece reMeasureFrame];

/**
 *  列表单个数据包，这个不需要自定义扩展
 */
@class XFExpressPack;
@interface XFExpressPiece : NSObject

/**
 *  所属数据包
 */
@property (nonatomic, weak) XFExpressPack *expressPack;
/**
 *  渲染数据
 */
@property (nonatomic, strong) __kindof XFRenderItem *renderItem;
/**
 *  视图Frame
 */
@property (nonatomic, strong) id uiFrame;

/**
 *  重新计算子视图渲染数据的Frame
 */
- (void)reMeasureFrame;
@end
