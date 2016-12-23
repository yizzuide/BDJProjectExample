//
//  BDJPostPictureBrowseViewController.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/25.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFComponentRoutable.h"
#import "XFControllerComponentRunnable.h"

// 如要当前控制器不是继承的UIViewController类，可实现XFControllerComponentRunnable接口使控制器成为可运行组件
@interface BDJPostPictureBrowseViewController : UIViewController <XFControllerComponentRunnable>

/* ---------------- 必需实现 ---------------- */
@property (nonatomic, weak) id<XFComponentRoutable> fromComponentRoutable;
@property (nonatomic, weak) id<XFComponentRoutable> nextComponentRoutable;

/* ---------------- 可选实现 ---------------- */
@property (nonatomic, copy) NSDictionary *URLParams;
@property (nonatomic, copy) id componentData;
@property (nonatomic, copy) id intentData;
@end
