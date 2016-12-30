//
//  backgroundedit.h
//  testDrawSketch
//
//  Created by xusea on 2016/12/27.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "backgroundview.h"
#import "util.h"
@class drawingBoard;
@interface backgroundedit : NSView
{
    NSImage * bgimage;
    NSRect pointbound;
    NSRect imagebound;
    NSPoint lastpoint;
    float zoomfactor;
    NSSize cornersize;
    NSSize centersize;
    int status;
    backgroundview * background;
    int resizegap;
    drawingBoard * parentdb;
    int editflag;
}
@property NSImage * bgimage;
@property(readwrite) NSRect pointbound;
@property(readwrite) NSRect imagebound;
@property(readwrite) NSPoint lastpoint;
@property(readwrite) float zoomfactor;
@property(readwrite) NSSize cornersize;
@property(readwrite) NSSize centersize;
@property(readwrite) int status;
@property(readwrite) backgroundview * background;
@property(readwrite) int resizegap;
@property drawingBoard * parentdb;
@property int editflag;
-(void)initial;
@end
