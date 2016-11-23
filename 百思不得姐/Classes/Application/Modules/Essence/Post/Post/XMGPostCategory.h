//
//  XMGPostCategory.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/22.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

// 帖子所属分类类型
typedef enum : NSInteger {
    XMGPostCategoryTypeAll,
    XMGPostCategoryTypeVideo,
    XMGPostCategoryTypeVoice,
    XMGPostCategoryTypePictrue,
    XMGPostCategoryTypeWords,
} XMGPostCategoryType;


#define XMG_Post_Str2Type(string) [XMGPostCategory postCategoryTypeFromString:string]
#define XMG_Post_type2Type(type) [XMGPostCategory stringFromPostCategoryType:type]

@interface XMGPostCategory : NSObject

+ (XMGPostCategoryType)postCategoryTypeFromString:(NSString *)string;
+ (NSString *)stringFromPostCategoryType:(XMGPostCategoryType)postType;
@end
