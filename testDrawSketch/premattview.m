//
//  premattview.m
//  testDrawSketch
//
//  Created by xusea on 16/8/26.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import "premattview.h"

@implementation premattview
@synthesize thumbnailimage;
@synthesize toolimage;
@synthesize strokeimage;

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
  //  [thumbnailimage setNeedsDisplay:YES];
  //  [toolimage setNeedsDisplay:YES];
    
    NSRect bound = [self bounds];
    NSBezierPath *trace = [[NSBezierPath alloc]init];
    [trace setLineWidth:3];
    [[NSColor blackColor]set];
    [trace appendBezierPathWithRect:bound];
    [trace closePath];
    [trace stroke];
    // Drawing code here.
}
-(void)initiation{
    thumbnailimage = [[NSImageView alloc]init];
    thumbnailimage.frame = [self bounds];
    [self addSubview:thumbnailimage];
    
    strokeimage = [[NSImageView alloc]init];
    strokeimage.frame = [self bounds];
    [self addSubview:strokeimage];

}
-(void)showthumbnailimage:(NSImage *)image
{
    [thumbnailimage setImage:image];
    [self setHidden:NO];
}
-(void)showstrokeimage:(NSImage *)image
{
    [strokeimage setImage:image];
    [strokeimage setHidden:NO];
}
-(void)disableallimage
{
    [self setHidden:YES];
}
-(void)disablethumbnailimage
{
    [thumbnailimage setHidden:YES];
}
-(void)disablestrokeimage
{
    [strokeimage setHidden:YES];
}

@end
