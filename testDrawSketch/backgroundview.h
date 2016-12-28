//
//  backgroundview.h
//  testDrawSketch
//
//  Created by xusea on 2016/12/27.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface backgroundview : NSView
{
    NSImage * i;
    NSRect pointbound;
    int bgtype;
}
@property(readwrite) NSImage * i;
@property(readwrite) NSRect pointbound;
@property(readwrite) int bgtype;
@end
