//
//  BDJMediaRenderItem.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/27.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJPostRenderItem.h"

@interface BDJMediaRenderItem : BDJPostRenderItem

@property (nonatomic, copy) NSURL *playURL;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, copy) NSString *playCount;
@property (nonatomic, copy) NSString *playTimeLen;


@end
