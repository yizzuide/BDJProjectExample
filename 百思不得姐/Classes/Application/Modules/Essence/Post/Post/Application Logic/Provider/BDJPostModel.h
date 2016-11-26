//
//  BDJPostModel.h
//  百思不得姐
//
//  Created by 付星 on 2016/11/21.
//  Copyright © 2016年 yizzuide. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 帖子的类型，1为全部 10为图片 29为段子 31为音频 41为视频 */
typedef enum : NSUInteger {
    BDJPostDataMediaTypeAll = 1,
    BDJPostDataMediaTypePictrue = 10,
    BDJPostDataMediaTypeWords = 29,
    BDJPostDataMediaTypeVoice = 31,
    BDJPostDataMediaTypeVideo = 41
} BDJPostDataMediaType;

@interface BDJPostModel : NSObject

/** 用户名 */
@property (nonatomic, copy) NSString* name;
/** 用户ID */
@property (nonatomic, assign) NSInteger  user_id;

/** pid */
@property (nonatomic, assign) NSInteger  original_pid;

/** 用户图像 */
@property (nonatomic, copy) NSString* profile_image;

/** 用户显示名 */
@property (nonatomic, copy) NSString* screen_name;

/* 是否是新浪会员 */
@property (nonatomic, assign) BOOL sina_v;
/* 是否是百思不得姐的认证用户 */
@property (nonatomic, assign) BOOL jie_v;


/** 帖子ID */
@property (nonatomic, assign) NSInteger  ID;
/** 帖子的状态 */
@property (nonatomic, assign) NSInteger  status;
/** 缓存版本 */
@property (nonatomic, assign) NSInteger  cache_version;

/** 系统审核通过后创建帖子的时间 */
@property (nonatomic, copy) NSString* created_at;
/** 帖子通过的时间和created_at的参数时间一致 */
@property (nonatomic, copy) NSString* passtime;
/** 创建时间 */
@property (nonatomic, copy) NSString* create_time;
/** 帖子的类型? */
@property (nonatomic, assign) NSInteger  t;
/** 帖子的类型，1为全部 10为图片 29为段子 31为音频 41为视频 */
@property (nonatomic, assign) BDJPostDataMediaType  type;


/** ??? */
@property (nonatomic, strong) NSArray* top_cmt;

/** 转发数量 */
@property (nonatomic, assign) NSInteger  repost;

/** 赞 */
@property (nonatomic, assign) NSInteger  ding;

/** 踩 */
@property (nonatomic, assign) NSInteger  hate;

/** 评论数 */
@property (nonatomic, assign) NSInteger  comment;
/** 收藏量 */
@property (nonatomic, assign) NSInteger  favourite;
/** 收藏量 */
@property (nonatomic, assign) NSInteger  bookmark;

/** 踩 */
@property (nonatomic, assign) NSInteger  cai;

/** 赞 */
@property (nonatomic, assign) NSInteger  love;

/** 标签 */
@property (nonatomic, strong) NSArray* themes;
/** 帖子的所属分类的标签名字 */
@property (nonatomic, copy) NSString* theme_name;
/** 一般为1 */
@property (nonatomic, assign) NSInteger  theme_type;
/** 标签的id,如：微视频的id为55 */
@property (nonatomic, assign) NSInteger  theme_id;
/** 帖子的标签备注 */
@property (nonatomic, copy) NSString* tag;


/** 文本 */
@property (nonatomic, copy) NSString* text;



/** 是否是gif图 */
@property (nonatomic, assign) BOOL  is_gif;
/*小图*/
@property (nonatomic, copy) NSString* image_thumb;/*image0*/
/*大图*/
@property (nonatomic, copy) NSString* image_large;/*image1*/
/*中图*/
@property (nonatomic, copy) NSString* image_middle;/*image2*/
/** 小图? */
//@property (nonatomic, copy) NSString* image_small;
/** 大图? */
//@property (nonatomic, copy) NSString* bimageuri;

/** 微信连接 */
@property (nonatomic, copy) NSString* weixin_url;

/** 音频播放地址 */
@property (nonatomic, copy) NSString* voiceuri;

/** 音频时间 */
@property (nonatomic, assign) NSInteger  voicetime;

/** 音频时间长度 */
@property (nonatomic, assign) NSInteger  voicelength;

/** 视频加载时候的静态显示的图片地址 */
@property (nonatomic, copy) NSString* cdn_img;
/** 视频播放地址 */
@property (nonatomic, copy) NSString* videouri;

/** 视频时间 */
@property (nonatomic, assign) NSInteger  videotime;

/** 播放数量 */
@property (nonatomic, assign) NSInteger  playcount;
/** 播放数量 */
@property (nonatomic, assign) NSInteger  playfcount;

/** 图宽度 */
@property (nonatomic, assign) NSInteger  width;
/** 图高 */
@property (nonatomic, assign) NSInteger  height;
@end
