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
    /*    imageitem * it;
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
        //转换亮度、对比度、饱和度
        image = [imagetrans NSImageBCS:image v:[q2i brightness] BCS:IMGTbrightness];
        image = [imagetrans NSImageBCS:image v:[q2i saturation] BCS:IMGTsaturation];
        image = [imagetrans NSImageBCS:image v:[q2i contrast] BCS:IMGTcontrast];*/
        NSImage * image = [q2i getresimage];
        if([q2i backgroundflag] == 1)
        {
            [image drawInRect:[q2i backgroundrect] fromRect:NSZeroRect operation:NSCompositingOperationSourceOver fraction:1.0];
        }
        else
        {
            NSGraphicsContext *context = [NSGraphicsContext currentContext];
            
            [context saveGraphicsState];
            CGFloat rotateDeg = [q2i degree];
            NSRect selectedrect = [q2i imagedrawrect];
            NSAffineTransform *rotate = [[NSAffineTransform alloc] init];
                   [rotate translateXBy: selectedrect.origin.x + selectedrect.size.width/2 yBy:selectedrect.origin.y + selectedrect.size.height/2];
            [rotate rotateByDegrees:rotateDeg];
            [rotate translateXBy:-(selectedrect.origin.x + selectedrect.size.width/2) yBy:-(selectedrect.origin.y + selectedrect.size.height/2)];
            [rotate concat];
            if([q2i flipx] == 1)
            {
                image = [imagetrans flipImageByX:image];            //NSLog(@"set flip X");
            }
            
            if([q2i flipy] == 1)
            {
               image = [imagetrans flipImageByY:image];
            }
            [image drawInRect:[q2i imagedrawrect] fromRect:NSZeroRect operation:NSCompositingOperationSourceOver fraction:1.0];
            [context restoreGraphicsState];
      
        }
    }
    return;
}

@end
