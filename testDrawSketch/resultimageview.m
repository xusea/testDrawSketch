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
   // [NSBezierPath strokeRect:dirtyRect];
    // Drawing code here.
    if(querydrawlist == nil)
    {
        return;
    }
  /*  int order = 0;
    int drawbackground = -1;
    for(int i = 0;i < [querydrawlist count]; i++)
    {
        
        query2image * q2i = [querydrawlist objectAtIndex:i ];
        if(q2i == nil)
        {
            continue;
        }
        if([q2i backgroundflag] == 1)
        {
            drawbackground = i;
        }
    }
    while(true)
    {
        query2image * q2i = nil;
        int flag = 0;
        //先画背景
        if(drawbackground != -1)
        {
            q2i = [querydrawlist objectAtIndex:drawbackground];
            drawbackground = -1;
            flag = 1;
        }
        else
        {
            for(int i = 0;i < [querydrawlist count]; i++)
            {
                
                query2image * q2i = [querydrawlist objectAtIndex:i ];
                if(q2i == nil)
                {
                    continue;
                }
                if([q2i draworder] <= order)
                {
                    order ++;
                    flag = 1;
                    break;
                }
            }
        }
        if(flag == 1)
        {
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
            if([q2i displayflag] == 0)
            {
                continue;
            }
            NSImage * image;
            NSRect drawrect;
            if([q2i backgroundflag] == 1)
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
            }
            
            NSGraphicsContext *context = [NSGraphicsContext currentContext];
            
            [context saveGraphicsState];
            CGFloat rotateDeg = [q2i degree];
            NSRect selectedrect = [q2i imagedrawrect];
            NSAffineTransform *rotate = [[NSAffineTransform alloc] init];
            
            [rotate translateXBy: selectedrect.origin.x + selectedrect.size.width/2 yBy:selectedrect.origin.y + selectedrect.size.height/2];
            [rotate rotateByDegrees:rotateDeg];
            [rotate translateXBy:-(selectedrect.origin.x + selectedrect.size.width/2) yBy:-(selectedrect.origin.y + selectedrect.size.height/2)];
            
            [rotate concat];
            [image drawInRect:[q2i imagedrawrect] fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
            [context restoreGraphicsState];
        }
        else if(flag == 0)
        {
            break;
        }
    }*/
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
        if([q2i displayflag] == 0)
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
        }
        
        NSGraphicsContext *context = [NSGraphicsContext currentContext];
        
        [context saveGraphicsState];
        CGFloat rotateDeg = [q2i degree];
        NSRect selectedrect = [q2i imagedrawrect];
        NSAffineTransform *rotate = [[NSAffineTransform alloc] init];
               [rotate translateXBy: selectedrect.origin.x + selectedrect.size.width/2 yBy:selectedrect.origin.y + selectedrect.size.height/2];
        [rotate rotateByDegrees:rotateDeg];
        [rotate translateXBy:-(selectedrect.origin.x + selectedrect.size.width/2) yBy:-(selectedrect.origin.y + selectedrect.size.height/2)];
        [rotate concat];
        [image drawInRect:[q2i imagedrawrect] fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
        [context restoreGraphicsState];
      

    }
    return;
}

@end
