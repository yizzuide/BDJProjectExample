//
//  BDJPostCategory.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/22.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

// 帖子所属分类类型
typedef enum : NSInteger {
    BDJPostCategoryTypeAll,
    BDJPostCategoryTypeVideo,
    BDJPostCategoryTypeVoice,
    BDJPostCategoryTypePictrue,
    BDJPostCategoryTypeWords,
} BDJPostCategoryType;


#define BDJ_Post_Str2Type(string) [BDJPostCategory postCategoryTypeFromString:string]
#define BDJ_Post_type2Type(type) [BDJPostCategory stringFromPostCategoryType:type]

@interface BDJPostCategory : NSObject

+ (BDJPostCategoryType)postCategoryTypeFromString:(NSString *)string;
+ (NSString *)stringFromPostCategoryType:(BDJPostCategoryType)postType;
@end
