//
//  XFRoutingFactory.h
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/2.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFRouting.h"

@interface XFRoutingFactory : NSObject
/**
 *  根据模块名创建一个路由对象（带缓存）
 *
 *  @param moduleName 模块名
 *
 *  @return 路由
 */
+ (XFRouting *)createRouingFromModuleName:(NSString *)moduleName;
/**
 *  根据模块名快速创建一个新的路由对象
 *
 *  @param moduleName 模块名
 *
 *  @return 路由
 */
+ (XFRouting *)createRoutingFastFromModuleName:(NSString *)moduleName;
/**
 *  根据模块名和父路由创建一个子路由对象（带缓存）
 *
 *  @param moduleName    模块名
 *  @param parentRouting 父路由
 *
 *  @return 子路由
 */
+ (XFRouting *)createSubRoutingFromModuleName:(NSString *)moduleName forParentRouting:(XFRouting *)parentRouting;
@end
