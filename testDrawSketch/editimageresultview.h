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
    NSRect handlerect;
    int dragflag;
    NSPoint lastpoint;
    query2image * q2i;
    int status;//0 正常 1 选中 2 左上 3 坐下 4 右上 5 右下 6拖动
    int resizegap;
    float zoomfactor;
    NSSize cornersize;
    NSSize handlesize;
    CGFloat degree;
}
@property resultimageview * riv;
@property NSRect selectedrect;
@property NSRect handlerect;
@property int dragflag;
@property NSPoint lastpoint;
@property query2image * q2i;
@property int status;
@property int resizegap;
@property float zoomfactor;
@property NSSize cornersize;
@property NSSize handlesize;
@property CGFloat degree;
-(void)initial;
-(int)getSelectedDS:(NSPoint)point;
-(int)checkclickcorner:(NSPoint)point;
- (float) vectorangle:(NSPoint) startpoint endpoint:(NSPoint)endpoint;
- (NSRect) calcupos:(NSRect) border rotatedegree:(CGFloat)d;
@end
