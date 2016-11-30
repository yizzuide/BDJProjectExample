//
//  XFRoutingLinkManager.m
//  XFLegoVIPER
//
//  Created by 付星 on 16/9/2.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "NSObject+XFLegoInvokeMethod.h"
#import "XFLegoMarco.h"
#import "XFRouting.h"
#import "XFRoutingLinkManager.h"
#import "XFRoutingReflect.h"


@implementation XFRoutingLinkManager

/**
 *  软引用键值对
 */
static NSMapTable *_mapTable;
/**
 *  有序键
 */
static NSMutableArray *_keyArr;
/**
 *  跟踪一个将要发起跳转动作的路由
 */
static NSHashTable *_trackActionRoutingTable;

/**
 * 存储共享路由
 */
static NSMapTable *_sharedRoutingTable;

+ (void)initialize
{
    if (self == [XFRoutingLinkManager class]) {
        _mapTable = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsWeakMemory];
        _keyArr = [NSMutableArray array];
        
        _trackActionRoutingTable = [NSHashTable weakObjectsHashTable];
        _sharedRoutingTable =[NSMapTable mapTableWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsWeakMemory];
    }
}

#pragma mark - 模块管理
+ (void)addRouting:(XFRouting *)routing {
    NSString *key = _prefix ? [XFRoutingReflect moduleNameForRouting:routing] : NSStringFromClass([routing class]);
    [_mapTable setObject:routing forKey:key];
    [_keyArr addObject:key];
}

+ (void)removeRouting:(XFRouting *)routing {
    NSString *key = _prefix ? [XFRoutingReflect moduleNameForRouting:routing] : NSStringFromClass([routing class]);
    [_mapTable removeObjectForKey:key];
    [_keyArr removeObject:key];
}

+ (NSInteger)count
{
    return _mapTable.count;
}

+ (void)setCurrentActionRounting:(XFRouting *)routing
{
    [_trackActionRoutingTable removeAllObjects];
    [_trackActionRoutingTable addObject:routing];
}

+ (XFRouting *)currentActionRouting
{
    return [_trackActionRoutingTable anyObject];
}

+ (void)setSharedRounting:(XFRouting *)routing shareModule:(NSString *)moduleName
{
    [_sharedRoutingTable setObject:routing forKey:moduleName];
}

+ (XFRouting *)sharedRoutingForShareModule:(NSString *)moduleName
{
    if (!moduleName) return nil;
    return [_sharedRoutingTable objectForKey:moduleName];
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

#pragma mark - 模块前辍
static NSString *_prefix;
+ (void)setModulePrefix:(NSString *)prefix
{
    _prefix = prefix;
}

+ (NSString *)modulePrefix
{
    return _prefix;
}

#pragma mark - Debug
static BOOL _enableLog = NO;
+ (void)enableLog {
    _enableLog = YES;
}

+ (void)log {
#ifdef DEBUG
    if (_enableLog) {
#ifdef LogDebug
        LogDebug(@"current routing count: %zd",_mapTable.count);
        LogDebug(@"Routing link:");
#elif (defined DEBUG)
        NSLog(@"current routing count: %zd",_mapTable.count);
        NSLog(@"Routing link:");
#endif
        
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
            NSString *firstFix = [NSString stringWithFormat:@"\nRoot Routing(%zd): (\n\t%@",routingCount,NSStringFromClass([routing class])];
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
#ifdef LogDebug
        LogDebug(@"%@",logStrM);
#elif (defined DEBUG)
        NSLog(@"%@",logStrM);
#endif
    }
#endif
}

@end
