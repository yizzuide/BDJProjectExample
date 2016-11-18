//
//  XFFluctuator.m
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/2.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "NSObject+XFLegoInvokeMethod.h"
#import "XFUIBus.h"
#import "XFRouting.h"
#import "XFRoutingFactory.h"
#import "XFURLManager.h"
#import "XFControllerFactory.h"

@interface XFUIBus ()
/**
 *  根路由
 */
@property (nonatomic, strong) XFRouting *rootRouting;
@end

@implementation XFUIBus

- (instancetype)initWithFromRouting:(XFRouting *)fromRouting
{
    self = [super init];
    if (self) {
        self.fromRouting = fromRouting;
    }
    return self;
}

#pragma mark - URL组件方式

- (void)openURL:(NSString *)url onWindow:(UIWindow *)mainWindow customCode:(CustomCodeBlock)customCodeBlock
{
    [XFURLManager open:url transitionBlock:^(NSString *moduleName, NSDictionary *params) {
        [self showModule:moduleName onWindow:mainWindow customCode:customCodeBlock];
    }];
}

// 以URL组件式PUSH
- (void)openURLForPush:(NSString *)url customCode:(CustomCodeBlock)customCodeBlock
{
    [XFURLManager open:url transitionBlock:^(NSString *moduleName, NSDictionary *params) {
        [self pushModule:moduleName intent:params.count ? params : self.fromRouting.uiOperator.intentData customCode:customCodeBlock];
    }];
}

// 以URL组件式Present
- (void)openURLForPresent:(NSString *)url customCode:(CustomCodeBlock)customCodeBlock
{
    [XFURLManager open:url transitionBlock:^(NSString *moduleName, NSDictionary *params) {
        [self presentModule:moduleName intent:params.count ? params : self.fromRouting.uiOperator.intentData customCode:customCodeBlock];
    }];
}
// 自定义打开一个URL组件
- (void)openURL:(NSString *)url withTransitionBlock:(TransitionBlock)trasitionBlock customCode:(CustomCodeBlock)customCodeBlock
{
    [XFURLManager open:url transitionBlock:^(NSString *moduleName, NSDictionary *params) {
        [self putModule:moduleName withTransitionBlock:trasitionBlock intent:params.count ? params : self.fromRouting.uiOperator.intentData customCode:customCodeBlock];
    }];
}


#pragma mark - 模块名界面切换方式

- (void)showModule:(NSString *)moduleName onWindow:(UIWindow *)mainWindow customCode:(CustomCodeBlock)customCodeBlock
{
    self.rootRouting = [XFRoutingFactory createRoutingFastFromModuleName:moduleName];
    NSAssert(self.rootRouting, @"模块创建失败！请检测模块名是否正确！(注意：使用帕斯卡命名法<首字母大写>）");
    if (customCodeBlock) {
        customCodeBlock(self.rootRouting);
    }
    id navigator = self.rootRouting.realNavigator;
    if (navigator) {
        mainWindow.rootViewController = navigator;
    }else{
        mainWindow.rootViewController = self.rootRouting.realInterface;
    }
    [mainWindow makeKeyAndVisible];
}

// Modal方式
- (void)presentModule:(NSString *)moduleName intent:(id)intentData customCode:(CustomCodeBlock)customCodeBlock
{
    if ([XFControllerFactory isViewControllerComponent:moduleName]) {
        UIViewController *viewController = [XFControllerFactory controllerFromComponentName:moduleName];
        if (customCodeBlock) {
            customCodeBlock(nil);
        }
        [self presentMVxViewController:viewController];
        return;
    }
    [self putModule:moduleName withTransitionBlock:^(Activity *thisInterface, Activity *nextInterface) {
        [thisInterface presentViewController:nextInterface animated:YES completion:nil];
    } intent:intentData customCode:customCodeBlock];
}

- (void)dismissModule
{
    [self removeModuleWithTransitionBlock:^(Activity *thisInterface, Activity *nextInterface) {
        [thisInterface dismissViewControllerAnimated:YES completion:nil];
    }];
}

// PUSH方式
- (void)pushModule:(NSString *)moduleName intent:(id)intentData customCode:(CustomCodeBlock)customCodeBlock
{
    if ([XFControllerFactory isViewControllerComponent:moduleName]) {
        UIViewController *viewController = [XFControllerFactory controllerFromComponentName:moduleName];
        if (customCodeBlock) {
            customCodeBlock(nil);
        }
        [self pushMVxViewController:viewController];
        return;
    }
    [self putModule:moduleName withTransitionBlock:^(Activity *thisInterface, Activity *nextInterface) {
        [thisInterface.navigationController pushViewController:nextInterface animated:YES];
    } intent:intentData customCode:customCodeBlock];
}

- (void)popModule
{
    [self removeModuleWithTransitionBlock:^(Activity *thisInterface, Activity *nextInterface) {
        [thisInterface.navigationController popViewControllerAnimated:YES];
    }];
}

// 自定义切换
- (void)putModule:(NSString *)moduleName withTransitionBlock:(TransitionBlock)trasitionBlock intent:(id)intentData customCode:(CustomCodeBlock)customCodeBlock {
    // 初始化一个Routing
    XFRouting *nextRouting = [XFRoutingFactory createRoutingFastFromModuleName:moduleName];
    NSAssert(nextRouting, @"模块创建失败！请检测模块名是否正确！(注意：使用帕斯卡命名法<首字母大写>）");
    //  调用自定义代码
    if (customCodeBlock) {
        customCodeBlock(nextRouting);
    }
    // 如果有事件处理层
    if (nextRouting.uiOperator) {
        // 绑定关系
        [self _flowToNextRouting:nextRouting];
    }
    // 移除当前视图焦点
    [self.fromRouting.uiOperator viewWillResignFocus];
    // 执行切换界面
    if (trasitionBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            trasitionBlock(self.fromRouting.realInterface,LEGORealInterface(nextRouting.realInterface));
        });
    }
    // 下一个视图获得焦点，并传送意图数据
    if (self.fromRouting.nextRouting) {
        [self.fromRouting.nextRouting.uiOperator viewWillBecomeFocusWithIntentData:intentData];
    }
}

#pragma mark - MVx界面切换
- (void)pushMVxViewController:(UIViewController *)viewController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self.fromRouting.realInterface navigationController] pushViewController:viewController animated:YES];
    });
}

- (void)presentMVxViewController:(UIViewController *)viewController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.fromRouting.realInterface presentViewController:viewController animated:YES completion:nil];
    });
}

#pragma mark - 关系链管理
// 移除当前Routing
- (void)removeModuleWithTransitionBlock:(TransitionBlock)trasitionBlock
{
    // 标识为程序移除
    [self.fromRouting.realInterface invokeMethod:@"setPoppingProgrammatically:" param:[NSNumber numberWithBool:YES]];
    // 开始移除当前路由并切换
    [self xfLego_startRemoveModuleWithTransitionBlock:trasitionBlock];
}

- (void)xfLego_startRemoveModuleWithTransitionBlock:(TransitionBlock)trasitionBlock
{
    // 移除当前视图焦点
    if (self.fromRouting.uiOperator) {
        [self.fromRouting.uiOperator viewWillResignFocus];
    }
    
    // 执行切换界面
    if (trasitionBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            trasitionBlock(self.fromRouting.realInterface,nil);
        });
    }
    
    // 上一个视图获得焦点，并传送意图数据
    if (self.fromRouting.previousRouting) {
        [self.fromRouting.previousRouting.uiOperator viewWillBecomeFocusWithIntentData:[self.fromRouting.uiOperator intentData]];
    }
    
    // 释放路由
    [self.fromRouting invokeMethod:@"xfLego_releaseRouting:" param:self.fromRouting];
}

- (void)_flowToNextRouting:(XFRouting *)nextRouting
{
    [self.fromRouting setValue:nextRouting forKey:@"nextRouting"];
    [nextRouting setValue:self.fromRouting forKey:@"previousRouting"];
}

@end
