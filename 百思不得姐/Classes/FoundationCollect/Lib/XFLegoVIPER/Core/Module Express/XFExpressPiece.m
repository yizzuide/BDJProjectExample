//
//  XFRenderItem.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/10/20.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFExpressPiece.h"

@implementation XFExpressPiece

// 重新计算
- (void)reMeasureFrame {
    [self.expressPack reMeasureFrameForExpressPiece:self];
}
@end
