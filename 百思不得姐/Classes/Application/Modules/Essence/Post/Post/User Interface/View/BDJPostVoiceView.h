//
//  BDJPostVoiceView.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/28.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFExpressPiecePort.h"

@interface BDJPostVoiceView : UIView <XFExpressPiecePort>

@property (nonatomic, weak) XFExpressPiece *expressPiece;

+ (instancetype)postVoiceView;
@end
