//
//  XMGPostProvider.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/22.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGPostCategory.h"

@class XFRenderData,XMGPostModel;
@interface XMGPostProvider : NSObject

+ (XFRenderData *)collectPostRenderDataFromArray:(NSArray<XMGPostModel *> *)array;
@end
