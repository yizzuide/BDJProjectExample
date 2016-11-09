//
//  XFEventHandlerPort.h
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/21.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#ifndef XFEventHandlerPort_h
#define XFEventHandlerPort_h

@class XFExpressPack;
@protocol XFEventHandlerPort <NSObject>

/**
 *  快速任意填充数据
 */
@property (nonatomic, strong) id expressData NS_DEPRECATED_IOS(0.0.1,3.0,"Use 'expressPack' instead.");
/**
 * 视图表达对象
 *
 */
@property (nonatomic, strong) XFExpressPack *expressPack;

/**
 *  错误消息
 */
@property (nonatomic, copy) NSString *errorMessage;

/**
 *  返回按钮被点击的处理方法（子类可以覆盖这个方法实现自己的逻辑）
 */
- (void)xfLego_onBackItemTouch;
@end


#endif /* XFEventHandlerPort_h */
