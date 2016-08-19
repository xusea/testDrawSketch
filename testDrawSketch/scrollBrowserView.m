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
- (id)initWithFrame:(NSRect)frame
{
    
    self = [super initWithFrame:frame];
    enteredind = -1;
    NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways|NSTrackingAssumeInside;
    NSTrackingArea *area = [[NSTrackingArea alloc] initWithRect:self.bounds
                                                        options:options
                                                          owner:self
                                                       userInfo:nil];
    [self addTrackingArea:area];
   // fixpos.x = 0;
   // fixpos.y = 0;
    return self;
}
- (void) awakeFromNib{
    
    [super awakeFromNib];
    enteredind = -1;
    NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways|NSTrackingAssumeInside;
    NSTrackingArea *area = [[NSTrackingArea alloc] initWithRect:self.bounds
                                                        options:options
                                                          owner:self
                                                       userInfo:nil];
    [self addTrackingArea:area];
    //fixpos.x = 10;
    //fixpos.y = 10;
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    
    /*NSRect bound = [self frame];
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
    NSRect locat;
    locat.origin = [theEvent locationInWindow];
    NSPoint p = locat.origin;
    p.x -= fixpos.x;
    p.y -= fixpos.y;
    
    NSLog(@"click %d %lf %lf", enteredind, p.x, p.y);
}
- (void)mouseEntered:(NSEvent *)theEvent
{
    NSRect locat;
    locat.origin = [theEvent locationInWindow];
    NSPoint p = locat.origin;
    p.x -= fixpos.x;
    p.y -= fixpos.y;
    
    NSLog(@"mouse entered %d %lf %lf", enteredind, p.x, p.y);

}
@end
