//
//  XFStatWindow.m
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/2.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFStatWindow.h"
#import "UIView+Extention.h"

static UIWindow *statWindow_;

@implementation XFStatWindow

+ (void)initialize
{
    statWindow_ = [[UIWindow alloc] init];
    statWindow_.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20);
    statWindow_.backgroundColor = [UIColor clearColor];
    statWindow_.windowLevel = UIWindowLevelAlert;
    [statWindow_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClickAction)]];
}

+ (void)show
{
    // 在IOS10系统上已经支持复杂的滚动视图的顶部点击置顶功能
    if([[UIDevice currentDevice].systemVersion floatValue] < 10.0){
        statWindow_.hidden = NO;
    }
}

+ (void)hide
{
    if([[UIDevice currentDevice].systemVersion floatValue] < 10.0){
        statWindow_.hidden = YES;
    }
}

+ (void)windowClickAction
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

// 遍历所有视图
+ (void)searchScrollViewInView:(UIView *)superView
{
    NSUInteger count = superView.subviews.count;
    for (int i = 0; i < count; i++) {
        UIScrollView *subview = superView.subviews[i];
        // 如果是UIScrollView类，并且在主窗口上
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowOnKeyWindow) {
            // 获得当前滚动偏移
            CGPoint offset = subview.contentOffset;
            // 这里不能赋值为0，有可能设置了contentInset
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        // 递归遍历
        [self searchScrollViewInView:subview];
    }
}
@end
