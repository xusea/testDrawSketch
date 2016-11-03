//
//  editimageresultview.m
//  testDrawSketch
//
//  Created by xusea on 2016/11/1.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import "editimageresultview.h"

@implementation editimageresultview
@synthesize riv;
@synthesize selectedrect;
@synthesize dragflag;
@synthesize lastpoint;
@synthesize q2i;
-(void)initial
{
    selectedrect = NSZeroRect;
    dragflag = 0;
    q2i = nil;
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    if(!NSEqualRects(selectedrect , NSZeroRect))
    {
        NSRect bound = [self selectedrect];
        NSBezierPath *trace = [[NSBezierPath alloc]init];
        [trace setLineWidth:2];
        [[NSColor blueColor] set];
        //NSColor * cn = [c colorWithAlphaComponent:0.5];
        //[cn set];
        [trace appendBezierPathWithRect:bound];
        [trace closePath];
        [trace stroke];
    }
    // Drawing code here.
}
- (void)mouseDown:(NSEvent *)theEvent
{
    NSPoint currentPosition = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    [self getSelectedDS:currentPosition];
    dragflag = 1;
    lastpoint = currentPosition;
    //NSRect locat;
    //locat.origin = currentPosition;
}

- (void)mouseDragged:(NSEvent *)theEvent
{
    
    NSPoint currentPosition = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    if(dragflag == 1)
    {
        if(!NSEqualRects(selectedrect, NSZeroRect))
        {
            selectedrect.origin.x -=  lastpoint.x - currentPosition.x;
            selectedrect.origin.y -=  lastpoint.y - currentPosition.y;
            [q2i setImagedrawrect:selectedrect];
            [riv setNeedsDisplay:YES];
            //[q2i imagedrawrect].origin.x -=  lastpoint.x - currentPosition.x;
           //
            
            [self setNeedsDisplay:YES];
        }
    }
    lastpoint = currentPosition;
    dragflag = 1;
}

- (void)mouseUp:(NSEvent *)theEvent
{
    selectedrect = NSZeroRect;
    dragflag = 0;
    q2i = nil;
    [self setNeedsDisplay:YES];
}
-(void)getSelectedDS:(NSPoint)point
{
    if(riv == nil)
    {
        return;
    }
    for(int i = 0; i < [[riv querydrawlist] count] ; i++)
    {
        q2i = [[riv querydrawlist] objectAtIndex:i];
        if([q2i displayflag] == 1 && NSPointInRect(point, [q2i imagedrawrect]))
        {
            selectedrect = [q2i imagedrawrect];
            [self setNeedsDisplay:YES];
            break;
        }
    }
}
@end
