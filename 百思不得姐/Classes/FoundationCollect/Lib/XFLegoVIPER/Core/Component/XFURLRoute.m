//
//  XFURLRoute.m
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/7.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFURLRoute.h"
#import "XFURLParse.h"
#import "XFLegoMarco.h"
#import "XFControllerFactory.h"
#import "XFRoutingLinkManager.h"
#import "XFRoutingReflect.h"

@implementation XFURLRoute

static NSMutableDictionary<NSString *,NSString *> *_mapTable;

+ (void)initialize
{
    if (self == [XFURLRoute class]) {
        _mapTable = @{}.mutableCopy;
    }
}

+ (void)initURLGroup:(id)urlGroup {
    if ([urlGroup isKindOfClass:[NSDictionary class]]) {
        [_mapTable setDictionary:urlGroup];
    } else if([urlGroup isKindOfClass:[NSArray class]]) {
        for (NSString *url in urlGroup) {
            [self register:url];
        }
    } else {
        NSAssert(NO, @"参数必需是NSDictionary类型或NSArray类型！");
    }
}

// xf://user/register?usrid=123
+ (void)register:(NSString *)url
{
    NSString *lcComponentName = [XFURLParse lastPathComponentForURL:url];
    if (lcComponentName.length > 2) {
        NSString *componentName = [NSString stringWithFormat:@"%@%@",[lcComponentName substringToIndex:XF_Index_Second].uppercaseString,[lcComponentName substringFromIndex:XF_Index_Second]];
        [self register:url forComponent:componentName];
    } else {
        [self register:url forComponent:lcComponentName.uppercaseString];
    }
}

+ (void)register:(NSString *)url forComponent:(NSString *)componentName
{
    // 验证是否是控制器组件
    if ([XFControllerFactory isViewControllerComponent:componentName]){
        [_mapTable setObject:componentName forKey:url];
    }else{
        NSAssert([XFRoutingReflect verifyModule:componentName], @"模块验证失败！找不到此模块！");
        [_mapTable setObject:componentName forKey:url];
    }
}

+ (void)remove:(NSString *)url
{
    [_mapTable removeObjectForKey:url];
}

+ (BOOL)open:(NSString *)url transitionBlock:(void(^)(NSString *componentName,NSDictionary *params))transitionBlock
{
    NSString *path = [XFURLParse pathForURL:url];
    NSString *componentName = [_mapTable objectForKey:path];
    NSAssert(componentName || ![componentName isEqualToString:@""], @"当前URL组件未注册！");
    NSDictionary *params;
    if([url hasPrefix:@"http"])
        params = @{@"url":url};
    else
        params = [XFURLParse paramsForURL:url];
    if(transitionBlock)
        transitionBlock(componentName,params);
    
    if ([XFControllerFactory isViewControllerComponent:componentName]) return YES;
    // 异步检测URL路径的正确性
    if ([XFRoutingLinkManager count]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSArray *allComps = [XFURLParse allComponentsForURL:url];
            NSMutableArray *modules = @[].mutableCopy;
            for (NSString *comp in allComps) {
                NSString *moduleName = [NSString stringWithFormat:@"%@%@",[comp substringToIndex:XF_Index_Second].uppercaseString,[comp substringFromIndex:XF_Index_Second]];
                [modules addObject:moduleName];
            }
            BOOL isURLComponentLinkOk = [XFRoutingReflect verifyModuleLinkForList:modules];
            NSAssert(isURLComponentLinkOk, @"URL子路径关系链错误！");
        });
    }
    return !!componentName;
}
@end
