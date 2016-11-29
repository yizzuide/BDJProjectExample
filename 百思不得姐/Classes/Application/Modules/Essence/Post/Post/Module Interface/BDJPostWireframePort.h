//
//  BDJPostWireframePort.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFWireFramePort.h"

@protocol BDJPostWireFramePort <XFWireFramePort>

- (void)transition2PostPictureBrowse;
- (void)transition2PostComment;
@end
