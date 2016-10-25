//
//  scrollBrowserView.m
//  testDrawSketch
//
//  Created by xusea on 16/6/29.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import "scrollBrowserView.h"
#import "scrollCell.h"
#import "query2image.h"
@implementation scrollBrowserView
@synthesize q2ipoint;
@synthesize enteredind;
@synthesize fixpos;
@synthesize targetrect;
@synthesize cellspace;
@synthesize bigsizeimage;
@synthesize bigsizeimageframe;
@synthesize mattview;
@synthesize DPIScale;
@synthesize mattwindow;
-(void)initial
{
    enteredind = -1;
    
    targetrect.origin.x = 10;
    targetrect.origin.y = 10;
    targetrect.size.height = 115;
    targetrect.size.width = 100;
    cellspace = 20;
    
    //cellspace = [self intercellSpacing].width;
    bigsizeimageframe.origin.x = 0;
    bigsizeimageframe.origin.y = 0;
    bigsizeimageframe.size.width = 400;
    bigsizeimageframe.size.height = 300;
    DPIScale = 1;
}
- (id)initWithFrame:(NSRect)frame
{
    
    self = [super initWithFrame:frame];
    [self initial];
    return self;
}
- (void) awakeFromNib{
    
    [super awakeFromNib];
   // NSLog(@"bounds %lf %lf ", [self bounds].size.width, [self bounds].size.height);
    [self initial];
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    /*int pos = 0;
    for(int i = 0 ;i < [[[q2ipoint imagesource] scrollimages] count]; i ++)
    {
        NSRect bound;
        bound.size.width = 40;
        bound.size.height = 40;
        bound.origin.x = pos;
        bound.origin.y = 0;
        pos += 40;
        NSBezierPath *trace = [[NSBezierPath alloc]init];
        [trace setLineWidth:2];
        [[NSColor blueColor] set];
        [trace appendBezierPathWithRect:bound];
        [trace closePath];
        [trace stroke];
        NSLog(@"%d", i);
    }*/
    
    
   /* NSRect bound = [self frame];
    bound.origin.x = 0;
    bound.origin.y = 0;
    NSBezierPath *trace = [[NSBezierPath alloc]init];
    [trace setLineWidth:2];
    [[NSColor blueColor] set];
    [trace appendBezierPathWithRect:bound];
    [trace closePath];
    [trace fill];*/
    // Drawing code here.
}
- (IKImageBrowserCell *)newCellForRepresentedItem:(id)cell
{
    return [[scrollCell alloc] init];
}
- (void)mouseDown:(NSEvent *)theEvent
{
    NSLog(@"duang duang duang");
    NSPoint currentPosition = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    
    int index =[self getindexfrompoint:currentPosition];
    NSLog(@"click item %d", index);
    if(index != -1)
    {
        int toolind = [self gettoolfrompoint:currentPosition];
        
        MyScrollImageObject * mio = [[[[self q2ipoint]imagesource] scrollimages]objectAtIndex:index];
        [mio changevalue:[NSString stringWithFormat:@"%d", toolind] index:3];
        if(toolind == 0)
        {
            //弹起人工编辑框
            
            for(int i = 0;i < [[[self q2ipoint] imageitemlist] count]; i ++)
            {
                if(mio == [[[[self q2ipoint] imageitemlist]objectAtIndex:i] myiobjectpoint])
                {
                    imageitem * it = [[[self q2ipoint] imageitemlist]objectAtIndex:i];
                    
                    mattview = [[mattviewController alloc]init];
                    bool ret = [[NSBundle mainBundle] loadNibNamed:@"mattviewController" owner:mattview topLevelObjects:nil];
                    NSLog(@"load mattviewController %d", ret);
                     [mattview viewDidLoad];
                     //[mattview setWindow:_window];
                     //[[_window contentView]addSubview:[mattview allview]];
                     //[[mattview allview]setHidden:YES];
                    // [_scrollimagelist setMattview:mattview];
                    
                    //10.mattwindow
                     mattwindow = [[mattwindowcontroller alloc]init];
                    [mattview setDPIScale:DPIScale];
                    ret = [[NSBundle mainBundle]loadNibNamed:@"mattwindowcontroller" owner:mattwindow topLevelObjects:nil];
                    NSLog(@"load mattwindowController %d", ret);
                    [mattview addimage:[it filename] strokename:[it strokename] transparentname:[it transparentname]];
                    [[[mattwindow window] contentView] addSubview:[mattview allview]];
                    //[mattview setBoundwindow:[mattwindow window]];
                   // [NSApp runModalForWindow:[mattwindow window] ];
                    //[[mattview allview] setHidden:NO];
                    //[[mattview allview] setNeedsDisplay:YES];
                }
            }
        }
        else if(toolind == 1)
        {
            //  1 stroke
            for(int i = 0;i < [[[self q2ipoint] imageitemlist] count]; i ++)
            {
                if(mio == [[[[self q2ipoint] imageitemlist]objectAtIndex:i] myiobjectpoint])
                {
                    
                    imageitem * it = [[[self q2ipoint] imageitemlist]objectAtIndex:i];
                    NSImage * image = [[NSImage alloc] initWithContentsOfFile:[it strokename]];
                    if(image ==nil)
                    {
                        break;
                    }
                    //[bigsizeimage showstrokeimage:image];
                    NSRect newbounds = [bigsizeimage frame];
                    newbounds.origin.x = 0;
                    newbounds.origin.y = 0;
                    [[bigsizeimage strokeimage]setFrame:newbounds];
                    [[bigsizeimage strokeimage]setBounds:newbounds];
                    [[bigsizeimage strokeimage]setImage:image];
                    [[bigsizeimage strokeimage]setHidden:NO];
                    
                }
            }
        }
        else if(toolind == 2)
        {
            // 2 设置当前图片为选中
            for(int i = 0;i < [[[self q2ipoint] imageitemlist] count]; i ++)
            {
                if(mio == [[[[self q2ipoint] imageitemlist]objectAtIndex:i] myiobjectpoint])
                {
                    int oldselectimageind = [[self q2ipoint] selectedimageind];
                    if(i != oldselectimageind)
                    {
                        if(oldselectimageind != -1)
                        {
                            if(oldselectimageind != [[self q2ipoint] bestimageind])
                            {
                                [[[[[self q2ipoint] imageitemlist]objectAtIndex:oldselectimageind] myiobjectpoint] changevalue:@"2" index:0];
                            }
                            else
                            {
                                [[[[[self q2ipoint] imageitemlist]objectAtIndex:oldselectimageind] myiobjectpoint] changevalue:@"3" index:0];
                            }
                        }
                        [[self q2ipoint] setSelectedimageind:i];
                        //[[self q2ipoint] setBestimageind:i];
                        NSLog(@"click bestind %d", i);
                        NSLog(@"subtitle :%@", [mio subtitle]);
                        [mio changevalue:@"4" index:0];
                        NSLog(@"subtitle :%@", [mio subtitle]);
                    }
                    break;
                }
            }
        }
        else
        {
            NSLog(@"what the fuck? %d", toolind);
        }
        
    }
    [self setNeedsDisplay:YES];
    
    return;
}

- (void)mouseUp:(NSEvent *)event
{
    [[bigsizeimage strokeimage]setHidden:YES];
    [self cleanalltoolsstatus];
    [self setNeedsDisplay:YES];
    
     // NSLog(@"mouse upupup");
    return;
}
- (void)mouseEntered:(NSEvent *)theEvent
{
    NSPoint currentPosition = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    
    //NSInteger idx  = [self indexOfItemAtPoint:currentPosition];
    int idx = [self getindexfrompoint:currentPosition];
    if(idx != -1)
    {
        MyScrollImageObject * mio = [[[[self q2ipoint]imagesource] scrollimages]objectAtIndex:idx];
        
        [mio changevalue:@"1" index:2];
        for(int i = 0;i < [[[self q2ipoint] imageitemlist] count]; i ++)
        {
            if(mio == [[[[self q2ipoint] imageitemlist]objectAtIndex:i] myiobjectpoint])
            {
                
                imageitem * it = [[[self q2ipoint] imageitemlist]objectAtIndex:i];
                NSImage * image = [[NSImage alloc] initWithContentsOfFile:[it filename]];
                if(image ==nil)
                {
                    break;
                }
                //[bigsizeimage showthumbnailimage:image];
                NSPoint frameorign = NSMakePoint(200, 130);
                //frameorign.y += targetrect.size.height + 20;
                NSRect newframe = bigsizeimageframe;
                newframe.origin = frameorign;
                double radio = image.size.height / image.size.width;
                if( newframe.size.height / newframe.size.width > radio)
                {
                    newframe.size.height = newframe.size.width * radio;
                }
                else
                {
                    newframe.size.width = newframe.size.height / radio;
                }
                [bigsizeimage setFrame:newframe];
                [bigsizeimage setHidden:NO];
                //[bigsizeimage setImage:image];
                NSRect newbounds = newframe;
                newbounds.origin.x = 0;
                newbounds.origin.y = 0;
                [[bigsizeimage thumbnailimage]setFrame:newbounds];
                [[bigsizeimage thumbnailimage]setBounds:newbounds];
                [[bigsizeimage thumbnailimage]setImage:image];
                
            }
        }
    }
    else
    {
        NSLog(@"entered ???");
    }
    [self setNeedsDisplay:YES];
    
    
    //NSLog(@"entered %d", [self getindexfrompoint:currentPosition]);
}
- (void)mouseExited:(NSEvent *)theEvent
{
    [bigsizeimage setHidden:YES];
    [[bigsizeimage strokeimage] setHidden:YES];
    [self cleanallenteredstatus];
    [self cleanalltoolsstatus];
    [self setNeedsDisplay:YES];
}
- (void)updateTrackingAreas
{
    for(int i = 0; i< [[self trackingAreas] count]; i ++)
    {
        NSTrackingArea * ta = [[self trackingAreas] objectAtIndex:i];
        [self removeTrackingArea:ta];
    }
    
    NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited|NSTrackingActiveAlways|NSTrackingAssumeInside;
    for(int i = 0; i < [[[q2ipoint imagesource] scrollimages] count]; i ++)
    {
        NSRect rect = targetrect;
        rect.origin.x = targetrect.origin.x + (targetrect.size.width + cellspace) * i;
    
        NSTrackingArea *area = [[NSTrackingArea alloc] initWithRect:rect options:options owner:self userInfo:nil];
        [self addTrackingArea:area];
    }
}
-(int)getindexfrompoint:(NSPoint)point
{
    if(point.y < 10 || point.y > (targetrect.origin.y + targetrect.size.height))
    {
        return -1;
    }
    int ind = (point.x - targetrect.origin.x ) / (targetrect.size.width + cellspace);
    if(point.x >= (ind * (targetrect.size.width + cellspace) + targetrect.origin.x)
       && point.x <= (ind * (targetrect.size.width + cellspace) + targetrect.origin.x + targetrect.size.width))
    {
        return ind;
    }
    return -2;
}
-(int)gettoolfrompoint:(NSPoint)point
{
    if(point.y < 10 || point.y > (targetrect.origin.y + targetrect.size.height))
    {
        return -1;
    }
    if(point.y >=10 && point.y <=30)
    {
        int ind = (point.x - targetrect.origin.x ) / (targetrect.size.width + cellspace);
        if(point.x >= (ind * (targetrect.size.width + cellspace) + targetrect.origin.x)
           && point.x <= (ind * (targetrect.size.width + cellspace) + targetrect.origin.x + targetrect.size.width))
        {
            float toolspace = point.x - (ind * (targetrect.size.width + cellspace) + targetrect.origin.x);
            return (int)(toolspace / 20);
            
        }
    }
    else
    {
        NSLog(@"point.y %f", point.y);
        return -2;
    }
    return -3;
}

-(void)cleanalltoolsstatus
{
    for(int i = 0; i < [[[q2ipoint imagesource] scrollimages] count]; i ++)
    {
        MyScrollImageObject * mio = [[[[self q2ipoint]imagesource] scrollimages]objectAtIndex:i];
        [mio changevalue:@"-1" index:3];
    }

}
-(void)cleanallenteredstatus
{
    for(int i = 0; i < [[[q2ipoint imagesource] scrollimages] count]; i ++)
    {
        MyScrollImageObject * mio = [[[[self q2ipoint]imagesource] scrollimages]objectAtIndex:i];
        [mio changevalue:@"-1" index:2];
    }
}
@end
