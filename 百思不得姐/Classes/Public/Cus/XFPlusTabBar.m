//
//  XFPlusTabBar.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/11.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFPlusTabBar.h"

// 设置UIView的Frame
#define XF_SetFrame_(view,ExecuteCode) \
CGRect frame = view.frame; \
ExecuteCode \
view.frame = frame;
#define XF_SetCenter_(view,ExecuteCode) \
    CGPoint center = view.center; \
    ExecuteCode \
view.center = center;

@interface XFPlusTabBar ()

@property(nonatomic, weak) UIButton *plusBtn;
@end

@implementation XFPlusTabBar
// @dynamic告诉编译器这个属性是动态的,因为delegate父类也有,自定义的delegate要继承父类delegate协议类型
@dynamic delegate;

+ (instancetype)plusTabBarWithBkImage:(NSString *)bkImage selBkImage:(NSString *)selBkImage
{
    return [self plusTabBarWithBkImage:bkImage selBkImage:selBkImage image:nil selImage:nil];
}

+ (instancetype)plusTabBarWithImage:(NSString *)image selImage:(NSString *)selImage
{
    return [self plusTabBarWithBkImage:nil selBkImage:nil image:image selImage:selImage];
}

+ (instancetype)plusTabBarWithBkImage:(NSString *)bkImage selBkImage:(NSString *)selBkImage image:(NSString *)image selImage:(NSString *)selImage
{
    XFPlusTabBar *plusTabBar = [[self alloc] init];
    UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 设置背景图
    if (bkImage) {
         [plusBtn setBackgroundImage:[UIImage imageNamed:bkImage] forState:UIControlStateNormal];
    }
    if (selBkImage) {
         [plusBtn setBackgroundImage:[UIImage imageNamed:selBkImage] forState:UIControlStateHighlighted];
    }
    // 设置icon
    if (image) {
        [plusBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (selImage) {
        [plusBtn setImage:[UIImage imageNamed:selImage] forState:UIControlStateHighlighted];
    }
    
    // 设置大小
    if (bkImage) {
        XF_SetFrame_(plusBtn, {
            frame.size = plusBtn.currentBackgroundImage.size;
        })
    }else{
        XF_SetFrame_(plusBtn, {
            frame.size = plusBtn.currentImage.size;
        })
    }
    
    // 添加到容器
    [plusTabBar addSubview:plusBtn];
    
    plusTabBar.plusBtn = plusBtn;
    
    [plusTabBar.plusBtn addTarget:plusTabBar action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    return plusTabBar;
}

// 修改布局
- (void)layoutSubviews
{
    // 先让父类布局其它子控制
    [super layoutSubviews];
    CGSize parentSize = self.frame.size;
    // 使新加入控制按钮居中
    XF_SetCenter_(self.plusBtn, {
        center.x = parentSize.width * 0.5;
        center.y = parentSize.height * 0.5;
    })
    // 和加入的按钮一起平分位置
    CGFloat width = parentSize.width / 5.0;
    int currentItemIndex = 0;
    for (UIView *view in self.subviews) {
        // 只布局UITabBarButton类型的按钮,由于它是私有API,通过NSClassFromString拿到类
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            XF_SetFrame_(view, {
                frame.size.width = width;
                frame.origin.x = ((currentItemIndex > 1) ? currentItemIndex + 1 : currentItemIndex) * width;
            })
            currentItemIndex++;
        }
    }
}

- (void)plusBtnClick {
    if ([self.delegate respondsToSelector:@selector(tabBarDidPlusBtnClick:)]) {
        [self.delegate tabBarDidPlusBtnClick:self];
    }
}

@end
