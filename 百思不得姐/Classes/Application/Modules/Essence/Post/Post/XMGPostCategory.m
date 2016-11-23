//
//  XMGPostCategory.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/22.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGPostCategory.h"

@implementation XMGPostCategory

static NSArray *_postTypeArray;
+ (void)load
{
    _postTypeArray = @[@"AllPost",@"VideoPost",@"VoicePost",@"PictruePost",@"WordsPost"];
}

+ (XMGPostCategoryType)postCategoryTypeFromString:(NSString *)string {
    return [_postTypeArray indexOfObject:string];
}

+ (NSString *)stringFromPostCategoryType:(XMGPostCategoryType)postType {
    return [_postTypeArray objectAtIndex:postType];
}
@end
