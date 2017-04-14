//
//  BDJTopicTagViewModel.m
//  百思不得姐
//
//  Created by Yizzuide on 2017/2/13.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import "BDJTopicTagViewModel.h"
#import "BDJTopicTagViewProtocol.h"

@implementation BDJTopicTagViewModel

- (void)initRenderView
{
    LogInfo(@"接收到旧标签数据：%@",self.componentData);
    self.expressData = self.componentData;
}

- (void)backActionWithTagArray:(NSArray<NSString *> *)tagNames
{
    // 设置回传数据
    // 这里做了优化：当前标签没有改变时，self.intentData依然是空，上一个组件就不会调用-onNewIntent:方法，从而不会再渲染UI
    self.intentData =  [self.componentData isEqual:tagNames] ? nil : tagNames;
    [self.uiBus popComponent];
}
@end
