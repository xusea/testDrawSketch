//
//  mattbackgroundview.m
//  testDrawSketch
//
//  Created by xusea on 16/9/2.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import "mattbackgroundview.h"

@implementation mattbackgroundview

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    NSRect bound = [self bounds];
    NSBezierPath *trace = [[NSBezierPath alloc]init];
    [trace setLineWidth:3];
    [[NSColor blackColor]set];
    [trace appendBezierPathWithRect:bound];
    [trace closePath];
    [trace fill];
    // Drawing code here.
}

@end
