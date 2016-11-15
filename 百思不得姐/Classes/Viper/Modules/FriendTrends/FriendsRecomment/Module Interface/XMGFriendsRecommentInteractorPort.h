//
//  XMGFriendsRecommentInteractorPort.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/12.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFInteractorPort.h"

@class RACSignal;
@protocol XMGFriendsRecommentInteractorPort <XFInteractorPort>

- (RACSignal *)fetchRecommendCategory;
- (RACSignal *)fetchRecommendUserForCategoryIndex:(NSInteger)index;
- (RACSignal *)fetchNextPageRecommendUserForCategoryIndex:(NSInteger)index;
@end
