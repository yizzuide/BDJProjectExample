//
//  XFPlusTabBar.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/11.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XFTabBarDelegate <UITabBarDelegate>

- (void)tabBarDidPlusBtnClick:(UITabBar* )tabBar;
@end

@interface XFPlusTabBar : UITabBar

// 如果要使用用和父类同名成员变量,自定义的delegate要继承父类delegate协议类型
@property (nonatomic, weak) id<XFTabBarDelegate> delegate;

+ (instancetype)plusTabBarWithBkImage:(NSString *)bkImage selBkImage:(NSString *)selBkImage;
+ (instancetype)plusTabBarWithImage:(NSString *)image selImage:(NSString *)selImage;
+ (instancetype)plusTabBarWithBkImage:(NSString *)bkImage selBkImage:(NSString *)selBkImage image:(NSString *)image selImage:(NSString *)selImage;
@end
