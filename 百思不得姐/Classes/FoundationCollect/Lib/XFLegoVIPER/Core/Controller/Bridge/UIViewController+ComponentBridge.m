//
//  UIViewController+ComponentBridge.m
//  XFLegoVIPER
//
//  Created by Yizzuide on 2016/12/19.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "UIViewController+ComponentBridge.h"
#import <objc/runtime.h>
#import "NSObject+XFLegoInvokeMethod.h"

@implementation UIViewController (ComponentBridge)

static void * xfLego_uiBus_porpertyKey = (void *)@"xfLego_uiBus_porpertyKey";
static void * xfLego_eventBus_porpertyKey = (void *)@"xfLego_eventBus_porpertyKey";
static void * xfLego_fromComponentRoutable_porpertyKey = (void *)@"xfLego_fromComponentRoutable_porpertyKey";
static void * xfLego_nextComponentRoutable_porpertyKey = (void *)@"xfLego_nextComponentRoutable_porpertyKey";

- (void)setUiBus:(__kindof XFUIBus *)uiBus
{
    objc_setAssociatedObject(self, &xfLego_uiBus_porpertyKey, uiBus, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XFUIBus *)uiBus
{
    return objc_getAssociatedObject(self, &xfLego_uiBus_porpertyKey);
}

- (void)setEventBus:(__kindof XFEventBus *)eventBus
{
    objc_setAssociatedObject(self, &xfLego_eventBus_porpertyKey, eventBus, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XFEventBus *)eventBus
{
    return objc_getAssociatedObject(self, &xfLego_eventBus_porpertyKey);
}

- (void)setFromComponentRoutable:(id<XFComponentRoutable>)fromComponentRoutable
{
    objc_setAssociatedObject(self, &xfLego_fromComponentRoutable_porpertyKey, fromComponentRoutable, OBJC_ASSOCIATION_ASSIGN);
}

- (id<XFComponentRoutable>)fromComponentRoutable
{
    return objc_getAssociatedObject(self, &xfLego_fromComponentRoutable_porpertyKey);
}

- (void)setNextComponentRoutable:(id<XFComponentRoutable>)nextComponentRoutable
{
    objc_setAssociatedObject(self, &xfLego_nextComponentRoutable_porpertyKey, nextComponentRoutable, OBJC_ASSOCIATION_ASSIGN);
}

- (id<XFComponentRoutable>)nextComponentRoutable
{
    return objc_getAssociatedObject(self, &xfLego_nextComponentRoutable_porpertyKey);
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(viewWillDisappear:);
        SEL swizzledSelector = @selector(componentBridge_viewWillDisappear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

- (void)componentBridge_viewWillDisappear:(BOOL)animated
{
    [self componentBridge_viewWillDisappear:animated];
    if (self.uiBus) {
        // 如果当前视图被pop或dismiss
        if (self.isMovingFromParentViewController || self.isBeingDismissed) {
            // 如果不是通过框架方法
            if (![[self valueForKeyPath:@"poppingProgrammatically"] boolValue]) {
                // 将组件移除
                [self.uiBus invokeMethod:@"xfLego_startRemoveComponentWithTransitionBlock:" param:^(Activity *thisInterface, Activity *nextInterface, TransitionCompletionBlock completionBlock) {
                    completionBlock();
                }];
            }
        }
    }
}

@end
