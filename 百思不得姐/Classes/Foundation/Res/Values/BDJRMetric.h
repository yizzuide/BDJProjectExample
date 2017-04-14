//
//  BDJRMetric.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/11.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

/*TabBar标题字体大小*/
extern DefConstInt R_Size_Font_TabBarTitle;


/* ---------------- 全局 ---------------- */
/*状态栏高*/
extern DefConstInt R_Height_StautsBar;
/*导航条高*/
extern DefConstInt R_Height_NavBar;
/*状态栏+导航条高*/
extern DefConstInt R_Height_StautsWithNavBar;
/*TabBar高*/
extern DefConstInt R_Height_TabBar;


/* ---------------- Post ---------------- */
/*帖子分类标题视图高*/
extern DefConstInt R_Height_PostHeaderTabs;
/*帖子分类标题视图最大Y*/
extern DefConstInt R_MaxY_PostHeaderTabs;
/*帖子内容间隔*/
extern DefConstInt R_Size_PostCellMargin;
/*帖子顶部被裁高*/
extern DefConstInt R_Height_PostCellClip;
/*帖子底部工具条高*/
extern DefConstInt R_Height_PostCellBottomBar;
/*帖子标题栏高*/
extern DefConstInt R_Height_PostCellHeader;
/**
 *  帖子长图的最高限度
 */
extern DefConstInt R_Height_PostPictureMax;
/*帖子长图显示高度*/
extern DefConstInt R_Height_PostPictureBreak;
/*浏览长图最高长度*/
extern DefConstInt R_Height_PostPictureBrowseBreak;
/*帖子评论输入工具条 */
extern DefConstInt R_Height_PostInputBar;
/*帖子评论列表Section高*/
extern DefConstInt R_Height_PostCommentTableViewSectionHeader;


/* ---------------- Topic Tag ---------------- */
extern DefConstInt R_Size_Tag_margin;
extern DefConstInt R_Height_Tag;
extern DefConstInt R_Size_Font_Tag;










@interface BDJRMetric : NSObject

@end
