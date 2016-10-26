//
//  drawingBoard.m
//  testDrawSketch
//
//  Created by xusea on 2016/10/26.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import "drawingBoard.h"

@implementation drawingBoard
@synthesize riv;
@synthesize dsc;
@synthesize backgroundview;
@synthesize bs;
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    NSRect bound = [self bounds];
    NSBezierPath *trace = [[NSBezierPath alloc]init];
    [trace setLineWidth:2];
    [[NSColor greenColor] set];
    //NSColor * cn = [c colorWithAlphaComponent:0.5];
    //[cn set];
    [trace appendBezierPathWithRect:bound];
    [trace closePath];
    [trace stroke];
    // Drawing code here.
}
-(void)initial
{
    NSRect frame = [self bounds];
    [bs setFrame:frame];
    [riv setFrame:frame];
    [dsc setFrame:frame];
    [backgroundview setFrame:frame];
}
@end
