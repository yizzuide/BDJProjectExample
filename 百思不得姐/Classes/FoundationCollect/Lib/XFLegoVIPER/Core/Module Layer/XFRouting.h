//
//  XFWireframe.h
//  XFLegoVIPER
//
//  Created by yizzuide on 15/12/22.
//  Copyright © 2015年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFWireFramePort.h"
#import "XFUIOperatorPort.h"
#import "XFLegoMarco.h"
#import "XFUIBus.h"
#import "XFModuleAssembly.h"

// 快速获取当前模块视图
#define MainActivity LEGORealInterface(self.realInterface)

// 获取一个类的类
#define XF_Class_(Class) [Class class]

// 快速注入模块成分-导航方式
#define XF_InjectModuleWith_Nav(_NavigatorClass_,_ActivityClass_,_PresenterClass_,_InteractorClass_,_DataManagerClass_) \
+ (instancetype)routing \
{ \
    return [[super routing].assembly buildModulesAssemblyWithActivityClass:_ActivityClass_ \
                                                   navigatorClass:_NavigatorClass_ \
                                                   presenterClass:_PresenterClass_ \
                                                  interactorClass:_InteractorClass_ \
                                                 dataManagerClass:_DataManagerClass_]; \
}
// 快速注入模块成分-子界面方式
#define XF_InjectModuleWith_Act(_ActivityClass_,_PresenterClass_,_InteractorClass_,_DataManagerClass_) \
XF_InjectModuleWith_Nav(nil,_ActivityClass_,_PresenterClass_,_InteractorClass_,_DataManagerClass_)
// 快速注入模块成分-ib方式
#define XF_InjectModuleWith_IB(ibSymbol,_PresenterClass_,_InteractorClass_,_DataManagerClass_) \
+ (instancetype)routing \
{ \
    return [[super routing].assembly buildModulesAssemblyWithIB:ibSymbol presenterClass:_PresenterClass_ interactorClass:_InteractorClass_ dataManagerClass:_DataManagerClass_]; \
}


// 自动组装模块成分
#define XF_AutoAssemblyModule(NavName,IBSymbol,ShareDataManagerName) \
+ (void)load \
{ \
    [XFRoutingLinkManager analysisModulePrefixFromClass:self]; \
} \
+ (instancetype)routing \
{ \
    return [[super routing].assembly autoAssemblyModuleWithNav:NavName ibSymbol:IBSymbol shareDataManagerName:ShareDataManagerName]; \
}
// 自动组装一个无Nav的模块成分
#define XF_AutoAssemblyModule_ShareDM(ShareDataManagerName) XF_AutoAssemblyModule(nil,nil,ShareDataManagerName)
#define XF_AutoAssemblyModule_Fast XF_AutoAssemblyModule_ShareDM(nil)

// 自动组装一个有Nav模块成分
#define XF_AutoAssemblyModuleWithNav_ShareDM(NavName,ShareDataManagerName) XF_AutoAssemblyModule(NavName,nil,ShareDataManagerName)
#define XF_AutoAssemblyModuleWithNav(NavName) XF_AutoAssemblyModuleWithNav_ShareDM(NavName,nil)
// 根据项目模块前辍自动组装一个有Nav模块成分
#define XF_AutoAssemblyModuleWithNav_Fast \
+ (instancetype)routing \
{ \
    return [[super routing].assembly autoAssemblyModuleWithPrefixNav]; \
}

// 自动组装一个IBSymbol的模块成分
#define XF_AutoAssemblyModuleFormIB_ShareDM(IBSymbol,ShareDataManagerName) XF_AutoAssemblyModule(nil,IBSymbol,ShareDataManagerName)
#define XF_AutoAssemblyModuleFormIB(IBSymbol) XF_AutoAssemblyModuleFormIB_ShareDM(IBSymbol,nil)


// 自动组装一个基于其它模块成分类型的模块
#define XF_AutoAssemblyModuleFromShareModuleName(shareModuleName) \
+ (instancetype)routing \
{ \
    XFRouting *routing = [[self alloc] init]; \
    [routing setValue:[[XFModuleAssembly alloc] initWithFromRouting:routing] forKey:@"assembly"]; \
    [routing setValue:[[XFUIBus alloc] initWithFromRouting:routing] forKey:@"uiBus"]; \
    [routing setValue:[[XFEventBus alloc] initWithFromRouting:routing] forKey:@"eventBus"]; \
    return [routing.assembly autoAssemblyModuleFromShareModuleName:shareModuleName]; \
}



// 模块名方式（不适用于MVx）
// Push一个模块宏
#define XF_PUSH_Routing_(ModuleName,ExecuteCode) \
XF_Define_Weak \
[self.uiBus pushModule:ModuleName intent:self.uiOperator.intentData customCode:^(__kindof XFRouting *routing) { \
    XF_Define_Strong \
    ExecuteCode \
    [self self]; \
}];
// 快速Push一个模块
#define XF_PUSH_Routing_Fast(ModuleName) \
XF_PUSH_Routing_(ModuleName,{})

// Present一个模块宏
#define XF_Present_Routing_(ModuleName,ExecuteCode) \
XF_Define_Weak \
[self.uiBus presentModule:ModuleName intent:self.uiOperator.intentData customCode:^(__kindof XFRouting *routing) { \
    XF_Define_Strong \
    ExecuteCode \
    [self self]; \
}];
// 快速Present一个模块
#define XF_Present_Routing_Fast(ModuleName) \
XF_Present_Routing_(ModuleName,{})


// URL组件方式（这种方式适用于MVx、VIPER）
// Push一个URL组件
#define XF_PUSH_URLComponent_(urlString,ExecuteCode) \
XF_Define_Weak \
[self.uiBus openURLForPush:urlString customCode:^(__kindof XFRouting *routing) { \
    XF_Define_Strong \
    ExecuteCode \
    [self self]; \
}];
// 快速Push一个URL组件
#define XF_PUSH_URLComponent_Fast(urlString) \
XF_PUSH_URLComponent_(urlString,{})

// Present一个URL组件
#define XF_Present_URLComponent_(urlString,ExecuteCode) \
XF_Define_Weak \
[self.uiBus openURLForPresent:urlString customCode:^(__kindof XFRouting *routing) { \
    XF_Define_Strong \
    ExecuteCode \
    [self self]; \
}];
// 快速Present一个URL组件
#define XF_Present_URLComponent_Fast(urlString) \
XF_Present_URLComponent_(urlString,{})

@class XFUIBus;
@interface XFRouting : NSObject <XFWireFramePort>

/**
 *  模块组装器
 */
@property (nonatomic, strong, readonly) XFModuleAssembly *assembly;
/**
 *  UI总线
 */
@property (nonatomic, strong, readonly) XFUIBus *uiBus;
/**
 *  事件总线
 */
@property (nonatomic, strong, readonly) XFEventBus *eventBus;

/**
 *  事件处理层（Presenter）
 */
@property (nonatomic, weak, readonly) __kindof id<XFUIOperatorPort> uiOperator;

/**
 *  上一个关联的模块路由
 */
@property (nonatomic, strong, readonly) __kindof XFRouting *previousRouting;
/**
 *  下一个关联的模块路由
 */
@property (nonatomic, strong, readonly) __kindof XFRouting *nextRouting;

/**
 *  父路由
 */
@property (nonatomic, weak, readonly) __kindof XFRouting *parentRouting;

/**
 *  当前是否是子路由
 */
@property (nonatomic, assign, getter=isSubRoute) BOOL subRoute;

/**
 *  子路由
 */
@property (nonatomic, strong, readonly) NSMutableArray<__kindof XFRouting *> *childRoutings;

/**
 *  组装当前路由
 *
 *  @return 路由
 */
+ (instancetype)routing;

/**
 *  添加子路由
 *
 *  @param subRouting 子路由
 *  @param asChild    是否自动添加子控制器
 *
 */
- (void)addSubRouting:(XFRouting *)subRouting asChildViewController:(BOOL)asChild;

/**
 *  获得当前真实存在的视图
 *
 *  @return 视图
 */
- (__kindof id<XFUserInterfacePort>)realInterface;
/**
 *  获得包装当前视图的导航
 *
 *  @return 导航
 */
- (__kindof UINavigationController *)realNavigator;
@end
