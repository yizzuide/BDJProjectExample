//
//  XMGPostRenderItem.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/22.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFRenderItem.h"

// 每个帖子的真实类型
typedef enum : NSInteger {
    XMGPostRenderItemTypeVideo,
    XMGPostRenderItemTypeVoice,
    XMGPostRenderItemTypePictrue,
    XMGPostRenderItemTypePictrueLong,
    XMGPostRenderItemTypePictrueGIF,
    XMGPostRenderItemTypeWords,
} XMGPostRenderItemType;

@interface XMGPostRenderItem : XFRenderItem

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, strong) NSURL *ProfileUrl;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *love;
@property (nonatomic, copy) NSString *hate;
@property (nonatomic, copy) NSString *rePost;
@property (nonatomic, copy) NSString *comment;
/* 是否是新浪会员 */
@property (nonatomic, assign,getter=isSina_v) BOOL sina_v;
/**
 *  帖子显示类型
 */
@property (nonatomic, assign) XMGPostRenderItemType type;

/**
 *  每个帖子都有文本
 */
@property (nonatomic, copy) NSString *text;

@end
