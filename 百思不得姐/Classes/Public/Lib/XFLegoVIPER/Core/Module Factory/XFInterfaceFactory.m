//
//  XFInterfaceFactory.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/10/5.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFInterfaceFactory.h"
#import "XFRoutingFactory.h"
#import "XFActivity.h"
#import "XFLegoMarco.h"
#import "NSObject+XFLegoInvokeMethod.h"

@implementation XFInterfaceFactory

+ (__kindof id<XFUserInterfacePort>)createSubUInterfaceFromModuleName:(NSString *)moduleName parentUInterface:(__kindof id<XFUserInterfacePort>)parentUInterface
{
    XFActivity *parentActivity = parentUInterface;
    XFRouting *parentRouting;
    SuppressPerformSelectorLeakWarning(
        parentRouting = [parentActivity.eventHandler performSelector:@selector(routing)];                             )
    return [XFRoutingFactory createSubRoutingFromModuleName:moduleName forParentRouting:parentRouting].realInterface;
}

+ (__kindof id<XFUserInterfacePort>)createUInterfaceForMVxFromModuleName:(NSString *)moduleName asChildViewController:(BOOL)asChild
{
    XFRouting *routing = [XFRoutingFactory createRouingFromModuleName:moduleName];
    if (asChild) {
        routing.subRoute = YES;
    }
    return routing.realInterface;
}
@end
