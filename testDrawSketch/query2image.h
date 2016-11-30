//
//  query2image.h
//  testDrawSketch
//
//  Created by xusea on 16/6/14.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Quartz/Quartz.h>
#import "imageitem.h"
#import "scrollimagedelegate.h"
#import "drawSketch.h"
#import "thumbnailView.h"
#import "serverOptions.h"
#import "resultimageview.h"
@interface query2image : NSObject<NSURLSessionDownloadDelegate>
{
    NSString * query;
    NSMutableArray * selist;
    NSMutableArray * imageitemlist;
    NSMutableDictionary * url2file;
    scrollimagedelegate * imagesource;
    IKImageBrowserView * ikipoint;
    NSImage * thumbnail;
    drawSketch * dsketch;
    thumbnailView * thumbnailViewpoint;
    int selectflag;
    NSString * dir;
    int bestimageind;
    int selectedimageind;
    int visiblerange;
    int backgroundflag;
    serverOptions *serveroption;
    NSLock *lock;
    NSRect imagedrawrect;
    float rotateDeg;
    resultimageview * riv;
    int displayflag;
    CGFloat degree;
    int draworder;
    int flipx;
    int flipy;
    float saturation;
    float contrast;
    float brightness;
}
@property NSString * query;
@property NSMutableArray *selist;
@property NSMutableArray * imageitemlist;
@property NSMutableDictionary * url2file;
@property scrollimagedelegate * imagesource;
@property IKImageBrowserView * ikipoint;
@property drawSketch * dsketch;
@property thumbnailView * thumbnailViewpoint;
@property int selectflag;
@property NSString * dir;
@property int bestimageind;
@property int selectedimageind;
@property int visiblerange;
@property int backgroundflag;
@property serverOptions *serveroption;
@property NSLock * lock;
@property NSRect imagedrawrect;
@property float rotateDeg;
@property resultimageview * riv;
@property int displayflag;
@property CGFloat degree;
@property int draworder;
@property int flipx;
@property int flipy;
@property float saturation;
@property float contrast;
@property float brightness;
-(void)getimages;
-(void)downloadfile:(NSString *)url file:(NSString *)file;
-(NSString *)getDocumentsPath;
-(void)showResponseCode:(NSURLResponse *)response ;
-(NSString *)getrandstr;
-(NSString *)getrandnum;
-(int)getimagesfromseresult:(NSURL *)filename sesource:(NSString*) se;
-(int)getimagesfrombaiduresult:(NSURL *)filename;
-(int)getimagesfrombingresult:(NSURL *)filename;
-(int)getimagesfromsogouresult:(NSURL *)filename;
-(int)downloadimagefromse:(NSString *)se;
-(imageitem *)getdownimageitem;
-(void)statimagescore:(imageitem *)it;
-(imageitem *)getbestimageitem;
-(imageitem *)getselectedimageitem;
-(int)checkdownloadfile:(NSString *)filename;
-(void)resetbestimagescore;
-(void)forceselecteditem;
@end
