//
//  BDJFriendTrendsEventHandlerPort.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFEventHandlerPort.h"

@protocol BDJFriendTrendsEventHandlerPort <XFEventHandlerPort>

@property (nonatomic, strong) RACCommand *friendsRecommentCommand;
@property (nonatomic, strong) RACCommand *signInCommand;
@end
