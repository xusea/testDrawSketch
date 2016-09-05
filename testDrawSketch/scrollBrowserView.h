//
//  scrollBrowserView.h
//  testDrawSketch
//
//  Created by xusea on 16/6/29.
//  Copyright © 2016年 xusea. All rights reserved.
//
#import <Quartz/Quartz.h>
#import "premattview.h"
#import "mattviewController.h"
#import "mattwindowcontroller.h"
@class query2image;
@interface scrollBrowserView : IKImageBrowserView
{
    query2image * q2ipoint;
    int enteredind;
    NSPoint fixpos;
    NSRect targetrect;
    int cellspace;
    premattview * bigsizeimage;
    NSRect bigsizeimageframe;
    mattviewController * mattview;
    mattwindowcontroller * mattwindow;
    int DPIScale;
}
@property query2image * q2ipoint;
@property int enteredind;
@property NSPoint fixpos;
@property NSRect targetrect;
@property int cellspace;
@property premattview * bigsizeimage;
@property NSRect bigsizeimageframe;
@property mattviewController * mattview;
@property mattwindowcontroller * mattwindow;
@property int DPIScale;
-(int)getindexfrompoint:(NSPoint)point;
-(void)initial;
-(int)gettoolfrompoint:(NSPoint)point;
-(void)cleanalltoolsstatus;
-(void)cleanallenteredstatus;
@end
