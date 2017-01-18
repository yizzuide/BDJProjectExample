//
//  BDJFriendTrendsActivity.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJFriendTrendsActivity.h"
#import "BDJFriendTrendsEventHandlerPort.h"
#import "UIBarButtonItem+BDJExtension.h"

#define EventHandler  XFConvertPresenterToType(id<BDJFriendTrendsEventHandlerPort>)

@interface BDJFriendTrendsActivity ()

@property (nonatomic, weak) UIButton *friendsRecommentButton;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@end

@implementation BDJFriendTrendsActivity

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(R_Color_GlobalBkg);
    
    [self configNav];
    // 初始化视图
    [self setUpViews];
    // 绑定视图数据
    [self bindViewData];
}

#pragma mark - 初始化
- (void)configNav
{
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:R_Image_NavFriendsRecomment imageSel:R_Image_NavFriendsRecommentSel];
    self.friendsRecommentButton = self.navigationItem.leftBarButtonItem.customView;
}
- (void)setUpViews {
    
}

- (void)bindViewData {
    // 双向数据绑定
    //XF_$_(self.textField, text, EventHandler, text)
    // 绑定事件层按钮命令
    XF_C_(self.friendsRecommentButton, EventHandler, friendsRecommentCommand)
    XF_C_(self.signInButton, EventHandler, signInCommand)
}


#pragma mark - UIControlDelegate




#pragma mark - Getter



@end
