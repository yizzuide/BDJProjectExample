//
//  BDJPublishContentEventHandlerPort.h
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/15.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFEventHandlerPort.h"

@protocol BDJPublishContentEventHandlerPort <XFEventHandlerPort>

- (void)actionDidAddTag;
@end
