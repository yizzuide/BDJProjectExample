//
//  XMGPostInteractorPort.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFInteractorPort.h"
#import "XMGPostCategory.h"

@protocol XMGPostInteractorPort <XFInteractorPort>

- (RACSignal *)fetchPostsForType:(XMGPostCategoryType)postType;
@end
