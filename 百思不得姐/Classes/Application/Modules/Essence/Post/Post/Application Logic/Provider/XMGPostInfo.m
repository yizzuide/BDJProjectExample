//
//  XMGPostInfo.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/21.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGPostInfo.h"

@implementation XMGPostInfo

- (NSString *)description
{
    return [NSString stringWithFormat:@"XMGPostInfo description:%@\n maxid: %zd\ncount: %zd\nmaxtime: %zd\npage: %zd\n",[super description], self.maxid, self.count, self.maxtime, self.page];
}
@end
