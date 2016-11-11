//
//  XMGIndexTabActivity.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGIndexTabActivity.h"
#import "XMGIndexTabEventHandlerPort.h"
#import "NSObject+XFLegoInvokeMethod.h"
#import "XFActivity.h"
#import "XFPlusTabBar.h"

#define EventHandler  XFConvertPresenterToType(id<XFIndexTabEventHandlerPort>)

@interface XMGIndexTabActivity ()

@end

@implementation XMGIndexTabActivity

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configTabBar];
    [self setUpChildActivitys];
}

#pragma mark - 初始化
- (void)configTabBar
{
    NSDictionary *textHeightLightAttr = @{
                                          NSForegroundColorAttributeName:[UIColor darkGrayColor],
                                          NSFontAttributeName:[UIFont systemFontOfSize:15]
                                          };
    /*[essenceActivity.tabBarItem setTitleTextAttributes:textHeightLightAttr forState:UIControlStateSelected];*/
    // 全局应用文本样式 只有后面带UI_APPEARANCE_SELECTOR宏的方法才可以就用appearance
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:textHeightLightAttr forState:UIControlStateSelected];
    
    // 添加中间发布按钮
    XFPlusTabBar *plusTabBar = [XFPlusTabBar plusTabBarWithBkImage:@"tabBar_publish_icon" selBkImage:@"tabBar_publish_click_icon"];
    [self setValue:plusTabBar forKeyPath:@"tabBar"];
}

// 添加子控制器
- (void)setUpChildActivitys {
    [self addChildActivity:XF_SubUInterface_(@"Essence") title:@"精华" image:@"tabBar_essence_icon" selImage:@"tabBar_essence_click_icon"];
    [self addChildActivity:XF_SubUInterface_(@"New") title:@"新帖" image:@"tabBar_new_icon" selImage:@"tabBar_new_click_icon"];
    [self addChildActivity:XF_SubUInterface_(@"FriendTrends") title:@"关注" image:@"tabBar_friendTrends_icon" selImage:@"tabBar_friendTrends_click_icon"];
    [self addChildActivity:XF_SubUInterface_(@"Me") title:@"我" image:@"tabBar_me_icon" selImage:@"tabBar_me_click_icon"];
}

- (void)addChildActivity:(XFActivity *)activity title:(NSString *)title image:(NSString *)image selImage:(NSString *)selImage
{
    activity.tabBarItem.title = title;
    activity.tabBarItem.image = [UIImage imageNamed:image];
    activity.tabBarItem.selectedImage = [UIImage imageNamed:selImage];
    [self addChildViewController:activity.navigationController];
}

- (void)xfLego_ViewDidLoadForTabBarViewController
{
    [self bindViewData];
}

- (void)bindViewData {
    // 双向数据绑定
    //XF_$_(self.textField, text, EventHandler, text)
    // 绑定事件层按钮命令
    //XF_C_(self.btn, EventHandler, Command)
}


#pragma mark - UIControlDelegate




#pragma mark - Getter



@end
