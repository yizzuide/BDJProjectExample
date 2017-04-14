//
//  BDJMeEventHandlerPort.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFEventHandlerPort.h"

@class XFExpressPiece,RACCommand;
@protocol BDJMeEventHandlerPort <XFEventHandlerPort>

@property (nonatomic, strong) RACCommand *settingCommand;

- (RACSignal *)DidFooterViewInitAction;
- (void)didTopicSelectAction:(XFExpressPiece *)expressPiece;
@end
