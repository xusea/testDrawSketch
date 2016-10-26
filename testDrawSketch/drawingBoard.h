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
@interface drawingBoard : NSScrollView
{
    resultimageview * riv;
    NSImageView * backgroundview;
    drawSketchCollection * dsc;
    boardshell * bs;
}
@property resultimageview * riv;
@property NSImageView * backgroundview;
@property drawSketchCollection * dsc;
@property boardshell * bs;
-(void)initial;
@end
