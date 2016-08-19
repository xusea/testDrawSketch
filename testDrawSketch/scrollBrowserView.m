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
-(void)initial
{
    enteredind = -1;
    
    targetrect.origin.x = 10;
    targetrect.origin.y = 10;
    targetrect.size.height = 115;
    targetrect.size.width = 100;
    cellspace = 20;
    
/*NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways|NSTrackingAssumeInside;
    for(int i = 0; i < 2; i ++)
    {
        NSRect rect = targetrect;
        rect.origin.x = targetrect.origin.x + (targetrect.size.width + cellspace) * i;

        NSTrackingArea *area = [[NSTrackingArea alloc] initWithRect:rect options:options owner:self userInfo:nil];
        [self addTrackingArea:area];
    }*/
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
    
    NSInteger idx  = [self indexOfItemAtPoint:currentPosition];
  
    //NSLog(@"entered %d", [self getindexfrompoint:currentPosition]);
}
- (void)mouseExited:(NSEvent *)theEvent
{
    NSPoint currentPosition = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    
    NSInteger idx  = [self indexOfItemAtPoint:currentPosition];
    
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
    if(point.x > (ind * (targetrect.size.width + cellspace) + targetrect.origin.x)
       && point.x < (ind * (targetrect.size.width + cellspace) + targetrect.origin.x + targetrect.size.width))
    {
        return ind;
    }
    return -1;
}
@end
