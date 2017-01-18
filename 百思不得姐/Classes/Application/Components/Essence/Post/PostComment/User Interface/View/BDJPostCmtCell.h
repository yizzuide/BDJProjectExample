//
//  BDJPostCmtCell.h
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/1.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XFExpressPiecePort.h"

@interface BDJPostCmtCell : UITableViewCell <XFExpressPiecePort>

@property (nonatomic, weak) XFExpressPiece *expressPiece;
@end
