//
//  BDJMetaPostModel.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/21.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDJPostInfo.h"
#import "BDJPostModel.h"

@interface BDJMetaPostModel : NSObject

@property (nonatomic, strong) BDJPostInfo *info;
@property (nonatomic, strong) NSMutableArray<BDJPostModel *> *list;

/* ---------------- 记录属性 ---------------- */
@property (nonatomic, assign) NSInteger currentPage;
@end
