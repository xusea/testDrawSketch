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
    if(querydrawlist == nil)
    {
        return;
    }
    for(int i = 0; i < [querydrawlist count]; i ++)
    {
        query2image * q2i = [querydrawlist objectAtIndex:i];
        if([q2i backgroundflag] == 1)
        {
            continue;
        }
        imageitem * it = [q2i getbestimageitem];
        NSImage * image = [[NSImage alloc]initWithContentsOfFile:[it transparentname]];
        NSRect drawrect;
        drawrect.origin.x = 0;
        drawrect.origin.y = 0;
        drawrect.size.width =  [[q2i dsketch] righttop].x - [[q2i dsketch]leftbuttom].x;
        drawrect.size.height = [[q2i dsketch] righttop].y - [[q2i dsketch] leftbuttom].y;
        NSPoint drawpoint =[[q2i dsketch]leftbuttom];
        
        float radio = 1.0;
        if([self frame].size.width / [self frame].size.height > [[q2i dsketch] frame].size.width / [[q2i dsketch] frame].size.height)
        {
            radio = [self frame].size.width / [[q2i dsketch] frame].size.width;
        }
        else
        {
            radio = [self frame].size.height / [[q2i dsketch] frame].size.height;
        }
        drawpoint.x *= radio;
        drawpoint.y *= radio;
        drawrect.size.width *=  radio;
        drawrect.size.height *= radio;
        drawrect.origin = drawpoint;
        [image drawInRect:drawrect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
       // drawrect.origin.x = 0;
       // drawrect.origin.y = 0;
        
        //[image drawAtPoint:drawpoint fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
    }
}

@end
