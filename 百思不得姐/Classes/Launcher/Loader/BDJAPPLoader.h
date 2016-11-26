//
//  BDJAPPLoader.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDJAPPLoader : NSObject

+ (void)loadForWindow:(UIWindow *)window;
+ (void)loadForLaunchOptions:(NSDictionary *)launchOptions;
+ (void)loadForGlobal;
@end
