//
//  BDJPostInteractorPort.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFInteractorPort.h"
#import "BDJPostCategory.h"

@protocol BDJPostInteractorPort <XFInteractorPort>

- (RACSignal *)fetchPostsForType:(BDJPostCategoryType)postCategoryType;
- (RACSignal *)fetchNextPagePostsForType:(BDJPostCategoryType)postCategoryType;
- (NSInteger)fetchPostIDForIndex:(NSInteger)index type:(BDJPostCategoryType)postCategoryType;
@end
