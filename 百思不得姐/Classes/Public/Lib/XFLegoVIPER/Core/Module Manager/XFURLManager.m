//
//  XFURLManager.m
//  XFLegoVIPERExample
//
//  Created by 付星 on 2016/11/7.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFURLManager.h"
#import "XFURLParse.h"
#import "XFLegoMarco.h"
#import "XFRoutingLinkManager.h"

@implementation XFURLManager

static NSMutableDictionary<NSString *,NSString *> *_mapTable;

+ (void)initialize
{
    if (self == [XFURLManager class]) {
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
    NSString *lcModuleName = [XFURLParse lastPathComponentForURL:url];
    if (lcModuleName.length > 2) {
        NSString *moduleName = [NSString stringWithFormat:@"%@%@",[lcModuleName substringToIndex:XF_Index_Second].uppercaseString,[lcModuleName substringFromIndex:XF_Index_Second]];
        [self register:url forModule:moduleName];
    } else {
        [self register:url forModule:lcModuleName.uppercaseString];
    }
}

+ (void)register:(NSString *)url forModule:(NSString *)moduleName
{
    NSAssert([XFRoutingLinkManager verifyModule:moduleName], @"模块验证失败！找不到此模块！");
    [_mapTable setObject:moduleName forKey:url];
}

+ (void)remove:(NSString *)url
{
    [_mapTable removeObjectForKey:url];
}

+ (BOOL)open:(NSString *)url transitionBlock:(void(^)(NSString *moduleName,NSDictionary *params))transitionBlock
{
    NSString *path = [XFURLParse pathForURL:url];
    NSString *moduleName = [_mapTable objectForKey:path];
    NSAssert(moduleName || ![moduleName isEqualToString:@""], @"当前URL未注册任何组件！");
    NSDictionary *params;
    if([url hasPrefix:@"http"])
        params = @{@"url":url};
    else
        params = [XFURLParse paramsForURL:url];
    if(transitionBlock)
        transitionBlock(moduleName,params);
    
    // 异步检测URL路径的正确性
    if ([XFRoutingLinkManager count]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSArray *allComps = [XFURLParse allComponentsForURL:url];
            NSMutableArray *modules = @[].mutableCopy;
            for (NSString *comp in allComps) {
                NSString *moduleName = [NSString stringWithFormat:@"%@%@",[comp substringToIndex:XF_Index_Second].uppercaseString,[comp substringFromIndex:XF_Index_Second]];
                [modules addObject:moduleName];
            }
            BOOL isURLComponentLinkOk = [XFRoutingLinkManager verifyModuleLinkForList:modules];
            NSAssert(isURLComponentLinkOk, @"URL子路径关系链错误！");
        });
    }
    return !!moduleName;
}
@end
