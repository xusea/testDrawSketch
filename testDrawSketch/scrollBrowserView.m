//
//  scrollBrowserView.m
//  testDrawSketch
//
//  Created by xusea on 16/6/29.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import "scrollBrowserView.h"
#import "scrollCell.h"
#import "query2image.h"
@implementation scrollBrowserView
@synthesize q2ipoint;
@synthesize enteredind;
@synthesize fixpos;
@synthesize targetrect;
@synthesize cellspace;
@synthesize bigsizeimage;
-(void)initial
{
    enteredind = -1;
    
    targetrect.origin.x = 10;
    targetrect.origin.y = 10;
    targetrect.size.height = 115;
    targetrect.size.width = 100;
    cellspace = 20;

}
- (id)initWithFrame:(NSRect)frame
{
    
    self = [super initWithFrame:frame];
    [self initial];
    return self;
}
- (void) awakeFromNib{
    
    [super awakeFromNib];
   // NSLog(@"bounds %lf %lf ", [self bounds].size.width, [self bounds].size.height);
    [self initial];
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    /*int pos = 0;
    for(int i = 0 ;i < [[[q2ipoint imagesource] scrollimages] count]; i ++)
    {
        NSRect bound;
        bound.size.width = 40;
        bound.size.height = 40;
        bound.origin.x = pos;
        bound.origin.y = 0;
        pos += 40;
        NSBezierPath *trace = [[NSBezierPath alloc]init];
        [trace setLineWidth:2];
        [[NSColor blueColor] set];
        [trace appendBezierPathWithRect:bound];
        [trace closePath];
        [trace stroke];
        NSLog(@"%d", i);
    }*/
    
    
   /* NSRect bound = [self frame];
    bound.origin.x = 0;
    bound.origin.y = 0;
    NSBezierPath *trace = [[NSBezierPath alloc]init];
    [trace setLineWidth:2];
    [[NSColor blueColor] set];
    [trace appendBezierPathWithRect:bound];
    [trace closePath];
    [trace fill];*/
    // Drawing code here.
}
- (IKImageBrowserCell *)newCellForRepresentedItem:(id)cell
{
    return [[scrollCell alloc] init];
}
- (void)mouseDown:(NSEvent *)theEvent
{
    
    NSPoint currentPosition = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    
    NSInteger idx  = [self indexOfItemAtPoint:currentPosition];
    int index =[self getindexfrompoint:currentPosition];
    NSLog(@"click item %d", index);
    if (idx != NSNotFound)
    {
        NSRect rect = [self itemFrameAtIndex:idx];
        NSLog(@"click %ld [%lf %lf %lf %lf]", idx, rect.size.height, rect.size.width, currentPosition.x, currentPosition.y);
    }
    return;
}
- (void)mouseEntered:(NSEvent *)theEvent
{
    NSPoint currentPosition = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    
    //NSInteger idx  = [self indexOfItemAtPoint:currentPosition];
    int idx = [self getindexfrompoint:currentPosition];
    if(idx != -1)
    {
        MyScrollImageObject * mio = [[[[self q2ipoint]imagesource] scrollimages]objectAtIndex:idx];
        NSArray * subtitlestrs = [[mio subtitle] componentsSeparatedByString:@"_"];
        NSString * newsubtitle = [NSString stringWithFormat:@"%@_%@_%@", [subtitlestrs objectAtIndex:0], [subtitlestrs objectAtIndex:1], @"1"];
        [mio setSubtitle:newsubtitle];
        for(int i = 0;i < [[[self q2ipoint] imageitemlist] count]; i ++)
        {
            if(mio == [[[[self q2ipoint] imageitemlist]objectAtIndex:i] myiobjectpoint])
            {
                
                [bigsizeimage setHidden:NO];
                imageitem * it = [[[self q2ipoint] imageitemlist]objectAtIndex:i];
                NSImage * image = [[NSImage alloc] initWithContentsOfFile:[it filename]];
                [bigsizeimage setImage:image];
            }
        }
    }
    else
    {
        NSLog(@"entered ???");
    }
    [self setNeedsDisplay:YES];
    
    
    //NSLog(@"entered %d", [self getindexfrompoint:currentPosition]);
}
- (void)mouseExited:(NSEvent *)theEvent
{
    [bigsizeimage setHidden:YES];
    for(int i = 0; i < [[[q2ipoint imagesource] scrollimages] count]; i ++)
    {
        MyScrollImageObject * mio = [[[[self q2ipoint]imagesource] scrollimages]objectAtIndex:i];
        NSArray * subtitlestrs = [[mio subtitle] componentsSeparatedByString:@"_"];
        NSString * newsubtitle = [NSString stringWithFormat:@"%@_%@_%@", [subtitlestrs objectAtIndex:0], [subtitlestrs objectAtIndex:1], @"0"];
        [mio setSubtitle:newsubtitle];
    }
    [self setNeedsDisplay:YES];
   /* NSPoint currentPosition = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    NSLog(@"exited point [%lf %lf]", currentPosition.x, currentPosition.y);
    int x[4] = {0,2,0,-2};
    int y[4] = {2,0,-2,0};
    for(int i = 0;i < 4;i ++)
    {
        NSPoint p = currentPosition;
        p.x += x[i];
        p.y += y[i];
        int ind = [self getindexfrompoint:p];
        if(ind != -1)
        {
            NSLog(@"exited %d", ind);
            return;
        }
    }*/
    //NSInteger idx  = [self indexOfItemAtPoint:currentPosition];
    
    //NSLog(@"exited %d", [self getindexfrompoint:currentPosition]);
}
- (void)updateTrackingAreas
{
    for(int i = 0; i< [[self trackingAreas] count]; i ++)
    {
        NSTrackingArea * ta = [[self trackingAreas] objectAtIndex:i];
        [self removeTrackingArea:ta];
    }
    
    NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways|NSTrackingAssumeInside;
    for(int i = 0; i < [[[q2ipoint imagesource] scrollimages] count]; i ++)
    {
        NSRect rect = targetrect;
        rect.origin.x = targetrect.origin.x + (targetrect.size.width + cellspace) * i;
    
        NSTrackingArea *area = [[NSTrackingArea alloc] initWithRect:rect options:options owner:self userInfo:nil];
        [self addTrackingArea:area];
    }
}
-(int)getindexfrompoint:(NSPoint)point
{
    if(point.y < 10 || point.y > (targetrect.origin.y + targetrect.size.height))
    {
        return -1;
    }
    int ind = (point.x - targetrect.origin.x ) / (targetrect.size.width + cellspace);
    if(point.x >= (ind * (targetrect.size.width + cellspace) + targetrect.origin.x)
       && point.x <= (ind * (targetrect.size.width + cellspace) + targetrect.origin.x + targetrect.size.width))
    {
        return ind;
    }
    return -1;
}
@end
