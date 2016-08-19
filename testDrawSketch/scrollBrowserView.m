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
    NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways|NSTrackingAssumeInside;
    NSTrackingArea *area = [[NSTrackingArea alloc] initWithRect:self.bounds options:options owner:self userInfo:nil];
    [self addTrackingArea:area];
    
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
    
    NSInteger idx  = [self indexOfItemAtPoint:currentPosition];
  

}
- (void)mouseExited:(NSEvent *)theEvent
{
    NSPoint currentPosition = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    
    NSInteger idx  = [self indexOfItemAtPoint:currentPosition];
}
- (void)updateTrackingAreas
{
   // NSLog(@"bounds %lf %lf ", [self bounds].size.width, [self bounds].size.height);
    NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways|NSTrackingAssumeInside;
    NSTrackingArea *area = [[NSTrackingArea alloc] initWithRect:self.bounds
                                                        options:options
                                                          owner:self
                                                       userInfo:nil];
    [self addTrackingArea:area];
   /* for(int i = 0; i< [[self trackingAreas] count]; i ++)
    {
        NSTrackingArea * ta = [[self trackingAreas] objectAtIndex:i];
        [self removeTrackingArea:ta];
    }
    for(int i = 0 ;i < [[[q2ipoint imagesource] scrollimages] count]; i ++)
    {
        NSRect rect = [self itemFrameAtIndex:i];;
        NSLog(@"area %lf %lf %lf %lf", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
        int opts = (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways);
        NSTrackingArea * trackingArea = [ [NSTrackingArea alloc] initWithRect:rect
                                                     options:opts
                                                       owner:self
                                                    userInfo:nil];
        [self addTrackingArea:trackingArea];
    }*/
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
