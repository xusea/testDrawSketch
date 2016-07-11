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

@end

