//
//  resultimageview.m
//  testDrawSketch
//
//  Created by xusea on 16/7/6.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import "resultimageview.h"
#import "query2image.h"
#import "imageitem.h"

@implementation resultimageview
@synthesize querydrawlist;
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    NSImage * border = [NSImage imageNamed:@"purple.png"];
    NSRect frame = [self frame];
    frame.origin.x = 0;
    frame.origin.y = 0;
    [border drawInRect:frame];
    // Drawing code here.
    
    /*for(int i = 0; i < [querydrawlist count]; i ++)
    {
        query2image * q2i = [querydrawlist objectAtIndex:i];
        imageitem * it = [q2i getbestimageitem];
        
    }*/
}

@end
