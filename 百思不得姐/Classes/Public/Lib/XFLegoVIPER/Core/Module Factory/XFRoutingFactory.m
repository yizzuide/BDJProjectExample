//
//  XFRoutingFactory.m
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/2.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFRoutingFactory.h"
#import "XFRoutingLinkManager.h"

@implementation XFRoutingFactory

+ (XFRouting *)createRouingFromModuleName:(NSString *)moduleName {
    // 返回已经创建的模块视图
    XFRouting *routing = [XFRoutingLinkManager findRoutingForModuleName:moduleName];
    if (routing) {
        return routing;
    }
    // 从新创建
    return [self createRoutingFastFromModuleName:moduleName];
}

+ (XFRouting *)createRoutingFastFromModuleName:(NSString *)moduleName {
    // 查找并实例化
    NSString *prefixName = [XFRoutingLinkManager modulePrefix];
    if (prefixName == nil) return nil;
    NSString *routingClassName = [NSString stringWithFormat:@"%@%@%@",prefixName,moduleName,@"Routing"];
    Class routingClass = NSClassFromString(routingClassName);
    if (routingClass) {
        return [routingClass routing];
    }
    return nil;
}

+ (XFRouting *)createSubRoutingFromModuleName:(NSString *)moduleName forParentRouting:(XFRouting *)parentRouting {
    XFRouting *subRouting = [self createRouingFromModuleName:moduleName];
    if (subRouting == nil) {
        Class routingClass;
        NSString *clazzName = NSStringFromClass([parentRouting class]);
        NSUInteger findIndex = XF_Index_Second;
        NSString *prefixName;
        do {
            if (findIndex > clazzName.length * 0.5) return nil;
            prefixName = [clazzName substringToIndex:findIndex++];
            NSString *routingClassName = [NSString stringWithFormat:@"%@%@%@",prefixName,moduleName,@"Routing"];
            routingClass = NSClassFromString(routingClassName);
            if (routingClass) {
                subRouting = [routingClass routing];
                break;
            }
        } while (1);
    }
    [parentRouting addSubRouting:subRouting asChildViewController:NO];
    return subRouting;
}
@end
