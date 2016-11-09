//
//  UIViewController+XFLego.m
//  XFLegoVIPER
//
//  Created by yizzuide on 16/2/24.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "UIViewController+XFLego.h"
#import <objc/runtime.h>
#import "NSObject+XFLegoInvokeMethod.h"
#import "XFInterfaceFactory.h"

@implementation UIViewController (XFLego)

static void * xfActivity_eventHandler_porpertyKey = (void *)@"xfActivity_eventHandler_porpertyKey";
static void * xfActivity_poppingProgrammatically_porpertyKey = (void *)@"xfActivity_poppingProgrammatically_porpertyKey";

- (void)setEventHandler:(id<XFEventHandlerPort>)eventHandler
{
    objc_setAssociatedObject(self, &xfActivity_eventHandler_porpertyKey, eventHandler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (id<XFEventHandlerPort>)eventHandler
{
    return objc_getAssociatedObject(self, &xfActivity_eventHandler_porpertyKey);
}

- (void)setPoppingProgrammatically:(NSNumber *)popingBool
{
     objc_setAssociatedObject(self, &xfActivity_poppingProgrammatically_porpertyKey, popingBool, OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)isPoppingProgrammatically
{
    NSNumber *popingNumber = objc_getAssociatedObject(self, &xfActivity_poppingProgrammatically_porpertyKey);
    return [popingNumber boolValue];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)viewDidLoad
{
    // 如果当前控制器是在当前框架
    if (self.eventHandler) {
        [self setPoppingProgrammatically:[NSNumber numberWithBool:NO]];
        // 绑定当前视图引用到事件处理
        [self.eventHandler invokeMethod:@"xfLego_bindView:" param:self];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.eventHandler) {
        [self.eventHandler invokeMethod:@"viewWillAppear"];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    if (self.eventHandler) {
        [self.eventHandler invokeMethod:@"viewDidAppear"];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.eventHandler) {
        [self.eventHandler invokeMethod:@"viewWillDisappear"];
        // 如果当前视图被pop或dismiss，且不是通过框架方法
        if ((self.isMovingFromParentViewController || self.isBeingDismissed)
            && !self.isPoppingProgrammatically) {
            // 通知事件层当前视图将消失
            [self.eventHandler invokeMethod:@"xfLego_viewWillDisappear"];
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    if (self.eventHandler) {
        [self.eventHandler invokeMethod:@"viewDidDisappear"];
    }
}
#pragma clang diagnostic pop


- (__kindof id<XFUserInterfacePort>)xfLego_subUInterfaceFromModuleName:(NSString *)moduleName
{
    return [XFInterfaceFactory createSubUInterfaceFromModuleName:moduleName parentUInterface:self];
}
@end
