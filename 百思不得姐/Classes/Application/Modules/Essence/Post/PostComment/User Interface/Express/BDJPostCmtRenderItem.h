//
//  BDJPostCmtRenderItem.h
//  百思不得姐
//
//  Created by Yizzuide on 2016/11/30.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFRenderItem.h"

typedef enum : NSUInteger {
    PostCmtRenderItemSexTypeMan,
    PostCmtRenderItemSexTypeFemale,
} PostCmtRenderItemSexType;

@interface BDJPostCmtRenderItem : XFRenderItem

@property (nonatomic, strong) NSURL *profile;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, assign) PostCmtRenderItemSexType sexType;
@property (nonatomic, assign) NSString *likeCount;
@property (nonatomic, copy) NSString *commentContent;
/**
 *  音频秒数
 */
@property (nonatomic, copy) NSString *voiceSecond;
/**
 *  引用评论用户
 */
@property (nonatomic, copy) NSString *refUserName;
/**
 *  自动检测有引用评论的内容
 */
@property (nonatomic, copy) NSAttributedString *autoDelectAtCmtContent;
@end
