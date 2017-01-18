//
//  BDJEssencePresenter.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/9.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJEssenceEventHandlerPort.h"
#import "XFPresenter.h"


@interface BDJEssencePresenter : XFPresenter <BDJEssenceEventHandlerPort>

@property (nonatomic, strong) RACCommand *tagCommand;
@end
