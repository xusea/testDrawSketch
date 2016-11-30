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
#import <CoreImage/CoreImage.h>
extern float const IMGTcontrastIdentity;
extern float const IMGTcontrastMIN;
extern float const IMGTcontrastMAX;
extern float const IMGTsaturationIdentity;
extern float const IMGTsaturationMIN;
extern float const IMGTsaturationMAX;
extern float const IMGTbrightnessIdentity;
extern float const IMGTbrightnessMIN;
extern float const IMGTbrightnessMAX;
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
//图片翻转
+(NSImage *)flipImageByX:(NSImage *)image;
+(NSImage *)flipImageByY:(NSImage *)image;
+(NSImage *)flipImage:(NSImage *)image byx:(int)byx byy:(int)byy;
//图片格式转换
+(NSImage*)CGImageRef2NSImage:(CGImageRef)image;
+(CIImage*)NSImage2CIImage:(NSImage*)image;

typedef enum _NSImageBCSType {
    IMGTcontrast  = 0,
    IMGTsaturation,
    IMGTbrightness
} NSImageBCSType;
//修改图片对比度
+(NSImage*)NSImageContrast:(NSImage*)image contrast:(float)contrast;
//修改图片饱和度
+(NSImage*)NSImageSaturation:(NSImage*)image saturation:(float)saturation;
//修改图片亮度
+(NSImage*)NSImageBrightness:(NSImage*)image brightness:(float)brightness;
//修改图片对比度、饱和度、亮度
+(NSImage*)NSImageBCS:(NSImage*)image v:(float)v BCS:(NSImageBCSType)BCS;


@end

