//
//  XMGRCUserRenderItem.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/14.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XFRenderItem.h"

@interface XMGRCUserRenderItem : XFRenderItem
@property (nonatomic, copy) NSString *nikeName;
@property (nonatomic, assign) NSString *fansCount;
@property (nonatomic, strong) NSURL *headPortraitURL;
@end
