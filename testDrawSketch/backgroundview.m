//
//  backgroundview.m
//  testDrawSketch
//
//  Created by xusea on 2016/12/27.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import "backgroundview.h"
#import "drawingBoard.h"
@implementation backgroundview
@synthesize parentdb;
@synthesize bgimage;
@synthesize pointbound;
@synthesize bgtype;
- (id)initWithFrame:(NSRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSTrackingArea *   trackingArea = [[NSTrackingArea alloc] initWithRect:frame
                                                                       options: (NSTrackingMouseEnteredAndExited  | NSTrackingActiveInKeyWindow  |NSTrackingActiveAlways)
                                                                         owner:self userInfo:nil];
        [self addTrackingArea:trackingArea];
    }
    bgimage = nil;
    pointbound = [self bounds];
    bgtype = 1;
    return self;
}
- (void) awakeFromNib{
    bgimage = nil;
    pointbound = [self bounds];
    bgtype = 1;
}

-(void)initial
{
    pointbound = [self frame];
    pointbound.origin.x = 0;
    pointbound.origin.y = 0;
}
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    if(parentdb == nil)
    {
        return;
    }
    NSMutableArray * querydrawlist = [parentdb querydrawlist];
    if(querydrawlist == nil)
    {
        return;
    }
    
    for(int i = 0; i < [querydrawlist count] ; i++)
    {
        query2image * q2i = [querydrawlist objectAtIndex:i % [querydrawlist count]];
        if([q2i backgroundflag] == 1)
        {
            bgimage = [q2i getresimage];
            [bgimage drawInRect:[self pointbound]];
            break;
        }
    }
}


@end
