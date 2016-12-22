//
//  drawingBoard.h
//  testDrawSketch
//
//  Created by xusea on 2016/10/26.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "resultimageview.h"
#import "drawSketchCollection.h"
#import "boardshell.h"
#import "editimageresultview.h"
@interface drawingBoard : NSScrollView
{
    resultimageview * riv;
    NSImageView * backgroundview;
    drawSketchCollection * dsc;
    boardshell * bs;
    boardshell * bsinner;
    editimageresultview * eirv;
}
@property resultimageview * riv;
@property NSImageView * backgroundview;
@property drawSketchCollection * dsc;
@property boardshell * bs;
@property boardshell * bsinner;
@property editimageresultview * eirv;
-(void)initial;
-(void)forcebestimage;
@end
