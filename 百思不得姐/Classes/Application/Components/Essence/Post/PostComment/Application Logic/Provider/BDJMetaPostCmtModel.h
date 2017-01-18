//
//  BDJMetaPostCmtModel.h
//  百思不得姐
//
//  Created by Yizzuide on 2016/11/30.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDJPostCmtModel.h"

@interface BDJMetaPostCmtModel : NSObject

@property (nonatomic, copy) NSString *author;
/**
 *  评论总数
 */
@property (nonatomic, assign) NSInteger total;
/**
 *  所有最热评论
 */
@property (nonatomic, strong) NSArray<BDJPostCmtModel *> *hot;
/**
 *  所有最新评论
 */
@property (nonatomic, strong) NSMutableArray<BDJPostCmtModel *> *data;
@end
