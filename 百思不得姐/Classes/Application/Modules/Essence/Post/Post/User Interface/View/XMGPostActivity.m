//
//  XMGPostActivity.m
//  百思不得姐
//
//  Created by 付星 on 2016/11/18.
//    Copyright © 2016年 yizzuide. All rights reserved.
//

#import "XMGPostActivity.h"
#import "XMGPostEventHandlerPort.h"

#define EventHandler  XFConvertPresenterToType(id<XMGPostEventHandlerPort>)

@interface XMGPostActivity ()

@end

@implementation XMGPostActivity

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self config];
    // 初始化视图
    [self setUpViews];
    // 绑定视图数据
    [self bindViewData];
}

#pragma mark - 初始化
- (void)config
{
    // 调整显示内容内边距
    // 设置滚动内容内边距
    self.tableView.contentInset = UIEdgeInsetsMake(R_MaxY_PostHeaderTabs, 0, self.tabBarController.tabBar.height, 0);
    // 设置滚动条内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}
- (void)setUpViews {
    
}

- (void)bindViewData {
    // 双向数据绑定
    //XF_$_(self.textField, text, EventHandler, text)
    // 绑定事件层按钮命令
    //XF_C_(self.btn, EventHandler, Command)
}


#pragma mark - UIControlDelegate

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor purpleColor];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"%@----%zd", [[self.eventHandler valueForKey:@"_routing"] class], indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LogVerbose(@"%@", NSStringFromUIEdgeInsets(tableView.contentInset));
    LogVerbose(@"%@", NSStringFromCGRect(tableView.frame));
}



#pragma mark - Getter



@end
