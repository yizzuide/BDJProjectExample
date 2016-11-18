//
//  XFRoutingLinkManager.h
//  XFLegoVIPERExample
//
//  Created by 付星 on 16/9/2.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

// 从MVx架构向VIPER模块发事件
#define XF_SendEventFormMVxForVIPERModules_(modulesName,eventName,sendData) \
[XFRoutingLinkManager sendEventName:eventName intentData:sendData forModulesName:modulesName];

@protocol XFUserInterfacePort;
@class XFRouting;
@interface XFRoutingLinkManager : NSObject
/**
 *  添加一个路由
 *
 *  @param routing 路由
 */
+ (void)addRouting:(XFRouting *)routing;
/**
 *  移除一个路由
 *
 *  @param routing 路由
 */
+ (void)removeRouting:(XFRouting *)routing;

/**
 *  总数
 *
 *  @return 路由个数
 */
+ (NSInteger)count;

/**
 *  根据模块名查找对应路由
 *
 *  @param moduleName 模块名
 *
 *  @return 路由
 */
+ (XFRouting *)findRoutingForModuleName:(NSString *)moduleName;

/**
 *  对VIPER架构模块发送事件数据
 *
 *  @param eventName  事件名
 *  @param intentData 消息数据
 *  @param modulesName 模块名数组
 */
+ (void)sendEventName:(NSString *)eventName intentData:(id)intentData forModulesName:(NSArray<NSString *> *)modulesName;

/**
 *  设置模块前辍，让模块查找更佳精准，避免模块与子模块有部分位置名相同查找错误问题
 *  注意：
    1.要设置就在第一个模块加载前设置,不然后面模块搜索会出问题，要么就不要设置
    2.设置了前辍后，模块路由类必须以"Routing"结尾，否则内部会找不到对应模块
 *
 */
+ (void)setModulePrefix:(NSString *)prefix;
/**
 *  返回模块前辍
 *
 */
+ (NSString *)modulePrefix;

/**
 *  获得一个路由的模块名
 *
 *  @param routing 路由
 *
 *  @return 模块名
 */
+ (NSString *)moduleNameForRouting:(XFRouting *)routing;
/**
 *  验证一个模块是否存在
 *
 *  @param moduleName 模块名
 *
 *  @return 模块是否存在
 */
+ (BOOL)verifyModule:(NSString *)moduleName;
/**
 *  验证模块关系链
 *
 *  @param modules 模块名数组
 *
 *  @return 模块关系链是否正确
 */
+ (BOOL)verifyModuleLinkForList:(NSArray<NSString *> *)modules;

/**
 *  允许打印log
 */
+ (void)enableLog;

/**
 *  打印当前所有路由信息
 */
+ (void)log;
@end
