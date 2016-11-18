//
//  XMGRecommendTagDataManager.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/16.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFDataManager.h"
#import "XMGRecommendTagDataManagerPort.h"

@interface XMGRecommendTagDataManager : XFDataManager <XMGRecommendTagDataManagerPort>

- (RACSignal *)grabRecommendTag;
@end
