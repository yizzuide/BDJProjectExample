//
//  BDJMeFooterView.m
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/8.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJMeFooterView.h"
#import "BDJSqaureButton.h"
#import "BDJMeEventHandlerPort.h"

@implementation BDJMeFooterView

- (void)setExpressPeices:(NSArray<XFExpressPiece *> *)expressPeices
{
    NSUInteger count = expressPeices.count;
    for (int i = 0; i < count; i++) {
        BDJSqaureButton *button = [[BDJSqaureButton alloc] init];
        [button setExpressPiece:expressPeices[i]];
        [self addSubview:button];
    }
}

@end
