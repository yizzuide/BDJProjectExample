//
//  XMGMetaPostModel.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/21.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGPostInfo.h"
#import "XMGPostModel.h"

@interface XMGMetaPostModel : NSObject

@property (nonatomic, strong) XMGPostInfo *info;
@property (nonatomic, strong) NSMutableArray<XMGPostModel *> *list;

/* ---------------- 记录属性 ---------------- */
@property (nonatomic, assign) NSInteger currentPage;
@end
