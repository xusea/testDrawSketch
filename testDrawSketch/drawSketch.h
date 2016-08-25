//
//  drawSketch.h
//  testDrawSketch
//
//  Created by xusea on 16/5/26.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "imagetrans.h"
@class thumbnailView;
@class BrushPoint;
/*@interface BrushPoint : NSObject
{
    NSPoint p;  //当前点
    int undoflag;   //之后点不画了
    int t;  //线段中断点
}

@property (readwrite) NSPoint p;
@property (readwrite) int undoflag;
@property (readwrite) int t;
@end*/

@interface drawSketch : NSView
{
    NSMutableArray * drawtrace;
    NSString * query;
    int displayflag;
    NSColor *tracecolor;
    int tracewidth;
    int validpath;
    int rnum;
    int drawflag;
    NSPoint fixpos;
    thumbnailView * tnVpoint;
    NSPoint leftbuttom;
    NSPoint righttop;
    NSString * tracefillcontourpath;
    NSString * dir;
}
@property(readwrite) NSMutableArray * drawtrace;
@property(readwrite) NSString * query;
@property(readwrite) int displayflag;
@property(readwrite) NSColor *tracecolor;
@property(readwrite) int tracewidth;
@property(readwrite) int validpath;
@property(readwrite) int rnum;
@property(readwrite) int drawflag;
@property(readwrite) NSPoint fixpos;
@property(readwrite) thumbnailView * tnVpoint;
@property(readwrite) NSPoint leftbuttom;
@property(readwrite) NSPoint righttop;
@property(readwrite) NSString * tracefillcontourpath;
@property(readwrite) NSString * dir;
- (void)removepath;
- (void)undo;
- (void)redo;
- (void)trace2png;
- (void)getmaxbound:(NSPoint) inpoint;
@end
