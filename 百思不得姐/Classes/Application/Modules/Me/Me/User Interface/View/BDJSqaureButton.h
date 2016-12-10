//
//  BDJSqaureButton.h
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/8.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDJTopicRenderItem.h"
#import "XFExpressPiecePort.h"
#import "XFReusedCellDelegate.h"

@interface BDJSqaureButton : UIButton <XFExpressPiecePort,XFReusedCellDelegate>

@property (nonatomic, weak) XFExpressPiece *expressPiece;
@property (nonatomic, copy) NSString *identifier;
@end
