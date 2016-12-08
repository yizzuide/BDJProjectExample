//
//  BDJNavigationController.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/11.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJNavigationController.h"

@interface BDJNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation BDJNavigationController

+ (void)initialize
{
    // 方式二：当导航控制包含当前类时才需要设置,只会设置一次，因为是通过appearance皮肤全局配置
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    [navBar setBackgroundImage:[UIImage imageNamed:R_Image_NavBkg] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // 方式一：直接设置当前导航的背景图，但每一个实例都要设置一次
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:R_Image_NavBkg] forBarMetrics:UIBarMetricsDefault];
    
    // 修复左滑失效问题
    self.interactivePopGestureRecognizer.delegate = self;
}

// 统一设置导航子界面的返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 如果不是top控制器
    if (self.childViewControllers.count) {
        UIButton *leftBackButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBackButton setImage:[UIImage imageNamed:R_Image_NavButtonReturn] forState:UIControlStateNormal];
        [leftBackButton setImage:[UIImage imageNamed:R_Image_NavButtonReturnSel] forState:UIControlStateHighlighted];
        [leftBackButton setTitle:@"返回" forState:UIControlStateNormal];
        [leftBackButton setTitleColor:UIColorFromRGB(R_Color_TextMainTitle) forState:UIControlStateNormal];
        [leftBackButton setTitleColor:UIColorFromRGB(R_Color_Front) forState:UIControlStateHighlighted];
        //        [leftBackButton sizeToFit]; // 内容适合大小，还是有点靠右
        leftBackButton.size = CGSizeMake(70, 20);
        // 使内容靠左排
        leftBackButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 继续向左移
        leftBackButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        UIBarButtonItem *leftBackItem = [[UIBarButtonItem alloc] initWithCustomView:leftBackButton];
        viewController.navigationItem.leftBarButtonItem = leftBackItem;
        // 添加点击事件
        [leftBackButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        // 自动隐藏TabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 调用父类push实现方法,可以在对应ViewController再次覆盖leftBarButtonItem默认返回样式
    [super pushViewController:viewController animated:animated];
}

- (void)backAction
{
    [self popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
