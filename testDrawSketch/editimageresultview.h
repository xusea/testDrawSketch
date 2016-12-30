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
@class drawingBoard;
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
    
    //test rotata
    NSRect lefttoprect;
    NSRect leftbuttomrect;
    NSRect righttoprect;
    NSRect rightbuttomrect;
    
    NSSlider * brightnessslider;
    NSSlider * contrastslider;
    NSSlider * saturationslider;
    drawingBoard * parentdb;
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

@property NSRect lefttoprect;
@property NSRect leftbuttomrect;
@property NSRect righttoprect;
@property NSRect rightbuttomrect;

@property NSSlider * brightnessslider;
@property NSSlider * contrastslider;
@property NSSlider * saturationslider;
@property drawingBoard * parentdb;
-(void)initial;
-(int)getSelectedDS:(NSPoint)point;
-(int)checkclickcorner:(NSPoint)point;
- (float) vectorangle:(NSPoint) startpoint endpoint:(NSPoint)endpoint;
- (NSRect) calcupos:(NSRect) border rotatedegree:(CGFloat)d;
- (NSRect) calculefttoppos:(NSRect) border rotatedegree:(CGFloat)d;
- (NSRect) calculeftbuttompos:(NSRect) border rotatedegree:(CGFloat)d;
- (NSRect) calcurighttoppos:(NSRect) border rotatedegree:(CGFloat)d;
- (NSRect) calcurightbuttompos:(NSRect) border rotatedegree:(CGFloat)d;
- (NSPoint) calcuborderpointnorotate:(NSPoint) point pos:(int)pos;
- (NSPoint) calcuborderpointnorotate2:(NSPoint) point pos:(int)pos;
- (void) setBCS:(float)v BCS:(NSImageBCSType)BCS;
@end
