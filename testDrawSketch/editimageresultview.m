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
-(void)initial
{
    selectedrect = NSZeroRect;
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
    //NSRect locat;
    //locat.origin = currentPosition;
}

- (void)mouseDragged:(NSEvent *)theEvent
{
    
    NSPoint currentPosition = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    
}

- (void)mouseUp:(NSEvent *)theEvent
{
    selectedrect = NSZeroRect;
}
-(void)getSelectedDS:(NSPoint)point
{
    if(riv == nil)
    {
        return;
    }
    for(int i = 0; i < [[riv querydrawlist] count] ; i++)
    {
        query2image * q2i = [[riv querydrawlist] objectAtIndex:i];
        if([q2i displayflag] == 1 && NSPointInRect(point, [q2i imagedrawrect]))
        {
            selectedrect = [q2i imagedrawrect];
            [self setNeedsDisplay:YES];
            break;
        }
    }
}
@end
