//
//  XFModuleAssembly.m
//  XFLegoVIPER
//
//  Created by 付星 on 2016/11/3.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFModuleAssembly.h"
#import "XFRoutingLinkManager.h"
#import "XFRouting.h"
#import "NSObject+XFLegoInvokeMethod.h"
#import "XFUserInterfacePort.h"

@implementation XFModuleAssembly

- (instancetype)initWithFromRouting:(XFRouting *)fromRouting
{
    self = [super init];
    if (self) {
        self.fromRouting = fromRouting;
    }
    return self;
}

- (__kindof XFRouting *)autoAssemblyModuleWithPrefixNav
{
    return [self autoAssemblyModuleWithNav:[XFRoutingLinkManager modulePrefix] ibSymbol:nil shareDataManagerName:nil];
}

- (__kindof XFRouting *)autoAssemblyModuleFromShareModuleName:(NSString *)moduleName
{
    return [self _autoAssemblyModuleWithModuleName:moduleName navName:nil ibSymbol:nil shareDataManagerName:nil];
}

- (__kindof XFRouting *)autoAssemblyModuleWithNav:(NSString *)navName ibSymbol:(NSString *)ibSymbol shareDataManagerName:(NSString *)shareDataManagerName
{
    NSString *moduleName = [XFRoutingLinkManager moduleNameForRouting:self.fromRouting];
    return [self _autoAssemblyModuleWithModuleName:moduleName navName:navName ibSymbol:ibSymbol shareDataManagerName:shareDataManagerName];
}

- (__kindof XFRouting *)_autoAssemblyModuleWithModuleName:(NSString *)moduleName navName:(NSString *)navName ibSymbol:(NSString *)ibSymbol shareDataManagerName:(NSString *)shareDataManagerName
{
    NSString *modulePrefix = [XFRoutingLinkManager modulePrefix];
    if (modulePrefix == nil || [modulePrefix isEqualToString:@""]) return nil;
    NSString *navClassName = navName ? [NSString stringWithFormat:@"%@%@",navName,@"NavigationController"] : @"";
    NSString *activityClassName = [NSString stringWithFormat:@"%@%@%@",modulePrefix,moduleName,@"Activity"];
    NSString *presenterClassName = [NSString stringWithFormat:@"%@%@%@",modulePrefix,moduleName,@"Presenter"];
    NSString *interactorClassName = [NSString stringWithFormat:@"%@%@%@",modulePrefix,moduleName,@"Interactor"];
    NSString *dataManagerClassName;
    // 是使用共享的模块名DataManager
    if (shareDataManagerName) {
        // 先采用外部定义的前辍
        dataManagerClassName = [NSString stringWithFormat:@"%@%@",shareDataManagerName,@"DataManager"];
        // 尝试使用同样的模块前缀
        if (!NSClassFromString(dataManagerClassName)) {
            dataManagerClassName = [NSString stringWithFormat:@"%@%@%@",modulePrefix,shareDataManagerName,@"DataManager"];
        }
    }else { // 如果当前模块的DataManager
        dataManagerClassName = [NSString stringWithFormat:@"%@%@%@",modulePrefix,moduleName,@"DataManager"];
    }
    // 如果是Nib
    if (ibSymbol) {
        return [self buildModulesAssemblyWithIB:ibSymbol presenterClass:NSClassFromString(presenterClassName) interactorClass:NSClassFromString(interactorClassName) dataManagerClass:NSClassFromString(dataManagerClassName)];
    }else{
        // 通用组装方式
        return [self buildModulesAssemblyWithActivityClass:NSClassFromString(activityClassName) navigatorClass:NSClassFromString(navClassName) presenterClass:NSClassFromString(presenterClassName) interactorClass:NSClassFromString(interactorClassName) dataManagerClass:NSClassFromString(dataManagerClassName)];
    }
}

- (__kindof XFRouting *)buildModulesAssemblyWithActivityClass:(Class)activityClass navigatorClass:(Class)navigatorClass presenterClass:(Class)perstentClass interactorClass:(Class)interactorClass dataManagerClass:(Class)dataManagerClass
{
    return [self _bulildModulesAssemblyWithInterface:NSStringFromClass(activityClass) navigatorClass:navigatorClass presenterClass:perstentClass interactorClass:interactorClass dataManagerClass:dataManagerClass];
}

- (__kindof XFRouting *)buildModulesAssemblyWithIB:(NSString *)ibSymbol
                            presenterClass:(Class)perstentClass
                           interactorClass:(Class)interactorClass
                          dataManagerClass:(Class)dataManagerClass
{
    return [self _bulildModulesAssemblyWithInterface:ibSymbol navigatorClass:nil presenterClass:perstentClass interactorClass:interactorClass dataManagerClass:dataManagerClass];
}

- (__kindof XFRouting *)_bulildModulesAssemblyWithInterface:(NSString *)interface navigatorClass:(Class)navigatorClass  presenterClass:(Class)perstentClass interactorClass:(Class)interactorClass dataManagerClass:(Class)dataManagerClass
{
    id activity;
    Class clazz = NSClassFromString(interface);
    // 如果是Class
    if (clazz) {
        activity = [[clazz alloc] init];
    }else{
        NSArray<NSString *> *comps = [interface componentsSeparatedByString:@"-"];
        // 如果是xib
        if ([comps[XF_Index_First] containsString:@"x"]) {
            if (comps.count == 2) {
                Class activityClass = NSClassFromString(comps[XF_Index_Second]);
                if (activityClass) { // 如果第二个参数就是Activity类
                    activity = [[activityClass alloc] initWithNibName:comps[XF_Index_Second] bundle:nil];
                }else{ // 使用XFActivity类
                    activity = [[NSClassFromString(@"XFActivity") alloc] initWithNibName:comps[XF_Index_Second] bundle:nil];
                }
            }else if(comps.count == 3){ // 如果有指定Activity类型
                Class activityClass = NSClassFromString(comps[XF_Index_Third]);
                if (activityClass) {
                    activity = [[activityClass alloc] initWithNibName:comps[XF_Index_Second] bundle:nil];
                }else{
#ifdef LogError
                    LogError(@"!!!!!!!!!!!!!!!! XFLegoVIPER !!!!!!!!!!!!!!!!!!!!!");
                    LogError(@"!!!!!!!!!!!!!! ActivityClass加载错误 !!!!!!!!!!!!!!");
                    LogError(@"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
#elif (defined DEBUG)
                    NSLog(@"!!!!!!!!!!!!!!!! XFLegoVIPER !!!!!!!!!!!!!!!!!!!!!");
                    NSLog(@"!!!!!!!!!!!!!! ActivityClass加载错误 !!!!!!!!!!!!!!");
                    NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
#endif
                    NSAssert(NO, @"ActivityClass加载错误！");
                    return nil;
                }
            }
            
            // 如果是从storyboard中加载
        }else if(comps.count == 3 && [comps[XF_Index_First] containsString:@"s"]){
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:comps[XF_Index_Second] bundle:nil];
            activity = [storyboard instantiateViewControllerWithIdentifier:comps[XF_Index_Third]];
        }else{
#ifdef LogError
            LogError(@"!!!!!!!!!!!!!!!! XFLegoVIPER !!!!!!!!!!!!!!!!!!!!!");
            LogError(@"!! 从xib或storyboard加载视图错误 !!!!!!!!!!!!!!!!!!!!");
            LogError(@"请检查字符串标识，\n\nxib方式: x-xibName[-activityClass]\n \
                  storyboard方式: s-storyboardName-controllerIdentifier");
            LogError(@"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
#elif (defined DEBUG)
            NSLog(@"!!!!!!!!!!!!!!!! XFLegoVIPER !!!!!!!!!!!!!!!!!!!!!");
            NSLog(@"!! 从xib或storyboard加载视图错误 !!!!!!!!!!!!!!!!!!!!");
            NSLog(@"请检查字符串标识，\n\nxib方式: x-xibName[-activityClass]\n \
                  storyboard方式: s-storyboardName-controllerIdentifier");
            NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
#endif
            NSAssert(NO, @"从xib或storyboard加载视图错误！");
            return nil;
        }
    }
    
    [self.fromRouting setValue:activity forKey:@"currentUserInterface"];
    
    if (navigatorClass) {
        UINavigationController *navVC = [[navigatorClass alloc] initWithRootViewController:activity];
        [self.fromRouting setValue:navVC forKey:@"currentNavigator"];
    }
    
    if (perstentClass) {
        id presenter = [[perstentClass alloc] init];
        [activity setValue:presenter forKey:@"eventHandler"];
        [presenter setValue:self.fromRouting forKey:@"routing"];
        [self.fromRouting setValue:presenter forKey:@"uiOperator"];
        // other...
        if (interactorClass) {
            id interactor = [[interactorClass alloc] init];
            [presenter setValue:interactor forKey:@"interactor"];
            
            if(dataManagerClass){
                id dataManager = [[dataManagerClass alloc] init];
                [interactor setValue:dataManager forKey:@"dataManager"];
            }
        }
    }

    // 如果有事件处理层
    if (self.fromRouting.uiOperator) {
        // 添加到路由管理中心
        [XFRoutingLinkManager addRouting:self.fromRouting];
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(LEGONextStep * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             // 打印当前路由
             if (!(self.fromRouting.isSubRoute || self.fromRouting.parentRouting)) {
                 // 打印路由关系链
                 [XFRoutingLinkManager log];
             }
         });
        
    }
    return self.fromRouting;
}

@end
