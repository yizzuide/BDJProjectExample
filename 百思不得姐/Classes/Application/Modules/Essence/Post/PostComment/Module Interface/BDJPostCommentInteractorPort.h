//
//  BDJPostCommentInteractorPort.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/29.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFInteractorPort.h"

@protocol BDJPostCommentInteractorPort <XFInteractorPort>

- (void)cachePostID:(NSString *)ID;
- (RACSignal *)fetchPostComments;
@end
