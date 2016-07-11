//
//  thumbnailView.m
//  testDrawSketch
//
//  Created by xusea on 16/6/20.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import "thumbnailView.h"
#import "query2image.h"

@implementation thumbnailView
@synthesize query;
@synthesize thumbnailsketch;
@synthesize visibleflag;
@synthesize positionflag;
@synthesize backgroundflag;
@synthesize drawrect;
@synthesize edittext;
@synthesize selectflag;
@synthesize parentcollection;
@synthesize tracecolor;
@synthesize dspoint;
@synthesize thumbnailbounds;
@synthesize q2ipoint;
@synthesize buttomimagelist;
- (id) init
{
    if(self = [super init])
    {
        NSRect rect = NSMakeRect(0, 0, 150, 30);
        [self setFrame:rect];
        edittext = [[NSTextField alloc]init];
        NSRect edittextframe = NSMakeRect(10, 10, 50, 20);
        [edittext setFrame:edittextframe];
        [edittext setHidden:YES];
        [edittext setDelegate:self];
        [self addSubview:edittext];
        selectflag = 0;
        query = @"NONE";
        thumbnailbounds.origin.x = 50;
        thumbnailbounds.origin.y = 2;
        thumbnailbounds.size.height = 26;
        thumbnailbounds.size.width = 26;
        //为子类增加属性进行初始化
    }
    return self;
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
     //画边框
    if(selectflag == 1)
    {
        NSRect bound = [self bounds];
        NSBezierPath *trace = [[NSBezierPath alloc]init];
        [trace setLineWidth:2];
        [[NSColor blueColor]set];
        [trace appendBezierPathWithRect:bound];
        [trace closePath];
        [trace stroke];
    }
    
    //画query
    NSAttributedString * currentText;
    NSString *title_core;
    if(query != nil)
    {
        title_core = query;
    }
    else
    {
        title_core = @"qery";
    }
    NSString * fontname = @"Helvetica-Bold";
    int fontsize = 15;
    NSFont *dfont = [NSFont fontWithName:fontname size:fontsize];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithObject:dfont forKey:NSFontAttributeName];
    currentText=[[NSAttributedString alloc] initWithString:title_core attributes: attributes];
    
    [currentText drawAtPoint:NSMakePoint(0,0)];
    
    //画缩略图
    if([[dspoint drawtrace] count] > 0 && [dspoint displayflag] != 0 && [dspoint validpath] > 0)
    {
        NSBezierPath *trace = [[NSBezierPath alloc]init];
        [trace setLineWidth:2];
        [[dspoint tracecolor] set];
        [NSBezierPath setDefaultFlatness:0.5];
        [NSBezierPath setDefaultLineCapStyle:NSRoundLineCapStyle];
        BrushPoint * bp = [[dspoint drawtrace] objectAtIndex:0];
        //修改[bp p]
        NSPoint newpoint = [self convertthumbnailpoint:[bp p] leftbuttom:[dspoint leftbuttom] righttop:[dspoint righttop]];
        [trace moveToPoint:newpoint];
        for(int i = 1;i<[[dspoint drawtrace] count]; i ++)
        {
            bp = [[dspoint drawtrace] objectAtIndex:i];
            newpoint = [self convertthumbnailpoint:[bp p] leftbuttom:[dspoint leftbuttom] righttop:[dspoint righttop]];
            if([bp t] == 0)
            {
                [trace lineToPoint:newpoint];
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
            [trace moveToPoint: newpoint];
        }
        [trace closePath];
        [trace stroke];
    }
}
- (NSSize)intrinsicContentSize
{
    return [self bounds].size;
}
- (void)controlTextDidEndEditing:(NSNotification *)aNotification
{
    NSTextField *ed = [aNotification object];
    query = [ed stringValue];
    [dspoint setQuery:query];
    [q2ipoint setQuery:query];
    [ed setHidden:YES];
    [self setNeedsDisplay:YES];
}
/* what 's the fuck
 - (void)textDidEndEditing:(NSNotification *)aNotification
{
    
}*/
- (void)controlTextDidChange:(NSNotification *)notification
{
   // NSLog(@"fff");
    // your code
}

-(void)setcurrentquery:(NSString *)q
{
    query = q;
    [edittext setStringValue:q];
}


- (void)mouseDown:(NSEvent *)theEvent
{
    //设置底部备选图片
    [buttomimagelist setDataSource:[[self q2ipoint] imagesource]];
    [buttomimagelist reloadData];
    [buttomimagelist setQi2point:[self q2ipoint]];
    //设置自动reload新下载图片
    [q2ipoint setSelectflag:1];
    
   // [buttomimagelist setNeedsDisplay:YES];
    [edittext setHidden:NO];
    [edittext setStringValue:query];
    selectflag = 1;
    //bring front drawsketch
    if(dspoint != nil)
    {
        NSView *superview = [dspoint superview];
        [dspoint removeFromSuperview];
        [superview addSubview:dspoint positioned:NSWindowAbove relativeTo:nil];
    }
    if(parentcollection != nil)
    {
        for(int i = 0;i < [[parentcollection subviews] count];i ++)
        {
            NSString * classname = NSStringFromClass([[[parentcollection subviews]objectAtIndex:i] class]);
           // NSLog(@"%@", classname);
            if([classname isEqualToString:@"thumbnailView"])
            {
                thumbnailView * tv = (thumbnailView *)[[parentcollection subviews] objectAtIndex:i];
                if(tv == self)
                {
                    //NSLog(@"current selected item %d", i);
                }
                else
                {
                    [tv setSelectflag:0];
                    [[tv edittext]setHidden:YES];
                    
                }
                [tv setNeedsDisplay:YES];
            }
            
            
        }
    }
}
-(NSPoint)convertthumbnailpoint:(NSPoint) inpoint leftbuttom:(NSPoint)lbpoint righttop:(NSPoint)rtpoint
{
    NSPoint cp;
    cp.x = inpoint.x;
    cp.y = inpoint.y;
    cp.x -= lbpoint.x;
    cp.y -= lbpoint.y;
    float ratio = 1.0;
    float height = rtpoint.y - lbpoint.y;
    float width = rtpoint.x - lbpoint.x;
    if(height > width)
    {
        ratio = height / thumbnailbounds.size.height;
    }
    else
    {
        ratio = width / thumbnailbounds.size.width;
    }
    cp.x /= ratio;
    cp.y /= ratio;
    cp.x += thumbnailbounds.origin.x;
    cp.y += thumbnailbounds.origin.y;
    return cp;
}
@end
