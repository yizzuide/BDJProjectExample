//
//  BDJFriendsRecommentDataManagerPort.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/12.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFDataManagerPort.h"

@protocol BDJFriendsRecommentDataManagerPort <XFDataManagerPort>

- (RACSignal *)grabRecommendCategory;
- (RACSignal *)grabRecommendUserForCategoryID:(NSInteger)CategoryID atPage:(NSInteger)pageNumber;
@end
