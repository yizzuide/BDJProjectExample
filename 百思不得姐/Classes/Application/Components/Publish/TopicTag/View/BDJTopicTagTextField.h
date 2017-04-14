//
//  BDJTopicTagTextField.h
//  百思不得姐
//
//  Created by Yizzuide on 2017/2/13.
//  Copyright © 2017年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BDJTopicTagTextField : UITextField

@property (nonatomic, copy) void (^deleteBlock)();
@end
