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
@synthesize selectedflag;
@synthesize mouseoverflag;
@synthesize imagestatus;
@synthesize strokeclickflag;
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
    /*if( [type isEqualToString:IKImageBrowserCellForegroundLayer])
    {
        CALayer * foregroundlayer = [CALayer layer];
        foregroundlayer.frame = frame;
        foregroundlayer.delegate = self;
       // [foregroundlayer setNeedsDisplay];
        
        CALayer *glossyLayer = [CALayer layer];
        glossyLayer.frame = self.frame;
        setBundleImageOnLayer(glossyLayer, CFSTR("mouseover.png"));
        [foregroundlayer addSublayer:glossyLayer];

        return foregroundlayer;
    }*/
    return [super layerForType:type];
}
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context
{
    [self getallstatus];
    // Set the current context.
    NSString * subtitle = [[self representedItem] subtitle];
    NSArray * strs = [subtitle componentsSeparatedByString:@"_"];
    [NSGraphicsContext saveGraphicsState];
    NSGraphicsContext *nscg = [NSGraphicsContext graphicsContextWithGraphicsPort:context flipped:NO];
    if(nscg != nil)
    {
        [NSGraphicsContext setCurrentContext:nscg];
        
        
        
        //////画gif
        
        NSRect bound = [self frame];
        bound.origin.x = -1;
        bound.origin.y = -1;
        bound.size.width += 2;
        bound.size.height += 2;
        NSImage * borderimg = [NSImage imageNamed:@"red.png"];
        //NSString * imagestatus = [strs firstObject];
        if([self imagestatus] == 1)
        {
            borderimg = [NSImage imageNamed:@"green.png"];
        }
        else if([self imagestatus] == 2)
        {
            borderimg = [NSImage imageNamed:@"yellow.png"];
        }
        else if([self imagestatus] == 3)
        {
            borderimg = [NSImage imageNamed:@"blue.png"];
        }
        else if([self imagestatus] == 4)
        {
            borderimg = [NSImage imageNamed:@"pink.png"];
        }
        [borderimg drawInRect:bound];
       
        //画分数,debug 画se
        if([strs count] > 1)
        {
            //NSString * score = [strs objectAtIndex:1];
            NSString * score = [self se];
            NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[NSFont fontWithName:@"Helvetica light" size:15], NSFontAttributeName,[NSColor blackColor], NSForegroundColorAttributeName, nil];
            NSAttributedString * currentText =[[NSAttributedString alloc] initWithString:score attributes: attributes];
            [currentText drawAtPoint:bound.origin];
        }
        
        //画mouse over
        if([self mouseoverflag] == 1)
        {
            NSRect bound = [self frame];
            bound.origin.x = -5;
            bound.origin.y = -5;
            bound.size.width += 10;
            bound.size.height += 10;
            NSImage * borderimg = [NSImage imageNamed:@"red.png"];
            [borderimg drawInRect:bound];
        
            //画工具
            //编辑按钮
            NSRect pencilframe;
            pencilframe.size.height = 20;
            pencilframe.size.width = 20;
            pencilframe.origin.x = 0;
            pencilframe.origin.y = 0;
            NSImage * pencilimage = [NSImage imageNamed:@"pencil.png"];
            [pencilimage drawInRect:pencilframe];
            
            //轮廓
            NSRect strokeframe;
            strokeframe.size.height = 20;
            strokeframe.size.width = 20;
            strokeframe.origin.x = 20;
            strokeframe.origin.y = 0;
            if(strokeclickflag == 1)
            {
                NSImage * strokeimage = [NSImage imageNamed:@"strokeclick.png"];
                [strokeimage drawInRect:strokeframe];
            }
            else
            {
                NSImage * strokeimage = [NSImage imageNamed:@"stroke.png"];
                [strokeimage drawInRect:strokeframe];
            }
            
            NSRect insertframe;
            insertframe.size.height = 20;
            insertframe.size.width = 20;
            insertframe.origin.x = 40;
            insertframe.origin.y = 0;
            NSImage * insertimage = [NSImage imageNamed:@"insert.png"];
            [insertimage drawInRect:insertframe];
            
            //画向左箭头
            NSRect arrowframe;
            arrowframe.size.height = 20;
            arrowframe.size.width = 20;
            arrowframe.origin.x = 60;
            arrowframe.origin.y = 0;
            NSImage * arrowimage = [NSImage imageNamed:@"arrow.png"];
            [arrowimage drawInRect:arrowframe];
        }
        
        //画logo
        NSString * logoname = [NSString stringWithFormat:@"%@.ico", [self se]];
        NSRect logobound = [self frame];
        logobound.origin.x = 0;
        logobound.origin.y = logobound.size.height-8;
        logobound.size.width = 8;
        logobound.size.height = 8;
        NSImage * logoimg = [NSImage imageNamed:logoname];
        [logoimg drawInRect:logobound];
        

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
    //imageFrame.origin.y -=20;
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

-(void)getallstatus
{
    NSString * subtitle = [[self representedItem] subtitle];
    //NSLog(@"getall status %@ ", subtitle);
    NSArray * strs = [subtitle componentsSeparatedByString:@"_"];
    
    
    [self setImagestatus:[[strs firstObject] intValue]];
    if([strs count] >= 3)
    {
        [self setMouseoverflag:[[strs objectAtIndex:2] intValue]];
    }
    else
    {
        [self setMouseoverflag:0];
    }
    if([strs count] >= 4)
    {
        [self setStrokeclickflag:[[strs objectAtIndex:3] intValue]];
    }
    else
    {
        [self setStrokeclickflag:-1];
    }
    if([strs count] >= 5)
    {
        [self setSe:[strs objectAtIndex:4]];
    }
    else
    {
        [self setSe:@"NONE"];
    }
    return;
}
@end
