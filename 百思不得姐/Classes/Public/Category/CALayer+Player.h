//
//  CALayer+Player.h
//  百思不得姐
//
//  Created by Yizzuide on 2017/2/20.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (Player)
/**
 *  暂止动画
 *
 */
- (void)pauseLayer:(CALayer*)layer;
/**
 *  继续动画
 *
 */
- (void)resumeLayer:(CALayer*)layer;
@end
