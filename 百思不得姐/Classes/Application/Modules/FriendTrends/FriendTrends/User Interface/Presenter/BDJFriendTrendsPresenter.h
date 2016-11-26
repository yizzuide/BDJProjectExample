//
//  BDJFriendTrendsPresenter.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJFriendTrendsEventHandlerPort.h"
#import "XFPresenter.h"


@interface BDJFriendTrendsPresenter : XFPresenter <BDJFriendTrendsEventHandlerPort>

@property (nonatomic, strong) RACCommand *friendsRecommentCommand;
@property (nonatomic, strong) RACCommand *signInCommand;
@end
