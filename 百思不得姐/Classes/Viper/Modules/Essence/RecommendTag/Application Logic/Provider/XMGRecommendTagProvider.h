//
//  XMGRecommendTagProvider.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/16.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFRenderData.h"

@class XMGRecommendTagModel;
@interface XMGRecommendTagProvider : NSObject

+ (XFRenderData *)collectRenderDataFromArray:(NSArray<XMGRecommendTagModel *> *)array;
@end
