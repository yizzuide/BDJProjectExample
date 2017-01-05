//
//  BDJPostPictureBrowseViewController.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/25.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFControllerComponentRunnable.h"

// 如要当前控制器不是继承的UIViewController类，可实现XFControllerComponentRunnable接口使控制器成为可运行组件
@interface BDJPostPictureBrowseViewController : UIViewController <XFControllerComponentRunnable>

/* ---------------- 可选实现 ---------------- */
/**
 *  上一个URL组件传递过来的URL参数
 */
@property (nonatomic, copy) NSDictionary *URLParams;

/**
 *  上一个URL组件传递过来的自定义数据对象
 */
@property (nonatomic, copy) id componentData;

/**
 *  预设要传递给其它组件的意图数据
 */
@property (nonatomic, copy) id intentData;

@end
