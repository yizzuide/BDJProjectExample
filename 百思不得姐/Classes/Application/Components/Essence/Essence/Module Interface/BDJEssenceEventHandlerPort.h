//
//  BDJEssenceEventHandlerPort.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFEventHandlerPort.h"

@class RACCommand;
@protocol BDJEssenceEventHandlerPort <XFEventHandlerPort>

@property (nonatomic, strong) RACCommand *tagCommand;

- (void)didScrollIndicatorAction;
@end
