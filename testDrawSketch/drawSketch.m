//
//  drawSketch.m
//  testDrawSketch
//
//  Created by xusea on 16/5/26.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import "drawSketch.h"
#import "thumbnailView.h"



@implementation BrushPoint

@synthesize p;
@synthesize t;
@synthesize undoflag;
@end


@implementation drawSketch
@synthesize query;
@synthesize drawtrace;
@synthesize tracecolor;
@synthesize tracewidth;
@synthesize displayflag;
@synthesize validpath;
@synthesize rnum;
@synthesize drawflag;
@synthesize fixpos;
@synthesize tnVpoint;
@synthesize leftbuttom;
@synthesize righttop;
@synthesize tracefillcontourpath;
@synthesize dir;
- (id)initWithFrame:(NSRect)frame
{
    
    self = [super initWithFrame:frame];
    query = [NSString stringWithFormat:@"NONE"];
    drawtrace = [[NSMutableArray alloc]init];
    tracecolor = [NSColor blueColor];
    displayflag = 1;
    tracewidth = 3;
    validpath = 0;
    rnum = arc4random() % 100000;
    drawflag = 0;
    fixpos = NSMakePoint(0, 0);
    leftbuttom = NSMakePoint(MAXFLOAT, MAXFLOAT);
    righttop = NSMakePoint(0,0);
    
    dir = NSTemporaryDirectory();
    tracefillcontourpath = [NSString stringWithFormat:@"%@/tracefillcontour_%d.png", dir, rnum ];
    return self;
}


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
   //画边框
    NSRect bound = [self bounds];
    NSBezierPath *trace = [[NSBezierPath alloc]init];
    [trace setLineWidth:2];
    [tracecolor set];
    //NSColor * cn = [c colorWithAlphaComponent:0.5];
    //[cn set];
    [trace appendBezierPathWithRect:bound];
    [trace closePath];
    [trace stroke];
    /*
    //画query
    if(query != nil)
    {
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[NSFont fontWithName:@"Helvetica light" size:15], NSFontAttributeName,tracecolor, NSForegroundColorAttributeName, nil];
        NSAttributedString * currentText;
        currentText=[[NSAttributedString alloc] initWithString:query attributes: attributes];
        
        [currentText drawAtPoint:NSMakePoint(0, 0)];
    }*/
    
    //画笔迹
    if([drawtrace count] > 0 && displayflag != 0 && validpath > 0)
    {
        NSBezierPath *trace = [[NSBezierPath alloc]init];
        [trace setLineWidth:tracewidth];
        [tracecolor set];
        [NSBezierPath setDefaultFlatness:0.5];
        [NSBezierPath setDefaultLineCapStyle:NSRoundLineCapStyle];
        BrushPoint * bp = [drawtrace objectAtIndex:0];
        [trace moveToPoint:[bp p]];
        for(int i = 1;i<[drawtrace count]; i ++)
        {
            bp = [drawtrace objectAtIndex:i];
            if([bp t] == 0)
            {
                 [trace lineToPoint:[bp p]];
            }
            else
            {
                [trace closePath];
                [trace stroke];
                if([bp undoflag] == 1)
                {
                    break;
                }
            }
            [trace moveToPoint: [bp p]];
        }
        [trace closePath];
        [trace stroke];
    }
    
    // Drawing code here.
}
- (void)mouseDown:(NSEvent *)theEvent
{
    if(drawflag == 1)
    {
        return ;
    }
    NSRect locat;
    locat.origin = [theEvent locationInWindow];
    locat.origin.x -= fixpos.x;
    locat.origin.y -= fixpos.y;
    [self getmaxbound:locat.origin];
//    locat.origin.x -= [self frame].origin.x;
//    locat.origin.y -= [self frame].origin.y;
    NSRange range;
    range.length = 0;
    for(int i = 0;i<[drawtrace count] ;i++)
    {
        BrushPoint * bp = [drawtrace objectAtIndex:i];
        if([bp t] == 1 && [bp undoflag] == 1)
        {
            range.location = i;
            range.length = [drawtrace count] - i;
            break;
        }
    }
    if(range.length > 0)
    {
        [drawtrace removeObjectsInRange:range];
    }
    BrushPoint * bp = [[BrushPoint alloc]init];
    [bp setP:locat.origin];
    [bp setT:1];
    [bp setUndoflag:0];
    [drawtrace addObject:bp];
    validpath ++;
    [self setNeedsDisplay:YES];
 //   [tnVpoint setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)theEvent
{
    if(drawflag == 1)
    {
        return ;
    }
    NSRect locat;
    locat.origin = [theEvent locationInWindow];
    locat.origin.x -= fixpos.x;
    locat.origin.y -= fixpos.y;
    [self getmaxbound:locat.origin];
//    locat.origin.x -= [self frame].origin.x;
//    locat.origin.y -= [self frame].origin.y;
    BrushPoint * bp = [[BrushPoint alloc]init];
    [bp setP:locat.origin];
    [bp setT:0];
    [bp setUndoflag:0];
    [drawtrace addObject:bp];
    [self setNeedsDisplay:YES];
    
}
- (void)mouseUp:(NSEvent *)theEvent
{
    [tnVpoint setNeedsDisplay:YES];
}
- (void)removepath
{
    [drawtrace removeAllObjects];
    validpath = 0;
    // allpath= 0;
    [self setNeedsDisplay:YES];
    
}
- (void)undo
{
    for(int i = (int)[drawtrace count] - 1; i > -1 ; i--)
    {
        BrushPoint* bp = [drawtrace objectAtIndex:i];
        if([bp t] == 1 && [bp undoflag] == 0)
        {
            [bp setUndoflag:1];
            [drawtrace replaceObjectAtIndex:i withObject:bp];
            validpath --;
            break;
        }
    }
    [self setNeedsDisplay:YES];

}
- (void)redo
{
    for(int i = 0; i< (int)[drawtrace count]; i ++)
    {
        BrushPoint* bp = [drawtrace objectAtIndex:i];
        if([bp t] == 1 && [bp undoflag] == 1)
        {
            [bp setUndoflag:0];
            [drawtrace replaceObjectAtIndex:i withObject:bp];
            validpath ++;
            break;
        }
    }
    [self setNeedsDisplay:YES];
}

- (void)trace2png
{
    NSBitmapImageRep* rep = [self bitmapImageRepForCachingDisplayInRect:[self bounds]];
    NSRect bounds = [self bounds];
    [self cacheDisplayInRect:[self bounds] toBitmapImageRep:rep];
    
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor];
    NSData* data = [rep representationUsingType:NSPNGFileType properties:imageProps];
    
    //NSString* dir = NSTemporaryDirectory();
    NSString * tracepngpath = [NSString stringWithFormat:@"%@/tracepng_%d.png", dir, rnum ];
    [data writeToFile:tracepngpath atomically:YES];
    [NSGraphicsContext restoreGraphicsState];
    
    NSString * tracepnggraypath = [NSString stringWithFormat:@"%@/tracepnggray_%d.png", dir, rnum ];
    [imagetrans pngfile2grayfile:tracepngpath outfile:tracepnggraypath];
    //NSString * tracefillcontourpath = [NSString stringWithFormat:@"%@/tracefillcontour_%@_%d.png", dir, query, rnum ];

    //填洞
    [imagetrans fillcontour:tracepnggraypath outfile:tracefillcontourpath];
  /*
    //测试彩色图提取主体
    NSString * imagedog = [NSString stringWithFormat:@"/Users/xusea/sketch2photo/11.jpg"];
    NSString * imagedoggray = [NSString stringWithFormat:@"%@/doggray.png", dir];
    NSString * imagedoglog = [NSString stringWithFormat:@"%@/doglog.png", dir];
    [imagetrans imagecut:imagedog outfile:imagedoggray logfile:imagedoglog];
    
    //比较两个图片相似度
    NSString * leftfile =[NSString stringWithFormat:@"/Users/xusea/sketch2photo/imgdata/dog2.png"];
    for(int i = 1;i<=30;i++)
    {
        NSString * rightfile = [NSString stringWithFormat:@"/Users/xusea/sketch2photo/imgdata/out_log/%d.png",i];
        double match = [imagetrans imagecom:leftfile rightfile:rightfile];
        NSLog(@"%d %f match", i,match);
    }
*/
 
    /*NSString * orgimage = [NSString stringWithFormat:@"/Users/xusea/sketch2photo/imgdata/25.jpg"];
    NSString * grayimage = [NSString stringWithFormat:@"/Users/xusea/sketch2photo/imgdata/out_log/25.png"];
    NSString * outimage = [NSString stringWithFormat:@"%@/sketch.png",dir];
    [imagetrans imagesketch:grayimage orgimage:orgimage outimage:outimage];
    NSString * cutimage = [NSString stringWithFormat:@"%@/sketchcut.png",dir];
    [imagetrans cutalpha:outimage outimage:cutimage];*/
    
}

- (void)getmaxbound:(NSPoint) inpoint
{
    if(inpoint.x < leftbuttom.x)
    {
        leftbuttom.x = inpoint.x;
    }
    
    if(inpoint.y < leftbuttom.y)
    {
        leftbuttom.y = inpoint.y;
    }
    
    if(inpoint.x > righttop.x)
    {
        righttop.x = inpoint.x;
    }
    
    if(inpoint.y > righttop.y)
    {
        righttop.y = inpoint.y;
    }
}
@end
