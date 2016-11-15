//
//  XMGRecommendService.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/13.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGRecommendService : NSObject

- (RACSignal *)pullRecommendCategory;
- (RACSignal *)pullRecommendUserForCategoryID:(NSInteger)CategoryID atPage:(NSInteger)pageNumber;
@end
