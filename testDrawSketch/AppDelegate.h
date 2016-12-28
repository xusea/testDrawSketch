//
//  AppDelegate.h
//  testDrawSketch
//
//  Created by xusea on 16/5/26.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "drawSketch.h"
#import "imagetrans.h"
#import "downfile.h"
#import "query2image.h"
#import "scrollimagedelegate.h"
#import "thumbnailView.h"
#import "thumbnailViewCollection.h"
#import "drawSketchCollection.h"
#import "scrollBrowserView.h"
#import "resultimageview.h"
#import "mattviewController.h"
#import "premattview.h"
#import "mattwindowcontroller.h"
#import "resultdetailViewController.h"
#import "serverOptions.h"
#import "drawingBoard.h"
@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    query2image * qi;
    scrollimagedelegate * imagedatasource;
    thumbnailViewCollection * tvc;
    NSMutableArray * querydraw;
    NSMutableArray * colorset;
    int colorind;
    NSPoint fpos;
    NSThread* convert_progress;
    NSLock *lock;
    mattviewController * mattview;
    //NSWindow __unsafe_unretained * mattwindow;
    mattwindowcontroller * mattwindow;
    resultdetailViewController * resultdetailView;
    serverOptions * serveroption;
    float zoomFactor;
    int g_draworder;
    float curzoomFactor;
}
@property query2image * qi;
@property scrollimagedelegate * imagedatasource;
@property thumbnailViewCollection * tvc;
@property NSMutableArray * querydraw;
@property NSMutableArray * colorset;
@property int colorind;
@property NSPoint fpos;
@property NSThread * convert_progress;
@property NSLock * lock;
@property serverOptions * serveroption;
@property float zoomFactor;
@property int g_draworder;
@property float curzoomFactor;
- (IBAction)addDS:(id)sender;
- (IBAction)debug:(id)sender;
- (IBAction)trace2png:(id)sender;
- (IBAction)testdownfile:(id)sender;
-(NSString *)getrandstr;
-(void)run_convert;
//@property (weak) IBOutlet IKImageBrowserView *scrollimagelist;
@property (weak) IBOutlet scrollBrowserView *scrollimagelist;
@property (weak) IBOutlet NSScrollView *imageT;
@property (weak) IBOutlet NSScrollView *thumblist;
@property (weak) IBOutlet drawSketchCollection *dSC;
- (IBAction)start:(id)sender;
- (IBAction)statscore:(id)sender;
- (IBAction)showscores:(id)sender;
@property (weak) IBOutlet resultimageview *resultimage;
//@property (weak) IBOutlet resultimageview *riv;
- (IBAction)extend:(id)sender;
@property (weak) IBOutlet NSButton *extendbutton;
- (IBAction)showindex:(id)sender;
- (IBAction)scrollposition:(id)sender;
//@property (weak) IBOutlet NSImageView *bigsizeimage;
@property mattviewController* mattview;
@property (weak) IBOutlet premattview *bigsizeimage;
//@property(assign) IBOutlet NSWindow *mattwindow;
@property(weak) mattwindowcontroller * mattwindow;
@property(weak) resultdetailViewController * resultdetailView;
- (IBAction)opendetail:(id)sender;
- (IBAction)closedetail:(id)sender;
@property (weak) IBOutlet drawingBoard *drawingboard;
@property (weak) IBOutlet resultimageview *rivindrawingboard;
@property (weak) IBOutlet NSImageView *backgroundviewindrawingboard;
@property (weak) IBOutlet drawSketchCollection *dscindrawingboard;
@property (weak) IBOutlet boardshell *bsindrawingboard;
- (IBAction)zoomin:(id)sender;
- (IBAction)zoomout:(id)sender;
- (IBAction)block:(id)sender;
@property (weak) IBOutlet editimageresultview *eirvindrawingboard;

- (IBAction)eriveditenable:(id)sender;
- (IBAction)upimage:(id)sender;
- (IBAction)downimage:(id)sender;
- (IBAction)flipx:(id)sender;
- (IBAction)flipy:(id)sender;
@property (weak) IBOutlet NSSlider *showcontrast;
- (IBAction)modifycontrast:(id)sender;
@property (weak) IBOutlet NSSlider *showsaturation;
- (IBAction)modifysaturation:(id)sender;
@property (weak) IBOutlet NSSlider *showbrightness;
- (IBAction)modifybrightness:(id)sender;
@property (weak) IBOutlet boardshell *bsinnerindrawingboard;
@property (weak) IBOutlet backgroundview *bgvindrawingboard;
@property (weak) IBOutlet backgroundedit *bgeindrawingboard;

@end

