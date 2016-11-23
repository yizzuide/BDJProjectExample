//
//  XMGRecommendCategoryModel.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/13.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGRecommandUserModel.h"

@interface XMGRecommendCategoryModel : NSObject

// 分类id
@property (nonatomic, assign) NSInteger ID;
// 分类显示名
@property (nonatomic, copy) NSString *name;
// 数量
@property (nonatomic, assign) NSInteger count;




/* ---------------- 记录属性 ---------------- */
/**
 *  用户组
 */
@property (nonatomic, strong) NSMutableArray<XMGRecommandUserModel *> *users;

// 用户总数
@property (nonatomic, assign) NSInteger total;
// 下一页数
@property (nonatomic, assign) NSInteger next_page;
// 总页数
@property (nonatomic, assign) NSInteger total_page;
/**
 *  当前加载到的页数
 */
@property (nonatomic, assign) NSInteger currentPage;

@end
