//
//  scrollCell.m
//  testDrawSketch
//
//  Created by xusea on 16/6/29.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import "scrollCell.h"
static void setBundleImageOnLayer(CALayer *layer, CFStringRef imageName)
{
    CGImageRef image = NULL;
    NSString *path = [[NSBundle mainBundle] pathForResource:((__bridge NSString *)imageName).stringByDeletingPathExtension ofType:((__bridge NSString *)imageName).pathExtension];
    if (!path)
    {
        return;
    }
    
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL((CFURLRef)[NSURL fileURLWithPath:path], NULL);
    if (!imageSource)
    {
        return;
    }
    
    image = CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);
    if (!image)
    {
        CFRelease(imageSource);
        return;
    }
    
    layer.contents = (__bridge id)image;
    
    CFRelease(imageSource);
    CFRelease(image);
}

@implementation scrollCell
@synthesize internalimageframe;
- (id) init
{
    if(self = [super init])
    {
        
        internalimageframe = self.frame;
        internalimageframe.origin.x += 3;
        internalimageframe.origin.y += 3;
        internalimageframe.size.width -= 6;
        internalimageframe.size.height -= 6;
    }
    return self;
}
- (NSRect)imageFrame
{
    NSRect frame = self.frame;
    frame.origin.x += 3;
    frame.origin.y += 3;
    frame.size.width -= 6;
    frame.size.height -= 6;
    return frame;
    //return internalimageframe;
}
- (CALayer *)layerForType:(NSString *)type
{
    NSRect frame = [self frame];
    if( [type isEqualToString:IKImageBrowserCellBackgroundLayer] )
    {
        CALayer * backgroundlayer = [CALayer layer];
        backgroundlayer.delegate = self;
        NSRect frame = self.frame;
        frame.origin.x = -1;
        frame.origin.y = -1;
        frame.size.width += 2;
        frame.size.height += 2;
        backgroundlayer.frame = frame;
        [backgroundlayer setNeedsDisplay];
        return backgroundlayer;
    }
    if( [type isEqualToString:IKImageBrowserCellForegroundLayer])
    {
        CALayer * foregroundlayer = [CALayer layer];
        foregroundlayer.frame = frame;
        [foregroundlayer setNeedsDisplay];
        
        CALayer *glossyLayer = [CALayer layer];
        glossyLayer.frame = NSMakeRect(0, 0, 30, 30);
        setBundleImageOnLayer(glossyLayer, CFSTR("tick.png"));
        [foregroundlayer addSublayer:glossyLayer];

        return foregroundlayer;
    }
    return [super layerForType:type];
}
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context
{
    // Set the current context.
    NSString * subtitle = [[self representedItem] subtitle];
    NSArray * strs = [subtitle componentsSeparatedByString:@"_"];
    [NSGraphicsContext saveGraphicsState];
    NSGraphicsContext *nscg = [NSGraphicsContext graphicsContextWithGraphicsPort:context flipped:NO];
    if(nscg != nil)
    {
        [NSGraphicsContext setCurrentContext:nscg];
        
        /*
         ////画边框
        NSRect bound = [self frame];
        bound.origin.x = 0;
        bound.origin.y = 0;
        NSBezierPath *trace = [[NSBezierPath alloc]init];
        [trace setLineWidth:2];
        [[NSColor blueColor] set];
        [trace appendBezierPathWithRect:bound];
        [trace closePath];
        [trace stroke];*/
        
        
        //////画gif
        //   NSImage *img = [NSImage imageNamed:@"2.gif"];
        //   [img drawInRect:NSMakeRect(0, 0, 90, 90)];
        NSRect bound = [self frame];
        bound.origin.x = -1;
        bound.origin.y = -1;
        bound.size.width += 2;
        bound.size.height += 2;
        NSImage * borderimg = [NSImage imageNamed:@"red.png"];
        NSString * imagestatus = [strs firstObject];
        if([imagestatus isEqualToString:@"1"])
        {
            borderimg = [NSImage imageNamed:@"green.png"];
        }
        else if([imagestatus isEqualToString:@"2"])
        {
            borderimg = [NSImage imageNamed:@"yellow.png"];
        }
        else if([imagestatus isEqualToString:@"3"])
        {
            borderimg = [NSImage imageNamed:@"blue.png"];
        }
        [borderimg drawInRect:bound];
       
        //画分数
        if([strs count] > 1)
        {
            NSString * score = [strs objectAtIndex:1];
            NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[NSFont fontWithName:@"Helvetica light" size:15], NSFontAttributeName,[NSColor blackColor], NSForegroundColorAttributeName, nil];
            NSAttributedString * currentText =[[NSAttributedString alloc] initWithString:score attributes: attributes];
            [currentText drawAtPoint:bound.origin];
        }
    }
    else
    {
        NSLog(@"currentContext is nil in cell");
    }
    
    [NSGraphicsContext restoreGraphicsState];
}
@end
