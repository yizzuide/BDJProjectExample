//
//  BDJPostCategory.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/22.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPostCategory.h"

@implementation BDJPostCategory

static NSArray *_postTypeArray;
+ (void)load
{
    _postTypeArray = @[@"AllPost",@"VideoPost",@"VoicePost",@"PictruePost",@"WordsPost"];
}

+ (BDJPostCategoryType)postCategoryTypeFromString:(NSString *)string {
    return [_postTypeArray indexOfObject:string];
}

+ (NSString *)stringFromPostCategoryType:(BDJPostCategoryType)postType {
    return [_postTypeArray objectAtIndex:postType];
}
@end
