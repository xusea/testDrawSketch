//
//  editimageresultview.h
//  testDrawSketch
//
//  Created by xusea on 2016/11/1.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "resultimageview.h"
#import "query2image.h"
@interface editimageresultview : NSView
{
    resultimageview * riv;
    NSRect selectedrect;
    int dragflag;
    NSPoint lastpoint;
    query2image * q2i;
    int status;//0 正常 1 选中 2 左上 3 坐下 4 右上 5 右下
    int resizegap;
    float zoomfactor;
    NSSize cornersize;
}
@property resultimageview * riv;
@property NSRect selectedrect;
@property int dragflag;
@property NSPoint lastpoint;
@property query2image * q2i;
@property int status;
@property int resizegap;
@property float zoomfactor;
@property NSSize cornersize;
-(void)initial;
-(int)getSelectedDS:(NSPoint)point;
-(int)checkclickcorner:(NSPoint)point;
@end
