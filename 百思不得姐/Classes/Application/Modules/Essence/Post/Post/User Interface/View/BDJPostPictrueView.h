//
//  BDJPostPictrueView.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/25.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>


@class XFExpressPiece;
@interface BDJPostPictrueView : UIView

@property (nonatomic, weak) XFExpressPiece *expressPiece;

+ (instancetype)postPictrueView;
@end
