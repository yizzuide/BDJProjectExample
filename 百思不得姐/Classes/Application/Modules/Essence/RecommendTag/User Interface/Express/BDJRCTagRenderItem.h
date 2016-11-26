//
//  BDJRCTagRenderItem.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/16.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFRenderItem.h"

@interface BDJRCTagRenderItem : XFRenderItem

/** 标签图标 */
@property (nonatomic, copy) NSURL *imageURL;

/** 标签名 */
@property (nonatomic, copy) NSString *tagName;

/** 订阅数量 */
@property (nonatomic, copy) NSString *subscribeAmount;
@end
