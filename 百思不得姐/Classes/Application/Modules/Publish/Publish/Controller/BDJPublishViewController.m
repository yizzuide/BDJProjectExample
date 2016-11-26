//
//  BDJPublishViewController.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/17.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPublishViewController.h"
#import "XFVerticalButton.h"
#import "POP.h"
#import "POP+MCAnimate.h"

static CGFloat const kAnimDuration = 0.1;
static CGFloat const kSpringFactor = 10;

typedef enum : NSUInteger {
    BDJPublishTypeVideo,
    BDJPublishTypePictrue,
} BDJPublishType;

@interface BDJPublishViewController ()

@end

@implementation BDJPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 动画期间不可交互
    self.view.userInteractionEnabled = NO;
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    // 中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (ScreenSize.height - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (ScreenSize.width - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i<images.count; i++) {
        XFVerticalButton *button = [[XFVerticalButton alloc] init];
        [self.view addSubview:button];
        button.tag = i;
        [button addTarget:self action:@selector(doFunAction:) forControlEvents:UIControlEventTouchUpInside];
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        // 计算frame
        button.width = buttonW;
        button.height = buttonH;
        int row = i / maxCols;
        int col = i % maxCols;
        button.x = buttonStartX + col * (xMargin + buttonW);
        button.y = -buttonH; // 设置初始显示位置
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        
        // 使用Layer以动画形式最终确定Y值
        POPSpringAnimation *anim=[POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        anim.fromValue = @(button.y);
        anim.toValue= @(buttonEndY + buttonH * 0.5); // 基于Layer动画是以中心为锚点
        anim.beginTime = CACurrentMediaTime() + i * kAnimDuration;
        anim.springBounciness = kSpringFactor;
        anim.springSpeed = kSpringFactor;
        [button.layer pop_addAnimation:anim forKey:nil];
    }
    
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:sloganView];
    sloganView.y = -sloganView.height;
    CGFloat centerX = ScreenSize.width * 0.5;
    CGFloat centerEndY = ScreenSize.height * 0.2;
    // 直接设置View动画
    POPSpringAnimation *anim =[POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, sloganView.y)];
    anim.toValue= [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.beginTime = CACurrentMediaTime() + images.count * kAnimDuration;
    anim.springBounciness = kSpringFactor;
    anim.springSpeed = kSpringFactor;
    [sloganView pop_addAnimation:anim forKey:nil];
    // 侦听最后一个动画完成，应用交互
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finish) {
        self.view.userInteractionEnabled = YES;
    }];
}

// 以动画形式退出完成后调用CompletionBlock
- (void)cancelWithCompletionBlock:(void(^)())CompletionBlock
{
    // 动画期间不可交互
    self.view.userInteractionEnabled = NO;
    // 收集要动画的控件
    NSUInteger count = self.view.subviews.count;
    int beginIndex = 2;
    NSMutableArray *animViews = @[].mutableCopy;
    for (int i = beginIndex; i < count; i++) {
        UIView *view = self.view.subviews[i];
        [animViews addObject:view];
    }
    // 使用POP-MCAnimate框架的快速语法
    [animViews pop_sequenceWithInterval:0.1 animations:^(UIView *view, NSInteger index){
        view.pop_duration = kAnimDuration * index;
        view.pop_easeIn.center = CGPointMake(view.centerX, view.height + ScreenSize.height);
    } completion:^(BOOL finished){
        if (CompletionBlock) {
            CompletionBlock();
        }
    }];
}

- (IBAction)cancel {
    [self cancelWithCompletionBlock:^{
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancel];
}

// 点击功能按钮时
- (void)doFunAction:(UIButton *)target
{
    // 先显示退出动画
    [self cancelWithCompletionBlock:^{
        switch (target.tag) {
            case BDJPublishTypeVideo:
                LogWarning(@"发布视频");
                break;
                
            default:
                break;
        }
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
    
}
@end
