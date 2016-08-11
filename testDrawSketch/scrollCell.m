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
/*- (NSRect)imageFrame
{
    NSRect frame = self.frame;
    frame.origin.x += 3;
    frame.origin.y += 3;
    frame.size.width -= 6;
    frame.size.height -= 6;
    return frame;
    //return internalimageframe;
}*/
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
       /* CALayer * foregroundlayer = [CALayer layer];
        foregroundlayer.frame = frame;
        [foregroundlayer setNeedsDisplay];
        
        CALayer *glossyLayer = [CALayer layer];
        glossyLayer.frame = NSMakeRect(0, 0, 30, 30);
        setBundleImageOnLayer(glossyLayer, CFSTR("tick.png"));
        [foregroundlayer addSublayer:glossyLayer];

        return foregroundlayer;*/
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


//---------------------------------------------------------------------------------
// imageFrame
//
// Define where the image should be drawn.
//---------------------------------------------------------------------------------
- (NSRect)imageFrame
{
    // get default imageFrame and aspect ratio
    NSRect imageFrame = [super imageFrame];
    
    if (imageFrame.size.height == 0 || imageFrame.size.width == 0)
    {
        return NSZeroRect;
    }
    
    float aspectRatio =  imageFrame.size.width / imageFrame.size.height;
    
    // compute the rectangle included in container with a margin of at least 10 pixel at the bottom, 5 pixel at the top and keep a correct  aspect ratio
    NSRect container = [self imageContainerFrame];
    container = NSInsetRect(container, 8, 8);
    
    if (container.size.height <= 0)
    {
        return NSZeroRect;
    }
    
    float containerAspectRatio = container.size.width / container.size.height;
    
    if (containerAspectRatio > aspectRatio){
        imageFrame.size.height = container.size.height;
        imageFrame.origin.y = container.origin.y;
        imageFrame.size.width = imageFrame.size.height * aspectRatio;
        imageFrame.origin.x = container.origin.x + (container.size.width - imageFrame.size.width)*0.5;
    }
    else
    {
        imageFrame.size.width = container.size.width;
        imageFrame.origin.x = container.origin.x;
        imageFrame.size.height = imageFrame.size.width / aspectRatio;
        imageFrame.origin.y = container.origin.y + container.size.height - imageFrame.size.height;
    }
    
    // round it
    imageFrame.origin.x = floorf(imageFrame.origin.x);
    imageFrame.origin.y = floorf(imageFrame.origin.y);
    imageFrame.size.width = ceilf(imageFrame.size.width);
    imageFrame.size.height = ceilf(imageFrame.size.height);
    
    return imageFrame;
}

//---------------------------------------------------------------------------------
// imageContainerFrame
//
// Override the default image container frame.
//---------------------------------------------------------------------------------
- (NSRect)imageContainerFrame
{
    NSRect container = [super frame];
    
    // make the image container 15 pixels up
    container.origin.y += 15;
    container.size.height -= 15;
    
    return container;
}

//---------------------------------------------------------------------------------
// titleFrame
//
// Override the default frame for the title.
//---------------------------------------------------------------------------------
- (NSRect)titleFrame
{
    // get the default frame for the title
    NSRect titleFrame = [super titleFrame];
    
    // move the title inside the 'photo' background image
    NSRect container = [self frame];
    titleFrame.origin.y = container.origin.y + 3;
    
    // make sure the title has a 7px margin with the left/right borders
    float margin = titleFrame.origin.x - (container.origin.x + 7);
    if (margin < 0)
    {
        titleFrame = NSInsetRect(titleFrame, -margin, 0);
    }
    
    return titleFrame;
}

//---------------------------------------------------------------------------------
// selectionFrame
//
// Make the selection frame a little bit larger than the default one.
//---------------------------------------------------------------------------------
- (NSRect)selectionFrame
{
    return NSInsetRect([self frame], -5, -5);
}
@end
