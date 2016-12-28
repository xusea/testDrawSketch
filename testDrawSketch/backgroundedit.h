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
@interface backgroundedit : NSView
{
    NSImage * i;
    NSRect pointbound;
    NSRect imagebound;
    NSPoint lastpoint;
    float zoomfactor;
    NSSize cornersize;
    NSSize centersize;
    int status;
    backgroundview * background;
    int resizegap;
}
@property(readwrite) NSImage * i;
@property(readwrite) NSRect pointbound;
@property(readwrite) NSRect imageboung;
@property(readwrite) NSPoint lastpoint;
@property(readwrite) float zoomfactor;
@property(readwrite) NSSize cornersize;
@property(readwrite) NSSize centersize;
@property(readwrite) int status;
@property(readwrite) backgroundview * background;
@property(readwrite) int resizegap;
@end
