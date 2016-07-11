//
//  resultimageview.m
//  testDrawSketch
//
//  Created by xusea on 16/7/6.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import "resultimageview.h"

@implementation resultimageview
@synthesize querydraw;
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    NSImage * border = [NSImage imageNamed:@"purple.png"];
    NSRect frame = [self frame];
    frame.origin.x = 0;
    frame.origin.y = 0;
    [border drawInRect:frame];
    // Drawing code here.
}

@end
