//
//  BDJIndexTabActivity.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJIndexTabActivity.h"
#import "BDJIndexTabEventHandlerPort.h"
#import "XFActivity.h"
#import "XFPlusTabBar.h"
#import <SVProgressHUD.h>

#define EventHandler  XFConvertPresenterToType(id<BDJIndexTabEventHandlerPort>)

@interface BDJIndexTabActivity () <XFTabBarDelegate>

@end

@implementation BDJIndexTabActivity

+ (void)initialize
{
    [self configTabBar];
    [self configDialog];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加子视图
    [self setUpChildActivitys];
    
    // 添加中间发布按钮
    XFPlusTabBar *plusTabBar = [XFPlusTabBar plusTabBarWithBkImage:R_Image_PlusButton selBkImage:R_Image_PlusButtonSel];
    [plusTabBar setBackgroundImage:[UIImage imageNamed:R_Image_TabBarBkg]];
    [self setValue:plusTabBar forKeyPath:@"tabBar"];
}

#pragma mark - 初始化
+ (void)configTabBar
{
    NSDictionary *textAttr = @{
                                          NSForegroundColorAttributeName:UIColorFromRGB(R_Color_SectionText),
                                          NSFontAttributeName:[UIFont systemFontOfSize:R_Size_Font_TabBarTitle]
                                          };
    NSDictionary *textHeightLightAttr = @{
                                          NSForegroundColorAttributeName:UIColorFromRGB(R_Color_SectionTextSel),
                                          NSFontAttributeName:[UIFont systemFontOfSize:R_Size_Font_TabBarTitle]
                                          };
    /*[essenceActivity.tabBarItem setTitleTextAttributes:textHeightLightAttr forState:UIControlStateSelected];*/
    // 全局应用文本样式 只有后面带UI_APPEARANCE_SELECTOR宏的方法才可以就用appearance
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:textHeightLightAttr forState:UIControlStateSelected];
}

+ (void)configDialog
{
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:UIColorFromRGB(R_Color_Front)];
    [SVProgressHUD setBackgroundColor:UIColorFromRGB(R_Color_CellBkg)];
    [SVProgressHUD setMinimumDismissTimeInterval:0.5f];
}

- (void)setUpChildActivitys {
    [self addChildActivity:XF_SubUInterface_(@"Essence") title:@"精华" image:R_Image_TabBarEssence selImage:R_Image_TabBarEssenceSel];
    [self addChildActivity:XF_SubUInterface_(@"New") title:@"新帖" image:R_Image_TabBarNew selImage:R_Image_TabBarNewSel];
    [self addChildActivity:XF_SubUInterface_(@"FriendTrends") title:@"关注" image:R_Image_TabBarFriendTrend selImage:R_Image_TabBarFriendTrendSel];
    [self addChildActivity:XF_SubUInterface_(@"Me") title:@"我" image:R_Image_TabBarMe selImage:R_Image_TabBarMeSel];
}

- (void)addChildActivity:(XFActivity *)activity title:(NSString *)title image:(NSString *)image selImage:(NSString *)selImage
{
    activity.tabBarItem.title = title;
    activity.tabBarItem.image = [UIImage imageNamed:image];
    activity.tabBarItem.selectedImage = [UIImage imageNamed:selImage];
    [self addChildViewController:activity.navigationController];
}

- (void)xfLego_viewDidLoadForTabBarViewController
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
- (void)tabBarDidPlusBtnClick:(UITabBar *)tabBar
{
    [EventHandler didPublishButtonClickAction];
}



#pragma mark - Getter



@end
