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
@synthesize handlerect;
@synthesize dragflag;
@synthesize lastpoint;
@synthesize q2i;
@synthesize status;
@synthesize resizegap;
@synthesize zoomfactor;
@synthesize cornersize;
@synthesize handlesize;
@synthesize degree;
-(void)initial
{
    selectedrect = NSZeroRect;
    handlerect = NSZeroRect;
    dragflag = 0;
    q2i = nil;
    status = 0;
    resizegap = 40;
    zoomfactor = 1.0;
    cornersize = NSMakeSize(20, 20);
    handlesize = NSMakeSize(20, 20);
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    CGFloat rotateDeg = degree;
    NSAffineTransform *rotate = [[NSAffineTransform alloc] init];
  //  if(status == 6)
    //{
      //  [rotate translateXBy:dirtyRect.size.width/2 yBy:dirtyRect.size.height/2];
      //  [rotate rotateByDegrees:rotateDeg];
      //  [rotate translateXBy:-dirtyRect.size.width/2 yBy:-dirtyRect.size.height/2];
   // }
   // else
   // {
        [rotate translateXBy: selectedrect.origin.x + selectedrect.size.width/2 yBy:selectedrect.origin.y + selectedrect.size.height/2];
        [rotate rotateByDegrees:rotateDeg];
        [rotate translateXBy:-(selectedrect.origin.x + selectedrect.size.width/2) yBy:-(selectedrect.origin.y + selectedrect.size.height/2)];
   // }
    [rotate concat];
    
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
        
        
        NSBezierPath *tracehandle = [[NSBezierPath alloc]init];
        [tracehandle setLineWidth:2];
        [[NSColor greenColor] set];
      /*  NSRect rotatehandle = NSMakeRect(0, 0, 20, 20);
        
        rotatehandle.origin.x = [self selectedrect].origin.x + [self selectedrect].size.width / 2.0 - rotatehandle.size.width / 2.0;
        rotatehandle.origin.y = [self selectedrect].origin.y + [self selectedrect].size.height + 20;*/
        [tracehandle appendBezierPathWithRect:handlerect];
        [tracehandle closePath];
        [tracehandle stroke];
        //handlerect = [self calcupos:selectedrect rotatedegree:rotateDeg];
    }
    // Drawing code here.
}
- (void)mouseDown:(NSEvent *)theEvent
{
    
    NSPoint currentPosition = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    int newstatus = [self getSelectedDS:currentPosition];
    if(newstatus == 0)
    {
        status = 0;
        [self setNeedsDisplay:YES];
        return;
    }
    if(status == 0)
    {
        status = 1;
        [self setNeedsDisplay:YES];
        return;
    }
    if(status == 1  && newstatus == 6)
    {
        status = 6;
        [self setNeedsDisplay:YES];
        return;
    }
    NSRect lefttop, righttop, leftbuttom, rightbuttom;
    NSSize cur_cornersize = cornersize;
    cur_cornersize.width /= zoomfactor;
    cur_cornersize.height /= zoomfactor;
    lefttop.size = cur_cornersize;
    righttop.size = cur_cornersize;
    leftbuttom.size = cur_cornersize;
    rightbuttom.size = cur_cornersize;
    lefttop.origin.x = selectedrect.origin.x;
    lefttop.origin.y = selectedrect.origin.y + selectedrect.size.height - cur_cornersize.height;
    
    righttop.origin.x = selectedrect.origin.x + selectedrect.size.width - cur_cornersize.width;
    righttop.origin.y = selectedrect.origin.y + selectedrect.size.height - cur_cornersize.height;
    
    leftbuttom.origin.x = selectedrect.origin.x;
    leftbuttom.origin.y = selectedrect.origin.y;
    
    rightbuttom.origin.x = selectedrect.origin.x + selectedrect.size.width - cur_cornersize.width;
    rightbuttom.origin.y = selectedrect.origin.y;
    
    if(NSPointInRect(currentPosition, lefttop))
    {
        NSLog(@"click in lefttop");
        status = 2;
        return;
    }
    
    if(NSPointInRect(currentPosition, leftbuttom))
    {
        NSLog(@"click in leftbuttom");
        status = 3;
        return;
    }
    
    if(NSPointInRect(currentPosition, righttop))
    {
        NSLog(@"click in righttop");
        status = 4;
        return;
    }
    
    if(NSPointInRect(currentPosition, rightbuttom))
    {
        NSLog(@"click in rightbuttom");
        status = 5;
        return;
    }

    
    dragflag = 1;
    lastpoint = currentPosition;
    

    [self setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)theEvent
{
    
    NSPoint currentPosition = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    if(dragflag == 1)
    {
        if(!NSEqualRects(selectedrect, NSZeroRect))
        {
            if(status == 1)
            {
                selectedrect.origin.x -=  lastpoint.x - currentPosition.x;
                selectedrect.origin.y -=  lastpoint.y - currentPosition.y;
                lastpoint = currentPosition;
            }
            else
            {
                //lefttop
                if(status == 2
                   && currentPosition.x + resizegap < selectedrect.origin.x + selectedrect.size.width
                   && currentPosition.y > selectedrect.origin.y + resizegap)
                {
                    selectedrect.origin.x += currentPosition.x - lastpoint.x;
                    //selectedrect.origin.y += currentPosition.y - lastpoint.y;
                    selectedrect.size.height += currentPosition.y - lastpoint.y;
                    selectedrect.size.width -= currentPosition.x - lastpoint.x;
                    lastpoint = currentPosition;
                    
                }
                //leftbuttom
                if(status == 3
                   && currentPosition.x + resizegap < selectedrect.origin.x + selectedrect.size.width
                   && currentPosition.y + resizegap < selectedrect.origin.y + selectedrect.size.height)
                {
                    selectedrect.origin.x += currentPosition.x - lastpoint.x;
                    selectedrect.origin.y += currentPosition.y - lastpoint.y;
                    selectedrect.size.width -= currentPosition.x - lastpoint.x;
                    selectedrect.size.height -= currentPosition.y - lastpoint.y;
                    lastpoint = currentPosition;
                    
                }
                //righttop
                if(status == 4
                   && currentPosition.x - resizegap > selectedrect.origin.x
                   && currentPosition.y - resizegap > selectedrect.origin.y)
                {
                    selectedrect.size.height += currentPosition.y - lastpoint.y;
                    selectedrect.size.width += currentPosition.x - lastpoint.x;
                    lastpoint = currentPosition;
                    
                }
                //rightbuttom
                if(status == 5
                   && currentPosition.x - resizegap > selectedrect.origin.x
                   && currentPosition.y + resizegap < selectedrect.origin.y + selectedrect.size.height)
                {
                    selectedrect.origin.y += currentPosition.y - lastpoint.y;
                    selectedrect.size.height -= currentPosition.y - lastpoint.y;
                    selectedrect.size.width += currentPosition.x - lastpoint.x;
                    lastpoint = currentPosition;
                    
                }
                if(status == 6)
                {
                    degree = [self vectorangle:handlerect.origin endpoint:currentPosition];
                }
                else
                {
                    currentPosition = lastpoint;
                }
            }
            
            
        }
        [q2i setImagedrawrect:selectedrect];
        [q2i setDegree:degree];
        [riv setNeedsDisplay:YES];
        [self setNeedsDisplay:YES];
    }
    handlerect = NSMakeRect(0, 0, handlesize.width, handlesize.height);
    handlerect.origin.x = [self selectedrect].origin.x + [self selectedrect].size.width / 2.0 - handlerect.size.width / 2.0;
    handlerect.origin.y = [self selectedrect].origin.y + [self selectedrect].size.height + 20;
    lastpoint = currentPosition;
    dragflag = 1;
}

- (void)mouseUp:(NSEvent *)theEvent
{
    //selectedrect = NSZeroRect;
    dragflag = 0;
    if(status == 2 || status == 3 || status == 4 || status == 5 || status == 6)
    {
        status = 1;
    }
    //q2i = nil;
    //[self setNeedsDisplay:YES];
}
-(int)getSelectedDS:(NSPoint)point
{
    if(riv == nil)
    {
        return 0;
    }
    for(int i = 0; i < [[riv querydrawlist] count] ; i++)
    {
        q2i = [[riv querydrawlist] objectAtIndex:i];
        if([q2i displayflag] == 1 && NSPointInRect(point, [q2i imagedrawrect]))
        {
            selectedrect = [q2i imagedrawrect];
            handlerect = NSMakeRect(0, 0, handlesize.width, handlesize.height);
            handlerect.origin.x = [self selectedrect].origin.x + [self selectedrect].size.width / 2.0 - handlerect.size.width / 2.0;
            handlerect.origin.y = [self selectedrect].origin.y + [self selectedrect].size.height + 20;
            [self setNeedsDisplay:YES];
            return 1;
        }
    }
    NSRect handlerectrotate = [self calcupos:selectedrect rotatedegree:degree];
    if(status == 1 && NSPointInRect(point, handlerectrotate))
    {
        
        return 6;
    }
    selectedrect = NSZeroRect;
    q2i = nil;
    return 0;
}
-(int)checkclickcorner:(NSPoint)point
{
    if(NSEqualRects(selectedrect, NSZeroRect))
    {
        return 0;
    }
    
    return 0;
}

- (float) vectorangle:(NSPoint) startpoint endpoint:(NSPoint)endpoint
{
    float angle = 0;
    
    float centerx = selectedrect.origin.x + selectedrect.size.width/2;
    float centery = selectedrect.origin.y + selectedrect.size.height/2;
    
    NSPoint newstartpoint = startpoint;
    newstartpoint.x -= centerx;
    newstartpoint.y -= centery;
    
    NSPoint newendpoint = endpoint;
    newendpoint.x -= centerx;
    newendpoint.y -= centery;
    
    float cosvalue = (newstartpoint.x * newendpoint.x + newstartpoint.y * newendpoint.y)/(sqrt(newstartpoint.x * newstartpoint.x + newstartpoint.y * newstartpoint.y) * sqrt(newendpoint.x * newendpoint.x + newendpoint.y * newendpoint.y));
    
    angle = acosf(cosvalue) * 180 / 3.1415926;
    
    int flag = newstartpoint.x * newendpoint.y - newstartpoint.y * newendpoint.x > 0? 1: -1;
    
    return angle * flag;
}

- (NSRect) calcupos:(NSRect) border rotatedegree:(CGFloat)d
{
    NSRect r;
    r.size.height = 20;
    r.size.width = 20;
    float p = border.size.height / 2 + 20;
    r.origin.x = p * cos((d+90)*3.1415926/180);
    r.origin.y = p * sin((d+90)*3.1415926/180);
    r.origin.x += border.origin.x + border.size.width/2 - r.size.width/2;
    r.origin.y += border.origin.y + border.size.height/2 - r.size.height/2 ;
    
    return r;
}

@end
