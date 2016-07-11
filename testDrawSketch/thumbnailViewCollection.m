//
//  thumbnailViewCollection.m
//  testDrawSketch
//
//  Created by xusea on 16/6/20.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import "thumbnailViewCollection.h"

@implementation thumbnailViewCollection

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];

    NSBezierPath * bf = [NSBezierPath bezierPathWithRect:[self bounds]];
    [bf setLineWidth:5];
    [[NSColor greenColor] set];
    [bf stroke];
    // Drawing code here.
}
- (NSSize)intrinsicContentSize
{
    return NSMakeSize(400,850);
}
@end
