//
//  BDJRecommandUserGroupModel.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/15.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BDJRecommandUserModel;
@interface BDJRecommandUserGroupModel : NSObject

@property (nonatomic, strong) NSArray<BDJRecommandUserModel *> *list;
// 用户总数
@property (nonatomic, assign) NSInteger total;
// 下一页数
@property (nonatomic, assign) NSInteger next_page;
// 总页数
@property (nonatomic, assign) NSInteger total_page;
@end
