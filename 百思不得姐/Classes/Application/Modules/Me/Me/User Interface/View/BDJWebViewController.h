//
//  BDJWebViewController.h
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/8.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFComponentRoutable.h"

@interface BDJWebViewController : UIViewController <XFComponentRoutable>

/**
 *  url组件传递参数
 */
@property (nonatomic, copy) NSDictionary *URLParams;

/**
 *  url组件传递对象
 */
@property (nonatomic, copy) id componentData;
@end
