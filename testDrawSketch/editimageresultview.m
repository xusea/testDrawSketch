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
@synthesize lefttoprect;
@synthesize leftbuttomrect;
@synthesize righttoprect;
@synthesize rightbuttomrect;
@synthesize brightnessslider;
@synthesize contrastslider;
@synthesize saturationslider;
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
    
    lefttoprect = NSZeroRect;
    leftbuttomrect = NSZeroRect;
    righttoprect = NSZeroRect;
    rightbuttomrect = NSZeroRect;
    
    brightnessslider = nil;
    contrastslider = nil;
    saturationslider = nil;
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    
    if(!NSEqualRects(selectedrect , NSZeroRect))
    {
        NSRect bound = [self selectedrect];
        NSBezierPath *trace = [[NSBezierPath alloc]init];
        [trace setLineWidth:2];
        [[NSColor redColor] set];
        //NSColor * cn = [c colorWithAlphaComponent:0.5];
        //[cn set];
        [trace appendBezierPathWithRect:bound];
        [trace appendBezierPathWithRect:lefttoprect];
        [trace appendBezierPathWithRect:leftbuttomrect];
        [trace appendBezierPathWithRect:righttoprect];
        [trace appendBezierPathWithRect:rightbuttomrect];
        [trace closePath];
        [trace stroke];
    }
    CGFloat rotateDeg = degree;
    NSAffineTransform *rotate = [[NSAffineTransform alloc] init];
  
    [rotate translateXBy: selectedrect.origin.x + selectedrect.size.width/2 yBy:selectedrect.origin.y + selectedrect.size.height/2];
    [rotate rotateByDegrees:rotateDeg];
    [rotate translateXBy:-(selectedrect.origin.x + selectedrect.size.width/2) yBy:-(selectedrect.origin.y + selectedrect.size.height/2)];
   
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
        [tracehandle setLineWidth:1];
        [[NSColor greenColor] set];
        [tracehandle appendBezierPathWithRect:handlerect];
      
        [tracehandle closePath];
        [tracehandle stroke];
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
    if(status == 2 || status == 3 || status == 4 || status == 5)
    {
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
    //if(NSPointInRect(currentPosition, [self calculefttoppos:selectedrect rotatedegree:degree]))
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
    
    //currentPosition = [self calcuborderpointnorotate:currentPosition pos: status];
    lastpoint = currentPosition;
    

    [self setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)theEvent
{
    
    NSPoint currentPosition = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    
    
   // currentPosition = [self calcuborderpointnorotate:currentPosition pos: status];
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
                if(status == 2)
                {
                    NSPoint currentRotate = [self calcuborderpointnorotate:currentPosition pos: status];
                    NSPoint lastRatate = [self calcuborderpointnorotate:lastpoint pos: status];
                    NSPoint lastnail = [self calcuborderpointnorotate2:NSMakePoint(selectedrect.origin.x + selectedrect.size.width, selectedrect.origin.y) pos:5];
                    
                    selectedrect.origin.x += currentRotate.x - lastRatate.x;
                    selectedrect.size.height += currentRotate.y - lastRatate.y;
                    selectedrect.size.width -= currentRotate.x - lastRatate.x;
                    lastpoint = currentPosition;
                    
                    NSPoint currentnail = [self calcuborderpointnorotate2:NSMakePoint(selectedrect.origin.x + selectedrect.size.width, selectedrect.origin.y) pos:5];;
                    if(!NSEqualPoints(lastnail, NSZeroPoint))
                    {
                        selectedrect.origin.x -= currentnail.x - lastnail.x;
                        selectedrect.origin.y -= currentnail.y - lastnail.y;
                    }
                    
                }
                if(status == 3)
                {
                    NSPoint currentRotate = [self calcuborderpointnorotate:currentPosition pos: status];
                    NSPoint lastRatate = [self calcuborderpointnorotate:lastpoint pos: status];
                    NSPoint lastnail = [self calcuborderpointnorotate2:NSMakePoint(selectedrect.origin.x + selectedrect.size.width, selectedrect.origin.y + selectedrect.size.height) pos:5];
                    
                    selectedrect.origin.x += currentRotate.x - lastRatate.x;
                    selectedrect.origin.y += currentRotate.y - lastRatate.y;
                    selectedrect.size.width -= currentRotate.x - lastRatate.x;
                    selectedrect.size.height -= currentRotate.y - lastRatate.y;
                    lastpoint = currentPosition;

                    NSPoint currentnail = [self calcuborderpointnorotate2:NSMakePoint(selectedrect.origin.x + selectedrect.size.width, selectedrect.origin.y + selectedrect.size.height) pos:5];;
                    if(!NSEqualPoints(lastnail, NSZeroPoint))
                    {
                        selectedrect.origin.x -= currentnail.x - lastnail.x;
                        selectedrect.origin.y -= currentnail.y - lastnail.y;
                    }

                }
                
                if(status == 4)
                {
                    NSPoint currentRotate = [self calcuborderpointnorotate:currentPosition pos: status];
                    NSPoint lastRatate = [self calcuborderpointnorotate:lastpoint pos: status];
                    NSPoint lastnail = [self calcuborderpointnorotate2:NSMakePoint(selectedrect.origin.x , selectedrect.origin.y) pos:5];
                    
                    selectedrect.size.width += currentRotate.x - lastRatate.x;
                    selectedrect.size.height += currentRotate.y - lastRatate.y;
                    lastpoint = currentPosition;
                    
                    NSPoint currentnail = [self calcuborderpointnorotate2:NSMakePoint(selectedrect.origin.x , selectedrect.origin.y) pos:5];;
                    if(!NSEqualPoints(lastnail, NSZeroPoint))
                    {
                        selectedrect.origin.x -= currentnail.x - lastnail.x;
                        selectedrect.origin.y -= currentnail.y - lastnail.y;
                    }

                }
                
                if(status == 5)
                {
                    NSPoint currentRotate = [self calcuborderpointnorotate:currentPosition pos: status];
                    NSPoint lastRatate = [self calcuborderpointnorotate:lastpoint pos: status];
                    NSPoint lastnail = [self calcuborderpointnorotate2:NSMakePoint(selectedrect.origin.x , selectedrect.origin.y + selectedrect.size.height) pos:5];
                    
                    selectedrect.origin.y += currentRotate.y - lastRatate.y;
                    selectedrect.size.width += currentRotate.x - lastRatate.x;
                    selectedrect.size.height -= currentRotate.y - lastRatate.y;
                    lastpoint = currentPosition;
                    
                    NSPoint currentnail = [self calcuborderpointnorotate2:NSMakePoint(selectedrect.origin.x , selectedrect.origin.y + selectedrect.size.height) pos:5];;
                    if(!NSEqualPoints(lastnail, NSZeroPoint))
                    {
                        selectedrect.origin.x -= currentnail.x - lastnail.x;
                        selectedrect.origin.y -= currentnail.y - lastnail.y;
                    }
                }
            /*    if(status == 2
                   && currentPosition.x + resizegap < selectedrect.origin.x + selectedrect.size.width
                   && currentPosition.y > selectedrect.origin.y + resizegap)
                {
                    selectedrect.origin.x += currentPosition.x - lastpoint.x;
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
                    
                }*/
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
    NSRect handlerectrotate = [self calcupos:selectedrect rotatedegree:degree];
    NSRect lefttoprectrotate = [self calculefttoppos:selectedrect rotatedegree:degree];
    NSRect leftbuttomrectrotate = [self calculeftbuttompos:selectedrect rotatedegree:degree];
    NSRect righttoprectrotate = [self calcurighttoppos:selectedrect rotatedegree:degree];
    NSRect rightbuttomrectrotate = [self calcurightbuttompos:selectedrect rotatedegree:degree];
    if((status == 1 || status == 6)&& NSPointInRect(point, handlerectrotate))
    {
        return 6;
    }
    if((status == 1 || status == 2) && NSPointInRect(point, lefttoprectrotate))
    {
        status = 2;
        return 2;
    }
    if((status == 1 || status == 3) && NSPointInRect(point, leftbuttomrectrotate))
    {
        status = 3;
        return 3;
    }
    if((status == 1 || status == 4) && NSPointInRect(point, righttoprectrotate))
    {
        status = 4;
        return 4;
    }
    if((status == 1 || status == 5) && NSPointInRect(point, rightbuttomrectrotate))
    {
        status = 5;
        return 5;
    }
    for(int i = 0; i < [[riv querydrawlist] count] ; i++)
    {
        q2i = [[riv querydrawlist] objectAtIndex:i];
        if([q2i displayflag] == 1 && NSPointInRect(point, [q2i imagedrawrect]))
        {
            selectedrect = [q2i imagedrawrect];
            degree = [q2i degree];
            handlerect = NSMakeRect(0, 0, handlesize.width, handlesize.height);
            handlerect.origin.x = [self selectedrect].origin.x + [self selectedrect].size.width / 2.0 - handlerect.size.width / 2.0;
            handlerect.origin.y = [self selectedrect].origin.y + [self selectedrect].size.height + 20;
           // [q2i resetresimage];
            [self setNeedsDisplay:YES];
            
            return 1;
        }
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
- (NSRect) calculefttoppos:(NSRect) border rotatedegree:(CGFloat)d
{
    NSRect r;
    r.size.height = 20;
    r.size.width = 20;
    float p = sqrt(border.size.height / 2 * border.size.height / 2 + border.size.width / 2 * border.size.width / 2);
    float at = atanf(border.size.width / border.size.height) * 180 / 3.1415926;
    r.origin.x = p * cos((d+90 + at)*3.1415926/180);
    r.origin.y = p * sin((d+90 + at)*3.1415926/180);
    r.origin.x += border.origin.x + border.size.width/2 - r.size.width/2;
    r.origin.y += border.origin.y + border.size.height/2 - r.size.height/2 ;

    lefttoprect = r;
    return r;
    
}
- (NSRect) calculeftbuttompos:(NSRect) border rotatedegree:(CGFloat)d
{
    NSRect r;
    r.size.height = 20;
    r.size.width = 20;
    float p = sqrt(border.size.height / 2 * border.size.height / 2 + border.size.width / 2 * border.size.width / 2);
    float at = atanf(border.size.width / border.size.height) * 180 / 3.1415926;
    r.origin.x = p * cos((d+270-at)*3.1415926/180);
    r.origin.y = p * sin((d+270-at)*3.1415926/180);
    r.origin.x += border.origin.x + border.size.width/2 - r.size.width/2;
    r.origin.y += border.origin.y + border.size.height/2 - r.size.height/2 ;
    leftbuttomrect = r;
    return r;
    
}
- (NSRect) calcurighttoppos:(NSRect) border rotatedegree:(CGFloat)d
{
    NSRect r;
    r.size.height = 20;
    r.size.width = 20;
    float p = sqrt(border.size.height / 2 * border.size.height / 2 + border.size.width / 2 * border.size.width / 2);
    float at = atanf(border.size.width / border.size.height) * 180 / 3.1415926;
    r.origin.x = p * cos((d+90-at)*3.1415926/180);
    r.origin.y = p * sin((d+90-at)*3.1415926/180);
    r.origin.x += border.origin.x + border.size.width/2 - r.size.width/2;
    r.origin.y += border.origin.y + border.size.height/2 - r.size.height/2 ;
    righttoprect = r;
    return r;
}
- (NSRect) calcurightbuttompos:(NSRect) border rotatedegree:(CGFloat)d
{
    NSRect r;
    r.size.height = 20;
    r.size.width = 20;
    float p = sqrt(border.size.height / 2 * border.size.height / 2 + border.size.width / 2 * border.size.width / 2);
    float at = atanf(border.size.width / border.size.height) * 180 / 3.1415926;
    r.origin.x = p * cos((d+270+at)*3.1415926/180);
    r.origin.y = p * sin((d+270+at)*3.1415926/180);
    r.origin.x += border.origin.x + border.size.width/2 - r.size.width/2;
    r.origin.y += border.origin.y + border.size.height/2 - r.size.height/2 ;
    rightbuttomrect = r;
    return r;
}
- (NSPoint) calcuborderpointnorotate:(NSPoint) point pos:(int)pos
{
    NSPoint p = NSZeroPoint;
    NSPoint centerpoint = NSZeroPoint;
    centerpoint.x = selectedrect.origin.x + selectedrect.size.width / 2;
    centerpoint.y = selectedrect.origin.y + selectedrect.size.height / 2;
    
    p.x = (point.x - centerpoint.x) * cos(-degree * 3.1415926 / 180) - (point.y - centerpoint.y)*sin(-degree * 3.1415926 / 180) + centerpoint.x;
    p.y = (point.x - centerpoint.x) * sin(-degree * 3.1415926 / 180) + (point.y - centerpoint.y)*cos(-degree * 3.1415926 / 180) + centerpoint.y;
    return p;
    
}

- (NSPoint) calcuborderpointnorotate2:(NSPoint) point pos:(int)pos
{
    NSPoint p = NSZeroPoint;
    NSPoint centerpoint = NSZeroPoint;
    centerpoint.x = selectedrect.origin.x + selectedrect.size.width / 2;
    centerpoint.y = selectedrect.origin.y + selectedrect.size.height / 2;
    
    p.x = (point.x - centerpoint.x) * cos(degree * 3.1415926 / 180) - (point.y - centerpoint.y)*sin(degree * 3.1415926 / 180) + centerpoint.x;
    p.y = (point.x - centerpoint.x) * sin(degree * 3.1415926 / 180) + (point.y - centerpoint.y)*cos(degree * 3.1415926 / 180) + centerpoint.y;
    return p;
}

- (void) setBCS:(float)v BCS:(NSImageBCSType)BCS
{
    if(q2i != nil)
    {
        switch(BCS)
        {
            case IMGTbrightness:
                [q2i setBrightness:v];
              //  [q2i resetresimageBCSB];
                break;
            case IMGTsaturation:
                [q2i setSaturation:v];
              //  [q2i resetresimageBCSS];
                break;
            case IMGTcontrast:
                [q2i setContrast:v];
              //  [q2i resetresimageBCSC];
                break;
        }
        //[q2i resetresimageBCS];
        [q2i resetresimage];
        [riv setNeedsDisplay:YES];
    }
}
@end
