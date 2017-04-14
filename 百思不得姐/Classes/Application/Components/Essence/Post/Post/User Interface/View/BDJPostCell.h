//
//  BDJPostCell.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/22.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFExpressPiecePort.h"

@interface BDJPostCell : UITableViewCell <XFExpressPiecePort>

@property (nonatomic, weak) XFExpressPiece *expressPiece;

@end
