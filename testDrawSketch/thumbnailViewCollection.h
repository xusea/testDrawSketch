//
//  thumbnailViewCollection.h
//  testDrawSketch
//
//  Created by xusea on 16/6/20.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import <Cocoa/Cocoa.h>
//#import "drawingBoard.h"
@class drawingBoard;
@interface thumbnailViewCollection : NSView
{
    drawingBoard * db;
}
@property drawingBoard * db;
@end
