//
//  BDJPostCmtProvider.h
//  百思不得姐
//
//  Created by Yizzuide on 2016/11/30.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XFRenderData,BDJMetaPostCmtModel;
@interface BDJPostCmtProvider : NSObject

+ (XFRenderData *)collectRenderDataFromModel:(BDJMetaPostCmtModel *)metaPostCmtModel;
@end
