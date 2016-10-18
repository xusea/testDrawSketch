//
//  imagetrans.h
//  testDrawSketch
//
//  Created by xusea on 16/6/1.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "opencvproxy.hpp"
@interface imagetrans : NSObject
+(void)test;
//笔迹转黑白图片
+(NSImage *)png2gray:(NSImage *)inimage;
//图片转存到本地文件
+(void)png2file:(NSImage *)inimage outfile:(NSString*)outfile;
//笔迹文件转黑白图片
+(void)pngfile2grayfile:(NSString *)infile outfile:(NSString *)outfile;
//黑白图片内部填充
+(void)fillcontour:(NSString *)infile outfile:(NSString *)outfile;
//核心算法呢，图片自动cut，彩色图片转为黑白主体
+(void)imagecut:(NSString *)infile outfile:(NSString *)outfile logfile:(NSString *)logfile;
//图片比较
+(double)imagecom:(NSString *)leftfile rightfile:(NSString *)rightfile;
//图片裁剪，根据一张黑图和一张彩色图计算出彩色主体
+(void)imagesketch:(NSString *)grayimage orgimage:(NSString *)orgimage outimage:(NSString *)outimage;
//透明图片裁剪，将透明部分去掉，保留主体
+(void)cutalpha:(NSString *)orgimage outimage:(NSString *)outimage;
//修改图片dpi到72
+(void)convertDPI72:(NSString *)orgimage outimage:(NSString *)outimage;
//缩放图片
+(void)resizeimage:(NSString *)orgimage outimage:(NSString *)outimage newsize:(NSSize)ns;
//透明图片填充边框
+(void)fillalpha:(NSString *)orgimage outimage:(NSString *)outimage;
//将黑白图片转为stroke
+(void)gray2stroke:(NSString *)logfile strokename:(NSString*)strokename;
//将彩色图片转为stroke
+(void)color2stroke:(NSString *)logfile strokename:(NSString*)strokename;
//计算图片位置
+(NSRect)getDrawPosition:(NSRect)resultimage canves:(NSRect)canves sketch:(NSRect)sketch transparent:(NSRect)transparent;
@end

