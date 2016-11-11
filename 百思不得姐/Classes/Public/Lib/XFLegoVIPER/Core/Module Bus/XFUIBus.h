//
//  XFFluctuator.h
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/2.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Activity __kindof UIViewController

// 显示根模块
#define XF_ShowRootRouting2Window_(ModuleName,ExecuteCode) \
[[[XFUIBus alloc] init] showModule:ModuleName onWindow:self.window customCode:^(__kindof XFRouting *routing) { \
    ExecuteCode \
}];
// 快速显示一个根模块
#define XF_ShowRootRouting2Window_Fast(ModuleName) \
XF_ShowRootRouting2Window_(ModuleName,{})

// 显示根组件
#define XF_ShowURLComponent2Window_(url,ExecuteCode) \
[[[XFUIBus alloc] init] openURL:url onWindow:self.window customCode:^(__kindof XFRouting *routing) { \
    ExecuteCode \
}];
// 快速显示一个根组件
#define XF_ShowURLComponent2Window_Fast(url) \
XF_ShowURLComponent2Window_(url,{})

@class XFRouting;
typedef void(^TransitionBlock)(Activity *thisInterface, Activity *nextInterface);
typedef void(^CustomCodeBlock) (__kindof XFRouting *routing);


@interface XFUIBus : NSObject

/**
 *  路由
 */
@property (nonatomic, weak) XFRouting *fromRouting;

/**
 *  初始化方法
 *
 *  @param fromRouting 路由
 *
 *  @return XFFluctuator
 */
- (instancetype)initWithFromRouting:(XFRouting *)fromRouting;

/**
 *  显示一个模块在窗口（注意：这个方法会创建一个根路由，不需要路由调用，这是一个鸡蛋相生的问题！）
 *
 *  @param moduleName       模块名
 *  @param mainWindow       窗口
 *  @param customCodeBlock  自定义配制代码Block
 */
- (void)showModule:(NSString *)moduleName onWindow:(UIWindow *)mainWindow customCode:(CustomCodeBlock)customCodeBlock;

/**
 *  显示一个组件在窗口
 *
 *  @param url             URL
 *  @param mainWindow      窗口
 *  @param customCodeBlock 自定义配制代码Block
 */
- (void)openURL:(NSString *)url onWindow:(UIWindow *)mainWindow customCode:(CustomCodeBlock)customCodeBlock;

/**
 *  推入一个模块
 *
 *  @param moduleName       模块名
 *  @param intentData       意图数据（没有可以传nil）
 *  @param customCodeBlock  自定义配制代码Block
 */
- (void)pushModule:(NSString *)moduleName intent:(id)intentData customCode:(CustomCodeBlock)customCodeBlock;

/**
 *  推出当前视图(注意：返回到上一个界面的意图数据在需要当前模块的Presenter里设置intentData属性）
 */
- (void)popModule;

/**
 *  Modal一个模块
 *
 *  @param moduleName       模块名
 *  @param intentData       意图数据（没有可以传nil）
 *  @param customCodeBlock  自定义配制代码Block
 */
- (void)presentModule:(NSString *)moduleName intent:(id)intentData customCode:(CustomCodeBlock)customCodeBlock;

/**
 *  dismiss当前视图(注意：返回到上一个界面的意图数据需要在当前模块的Presenter里设置intentData属性）
 */
- (void)dismissModule;

/**
 *  以URL组件方式Push
 *
 *  @param url              URL
 *  @param customCodeBlock  自定义配制代码Block
 */
- (void)openURLForPush:(NSString *)url customCode:(CustomCodeBlock)customCodeBlock;
/**
 *  以URL组件方式Present
 *
 *  @param url              URL
 *  @param customCodeBlock  自定义配制代码Block
 */
- (void)openURLForPresent:(NSString *)url customCode:(CustomCodeBlock)customCodeBlock;
/**
 *  自定义打开一个URL组件
 *
 *  @param url             URL
 *  @param trasitionBlock  视图切换代码
 *  @param customCodeBlock 自定义配制代码Block
 */
- (void)openURL:(NSString *)url withTransitionBlock:(TransitionBlock)trasitionBlock customCode:(CustomCodeBlock)customCodeBlock;

/**
 *  自定义展示一个界面
 *
 *  @param moduleName       下一个路由
 *  @param trasitionBlock   视图切换代码
 *  @param intentData       意图数据（没有可以传nil）
 *  @param customCodeBlock  自定义配制代码Block
 */
- (void)putModule:(NSString *)moduleName withTransitionBlock:(TransitionBlock)trasitionBlock intent:(id)intentData customCode:(CustomCodeBlock)customCodeBlock;

/**
 *  自定义移除一个界面
 *
 *  @param trasitionBlock 视图切换代码
 */
- (void)removeModuleWithTransitionBlock:(TransitionBlock)trasitionBlock;

/**
 *  push一个MVx架构里的控制器（注意：它不会被VIPER路由器管理，所以不能对之发VIPER事件通信）
 *
 */
- (void)pushMVxViewController:(UIViewController *)viewController;

/**
 *  present一个MVx架构里的控制器（注意：它不会被VIPER路由器管理，所以不能对之发VIPER事件通信）
 *
 */
- (void)presentMVxViewController:(UIViewController *)viewController;
@end
