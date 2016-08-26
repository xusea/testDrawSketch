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

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    [thumbnailimage setNeedsDisplay:YES];
    [toolimage setNeedsDisplay:YES];
    
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
    
    [thumbnailimage setImage:[NSImage imageNamed:@"yellow.png"]];
    //NSLog(@"???????");
    toolimage = [[NSImageView alloc]init];
    [self addSubview:toolimage];
}
@end
