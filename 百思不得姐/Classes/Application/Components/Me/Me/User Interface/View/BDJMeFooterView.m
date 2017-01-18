//
//  BDJMeFooterView.m
//  百思不得姐
//
//  Created by Yizzuide on 2016/12/8.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import "BDJMeFooterView.h"
#import "BDJSqaureButton.h"
#import "BDJMeEventHandlerPort.h"
#import "XFWaterflowView.h"


@interface BDJMeFooterView () <XFWaterflowViewDataSource,XFSimpleFlowViewDelegate>

@property (nonatomic, weak) XFWaterflowView *waterFlowView;
@end

@implementation BDJMeFooterView

static NSString *ID = @"sqaureCell";

- (void)setExpressPeices:(NSArray<XFExpressPiece *> *)expressPeices
{
    _expressPeices = expressPeices;
    /* ---------------- 使用手动计算Frame ---------------- */
    /*NSUInteger count = expressPeices.count;
    for (int i = 0; i < count; i++) {
        BDJSqaureButton *button = [[BDJSqaureButton alloc] init];
        [button setExpressPiece:expressPeices[i]];
        [self addSubview:button];
    }*/
    /* --------------------------------------------- */
    
    // 使用流水布局框架
    [self.waterFlowView reloadData];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.waterFlowView.frame = self.bounds;
}


#pragma mark - DataSource
- (NSInteger)numberOfColumnsInWaterflowView:(XFWaterflowView *)waterflowView
{
    return SqaureMaxCols;
}

- (NSUInteger)simpleFlowView:(XFSimpleFlowView *)simpleFlowView numberOfRowsInSection:(NSInteger)section
{
    return self.expressPeices.count;
}

- (id<XFReusedCellDelegate>)simpleFlowView:(XFSimpleFlowView *)simpleFlowView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BDJSqaureButton *cell = [simpleFlowView dequeueReusableCellWithIdentifier:ID];
    cell.expressPiece = self.expressPeices[indexPath.row];
    return cell;
}

#pragma mark - Delegate
- (CGFloat)simpleFlowView:(XFReusedScrollView *)simpleFlowView marginForType:(XFSimpleFlowViewMarginType)type
{
    return 0;
}

- (CGFloat)simpleFlowView:(XFSimpleFlowView *)simpleFlowView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenSize.width / SqaureMaxCols;
}

- (XFWaterflowView *)waterFlowView {
	if(_waterFlowView == nil) {
        XFWaterflowView *flowView = [[XFWaterflowView alloc] init];
        flowView.dataSource = self;
        flowView.delegate = self;
        flowView.frame = CGRectMake(0, 0, ScreenBounds.size.width, 0);
        [self addSubview:flowView];
        _waterFlowView = flowView;
        // 注册Cell
        [self.waterFlowView registerClass:[BDJSqaureButton class] forCellReuseIdentifier:ID];
	}
	return _waterFlowView;
}

@end
