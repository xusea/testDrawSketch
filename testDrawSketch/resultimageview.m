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
    
    
   /* NSImage * border = [NSImage imageNamed:@"purple.png"];
    NSRect frame = [self frame];
    frame.origin.x = 0;
    frame.origin.y = 0;
    [border drawInRect:frame];*/
    //NSBezierPath * trace = [[NSBezierPath alloc]init];
    //trace
    [NSBezierPath strokeRect:dirtyRect];
    // Drawing code here.
    if(querydrawlist == nil)
    {
        return;
    }
    
    for(int i = 0; i < [querydrawlist count] * 2 ; i++)
    {
        query2image * q2i = [querydrawlist objectAtIndex:i % [querydrawlist count]];
        if((i < [querydrawlist count]  && [q2i backgroundflag] != 1)
           ||(i >= [querydrawlist count]  && [q2i backgroundflag] == 1))
        {
            continue;
        }
        //NSLog(@"%lu", i % [querydrawlist count]);
        imageitem * it;
        if([q2i getselectedimageitem] != nil)
        {
            it = [q2i getselectedimageitem];
        }
        else if([q2i getbestimageitem] != nil)
        {
            it = [q2i getbestimageitem];
        }
        else
        {
            continue;
        }
        
        NSImage * image;
        NSRect drawrect;
        if(i < [querydrawlist count])
        {
            image = [[NSImage alloc]initWithContentsOfFile:[it filename]];
            drawrect = [self frame];
        }
        else
        {
            image = [[NSImage alloc]initWithContentsOfFile:[it transparentname]];
            if(image == nil)
            {
                continue;
            }
            drawrect = [imagetrans getDrawPosition:[self frame]
                                            canves:[[q2i dsketch]frame]
                                            sketch:NSMakeRect([[q2i dsketch] leftbuttom].x, [[q2i dsketch] leftbuttom].y, [[q2i dsketch] righttop].x - [[q2i dsketch] leftbuttom].x, [[q2i dsketch] righttop].y - [[q2i dsketch] leftbuttom].y)
                                       transparent:NSMakeRect(0,0,[image size].width, [image size].height)];
        
        }
        [image drawInRect:drawrect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
    }
    return;
}

@end
