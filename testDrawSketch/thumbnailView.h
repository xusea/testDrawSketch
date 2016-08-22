//
//  thumbnailView.h
//  testDrawSketch
//
//  Created by xusea on 16/6/20.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import "thumbnailViewCollection.h"
#import "drawSketch.h"
#import "scrollBrowserView.h"
@class query2image;

@interface thumbnailView : NSView<NSTextFieldDelegate>
{
    NSString * query;
    NSImage * thumbnailsketch;
    int visibleflag;
    int positionflag;
    int backgroundflag;
    NSRect  drawrect;
    NSTextField * edittext;
    thumbnailViewCollection * parentcollection;
    int selectflag;
    NSColor * tracecolor;
    drawSketch * dspoint;
    NSRect thumbnailbounds;
    query2image * q2ipoint;
    //IKImageBrowserView * buttomimagelist;
    scrollBrowserView * buttomimagelist;
    NSButton * backgroundbutton;
}
@property NSString * query;
@property NSImage * thumbnailsketch;
@property int visibleflag;
@property int positionflag;
@property int backgroundflag;
@property NSRect  drawrect;
@property NSTextField * edittext;
@property thumbnailViewCollection * parentcollection;
@property int selectflag;
@property NSColor * tracecolor;
@property drawSketch * dspoint;
@property NSRect thumbnailbounds;
@property query2image * q2ipoint;
@property IKImageBrowserView * buttomimagelist;
@property NSButton * backgroundbutton;
-(void)setcurrentquery:(NSString *)q;
-(NSPoint)convertthumbnailpoint:(NSPoint) inpoint leftbuttom:(NSPoint)lbpoint righttop:(NSPoint)rtpoint;
@end
