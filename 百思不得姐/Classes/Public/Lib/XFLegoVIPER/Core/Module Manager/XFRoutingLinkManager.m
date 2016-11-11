//
//  XFRoutingLinkManager.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/9/2.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "NSObject+XFLegoInvokeMethod.h"
#import "XFLegoMarco.h"
#import "XFRouting.h"
#import "XFRoutingLinkManager.h"


@implementation XFRoutingLinkManager

/**
 *  软引用键值对
 */
static NSMapTable *_mapTable;
/**
 *  有序键
 */
static NSMutableArray *_keyArr;

+ (void)initialize
{
    if (self == [XFRoutingLinkManager class]) {
        _mapTable = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsWeakMemory];
        _keyArr = [NSMutableArray array];
    }
}

#pragma mark - 模块管理
+ (void)addRouting:(XFRouting *)routing {
    NSString *key = _prefix ? [self moduleNameForRouting:routing] : NSStringFromClass([routing class]);
    [_mapTable setObject:routing forKey:key];
    [_keyArr addObject:key];
}

+ (void)resetSubRoutings:(NSArray *)subRoutings parentRouting:(XFRouting *)parent
{
    
}

+ (void)removeRouting:(XFRouting *)routing {
    NSString *key = _prefix ? [self moduleNameForRouting:routing] : NSStringFromClass([routing class]);
    [_mapTable removeObjectForKey:key];
    [_keyArr removeObject:key];
}

+ (NSInteger)count
{
    return _mapTable.count;
}

#pragma mark - 模块通信
+ (void)sendEventName:(NSString *)eventName intentData:(id)intentData forModulesName:(NSArray<NSString *> *)modulesName
{
    for (NSString *moduleName in modulesName) {
        // 找到对应模块路由
        XFRouting *routing = [self findRoutingForModuleName:moduleName];
        // 通知路由发送事件
        [routing.eventBus invokeMethod:@"_sendEventName:intentData:" param1:eventName param2:intentData];
    }
}

#pragma mark - 模块查找
+ (XFRouting *)findRoutingForModuleName:(NSString *)moduleName {
    NSEnumerator *keys = _mapTable.keyEnumerator;
    for (NSString *key in keys) {
        BOOL condition = _prefix ? [key isEqualToString:moduleName] : [key containsString:moduleName];
        if (condition) {
            return [_mapTable objectForKey:key];
        }
    }
    return nil;
}

+ (NSString *)moduleNameForRouting:(XFRouting *)routing
{
    NSArray *simpleSuffix = @[@"Routing",@"Route",@"Router"];
    NSString *clazzName = NSStringFromClass([routing class]);
    
    NSUInteger index = XF_Index_First;
    NSRange suffixRange;
    do {
        if (index == simpleSuffix.count) {
            return clazzName;
        }
        suffixRange = [clazzName rangeOfString:simpleSuffix[index++]];
    } while (suffixRange.location <= XF_Index_First);
    
    NSRange moduleRange = NSMakeRange(_prefix.length, suffixRange.location - _prefix.length);
    NSString *moduleName = [clazzName substringWithRange:moduleRange];
    return moduleName;
}

+ (BOOL)verifyModule:(NSString *)moduleName
{
    NSString *modulePrefix = [self modulePrefix];
    return !!NSClassFromString([NSString stringWithFormat:@"%@%@Routing",modulePrefix,moduleName]);
}

+ (BOOL)verifyModuleLinkForList:(NSArray<NSString *> *)modules
{
    // 只有一个路由，直接返回
    if (modules.count == 1) {
        return YES;
    }

    XFRouting *preRouting = [self findRoutingForModuleName:modules[XF_Index_First]];
    if (!preRouting) {
        return NO;
    }
    for (int i = XF_Index_Second; i < modules.count; i++) {
        XFRouting *nextRouting = [self findRoutingForModuleName:modules[i]];
        // 忽略最后一个可能没有添加上的路由
        if (i == modules.count - 1 && !nextRouting) {
            return YES;
        }
        // 如果下一个路由找不到
        if (!nextRouting) {
            return NO;
        }
        // 判断父子关系
        if (nextRouting.parentRouting == preRouting) {
            preRouting = nextRouting;
            continue;
        }
        // 判断链路关系
        if (preRouting.nextRouting != nextRouting) {
            return  NO;
        }
        // 以下一个路由为起点
        preRouting = nextRouting;
    }
    return YES;
}

#pragma mark - 模块前辍
static NSString *_prefix;
+ (void)setModulePrefix:(NSString *)prefix
{
    _prefix = prefix;
}

+ (NSString *)modulePrefix
{
    if (_prefix == nil) {
        NSLog(@"!!!!!!!!!!!!!!!! XFLegoVIPER !!!!!!!!!!!!!!!!!!!!!");
        NSLog(@"!! 模块没有设置过前辍！请在应用初始完成方法里调用：!!!!!!!!");
        NSLog(@"!! [XFRouttingLinkManager setModulePrefix:] !!!!!!");
        NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
    NSAssert(_prefix, @"当前使用的功能正在访问前辍，但没有设置过模块前辍！");
    return _prefix;
}

#pragma mark - Debug
static BOOL _enableLog = NO;
+ (void)enableLog {
    _enableLog = YES;
}

+ (void)log {
    if (_enableLog) {
        NSLog(@"current routing count: %zd",_mapTable.count);
        NSLog(@"Routing link:");
        
        NSMutableString *logStrM = [NSMutableString string];
        NSUInteger count = _keyArr.count;
        NSUInteger routingCount = 0;
        NSUInteger subRoutingCount = 0;
        for (int i = 0; i < count; i++) {
            XFRouting *routing = [_mapTable objectForKey:_keyArr[i]];
            // 过滤掉非根路由
            if (routing.previousRouting) {
                break;
            }
            NSString *firstFix = [NSString stringWithFormat:@"\nRoot Routing(%zd): (\n\t%@",routingCount,NSStringFromClass([routing class])];;
            routingCount++;
            if (routing.isSubRoute && routing.parentRouting) {
                firstFix = [NSString stringWithFormat:@"\nSub Routing from %@(%zd): (\n\t%@",NSStringFromClass([routing.parentRouting class]),subRoutingCount,NSStringFromClass([routing class])];
                routingCount--;
                subRoutingCount++;
            }
            [logStrM appendString:firstFix];
            
            XFRouting *nextRouting = routing;
            NSUInteger subRoutingDepthCount = 1;
            do {
                // 打印子路由
                NSArray<XFRouting *> *childRoutings = [nextRouting valueForKey:@"_childRoutings"];
                if (childRoutings) {
                    [logStrM appendString:@"\n"];
                    for (NSUInteger t = 0; t < subRoutingDepthCount; t++) {
                        [logStrM appendString:@"\t"];
                    }
                    [logStrM appendString:@"Sub Routing: ("];
                    for (XFRouting *subRouting in childRoutings) {
                        [logStrM appendString:@"\n"];
                        for (NSUInteger t = 0; t < subRoutingDepthCount * 2; t++) {
                            [logStrM appendString:@"\t"];
                        }
                        [logStrM appendString:[NSString stringWithFormat:@"%@",NSStringFromClass([subRouting class])]];
                    }
                    [logStrM appendString:@"\n"];
                    for (NSUInteger t = 0; t < subRoutingDepthCount; t++) {
                        [logStrM appendString:@"\t"];
                    }
                    [logStrM appendString:@")"];
                    
                    subRoutingDepthCount++;
                }
                
                // 打印下一个关连的路由
                nextRouting = nextRouting.nextRouting;
                if (nextRouting != nil) {
                    [logStrM appendString:[NSString stringWithFormat:@"\n\t-> %@",NSStringFromClass([nextRouting class])]];
                    continue;
                }
                [logStrM appendString:@"\n)"];
            } while (nextRouting != nil);
        }
        NSLog(@"%@",logStrM);
    }
}

@end
