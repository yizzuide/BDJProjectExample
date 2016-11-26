//
//  BDJPostProvider.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/22.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDJPostCategory.h"

@class XFRenderData,BDJPostModel;
@interface BDJPostProvider : NSObject

+ (XFRenderData *)collectPostRenderDataFromArray:(NSArray<BDJPostModel *> *)array;
@end
