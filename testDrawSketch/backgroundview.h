//
//  backgroundview.h
//  testDrawSketch
//
//  Created by xusea on 2016/12/27.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class drawingBoard;
@interface backgroundview : NSView
{
    NSImage * bgimage;
    NSRect pointbound;
    int bgtype;
    drawingBoard * parentdb;
}
@property(readwrite) NSImage * bgimage;
@property(readwrite) NSRect pointbound;
@property(readwrite) int bgtype;
@property drawingBoard * parentdb;
@end
