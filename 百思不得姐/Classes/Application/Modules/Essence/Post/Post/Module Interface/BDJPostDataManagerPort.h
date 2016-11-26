//
//  BDJPostDataManagerPort.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFDataManagerPort.h"
#import "BDJPostCategory.h"

@protocol BDJPostDataManagerPort <XFDataManagerPort>

- (RACSignal *)grabPostsForType:(BDJPostCategoryType)postType;
- (RACSignal *)grabPostsForType:(BDJPostCategoryType)postType maxtime:(NSInteger)maxtime atPage:(NSInteger)page;
@end
