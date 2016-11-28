//
//  BDJEssenceActivity.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJEssenceActivity.h"
#import "BDJEssenceEventHandlerPort.h"
#import "UIBarButtonItem+BDJExtension.h"

#define EventHandler  XFConvertPresenterToType(id<BDJEssenceEventHandlerPort>)

@interface BDJEssenceActivity () <UIScrollViewDelegate>

@property (nonatomic, weak) UIButton *tagButton;
@property (nonatomic, weak) UIButton *seletedTabBtn;
@property (nonatomic, weak) UIView *indicator;
@property (nonatomic, weak) UIView *headerBar;
@property (nonatomic, weak) UIScrollView *contentView;
@end

@implementation BDJEssenceActivity

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(R_Color_GlobalBkg);
    // 配置导航栏
    [self configNav];
    // 初始化视图
    [self setUpViews];
    // 绑定视图数据
    [self bindViewData];
}

#pragma mark - 初始化
- (void)configNav
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" imageSel:@"MainTagSubIconClick"];
    self.tagButton = self.navigationItem.leftBarButtonItem.customView;
}

// 添加子视图
- (void)setUpViews {
    // 添加子控制器
    [self addChildActivity];
    // 添加标题栏
    [self addTitleTabsView];
    // 添加容器视图
    [self addContentView];
}

- (void)addChildActivity
{
    NSArray *modules = @[@"AllPost",@"VideoPost",@"VoicePost",@"PicturePost",@"WordsPost"];
    NSUInteger count = modules.count;
    for (int i = 0; i < count; i++) {
        XFActivity *activity = XF_SubUInterface_(modules[i]);
        [self addChildViewController:activity];
    }
}

- (void)addContentView
{
    // 不要对当前滚动视图自动调整Inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.frame = self.view.bounds;
    // 把滚动容器插入在标题栏下方
    [self.view insertSubview:scrollView belowSubview:self.headerBar];
    self.contentView = scrollView;
    scrollView.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count, 0);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    
    // 初始化时添加第一个控制器的视图
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)addTitleTabsView
{
    UIView *headerBar = [[UIView alloc] init];
    headerBar.backgroundColor = UIColorFromARGB(0x99ffffff);
    headerBar.y = R_Height_StautsWithNavBar;
    headerBar.size = CGSizeMake(self.view.width, R_Height_PostHeaderTabs);
    [self.view addSubview:headerBar];
    self.headerBar = headerBar;
    
    NSInteger tabCount = 5;
    NSArray *tabs = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    for (int i = 0; i < tabCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        // 标记索引下标
        button.tag = i;
        [button setTitle:tabs[i] forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(R_Color_SectionText) forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(R_Color_Front) forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.x = self.view.width / tabCount * i;
        button.size = CGSizeMake(self.view.width / tabCount, headerBar.height);
        [headerBar addSubview:button];
        [button addTarget:self action:@selector(scrollIndicatorWithButton:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            self.seletedTabBtn = button;
        }
    }
    
    // 添加指示器
    UIView *indicator = [[UIView alloc] init];
    indicator.backgroundColor = UIColorFromRGB(R_Color_Front);
    indicator.height = 2;
    indicator.y = headerBar.height - indicator.height;
    [headerBar addSubview:indicator];
    self.indicator = indicator;
    
    // 由于视图还未显示，拖动调用把标题大小计算好
    [self.seletedTabBtn.titleLabel sizeToFit];
    // 默认选中第一个tab
    [self scrollIndicatorWithButton:self.seletedTabBtn];
}

#pragma mark - Render
- (void)bindViewData {
    // 双向数据绑定
    //XF_$_(self.textField, text, EventHandler, text)
    // 绑定事件层按钮命令
    XF_C_(self.tagButton, EventHandler, tagCommand)
}


#pragma mark - Action
- (void)scrollIndicatorWithButton:(UIButton *)button
{
    self.seletedTabBtn.enabled = YES;
    button.enabled = NO;
    // 第一个不让其有动画
    if (self.seletedTabBtn == button) {
        self.indicator.width = button.titleLabel.width;
        self.indicator.centerX = button.centerX;
    } else {
        [UIView animateWithDuration:0.25 animations:^{
            self.indicator.width = button.titleLabel.width;
            self.indicator.centerX = button.centerX;
        } completion:^(BOOL finished) {
            self.seletedTabBtn = button;
        }];
    }
    
    // 开始使用动画滚动ScrollView
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    // 这是滚动动画完成后会调用`- (void)scrollViewDidEndScrollingAnimation`方法，如果设置的值是一样就不会执行这个代理方法
    [self.contentView setContentOffset:offset animated:YES];
}


#pragma mark - UIControlDelegate
// 自动滚动动画停止时调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 添加对应位置上的视图
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    XFActivity *activity = self.childViewControllers[index];
    activity.view.x = scrollView.contentOffset.x;
    activity.view.y = 0;// 设置控制器view的y值为0(控制器的Y值默认都是20<这是从IOS6这前的定的值，IOS7以后系统添加时会自动重新设置来全屏显示，如果是自己创建出来显示，要手动设置>)
    activity.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(由于控制器的Y值默认都是20，所以就少了20的高度)
    [scrollView addSubview:activity.view];
}

// 当拖动完成，滚动开始减速时
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 由于是拖动到了对应位置，所以这里要手动调用滚动完成动画方法
    [self scrollViewDidEndScrollingAnimation:scrollView];
    // 自动触发滚动指示器点击事件
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self scrollIndicatorWithButton:self.headerBar.subviews[index]];
}

#pragma mark - Getter



@end
