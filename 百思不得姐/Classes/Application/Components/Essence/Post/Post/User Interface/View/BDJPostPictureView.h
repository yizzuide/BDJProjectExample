//
//  BDJPostPictureView.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/25.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFExpressPiecePort.h"

@interface BDJPostPictureView : UIView <XFExpressPiecePort>

@property (nonatomic, weak) XFExpressPiece *expressPiece;

+ (instancetype)postPictureView;
@end
