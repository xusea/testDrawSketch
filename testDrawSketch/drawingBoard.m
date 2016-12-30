//
//  drawingBoard.m
//  testDrawSketch
//
//  Created by xusea on 2016/10/26.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import "drawingBoard.h"
#import "query2image.h"

@implementation drawingBoard
@synthesize riv;
@synthesize dsc;
//@synthesize backgroundview;
@synthesize bs;
@synthesize bsinner;
@synthesize eirv;
@synthesize bgv;
@synthesize bge;
@synthesize querydrawlist;
- (void)drawRect:(NSRect)dirtyRect {
 
}
-(void)initial
{
    NSRect frame = [self bounds];
    [riv setParentdb:self];
    [eirv setParentdb:self];
    [bgv setParentdb:self];
    [bge setParentdb:self];
    [bs setFrame:frame];
    [bsinner setFrame:frame];
    [riv setFrame:frame];
    [dsc setFrame:frame];
    [eirv setFrame:frame];
    [bgv setFrame:frame];
    [bge setFrame:frame];
    [bge initial];
    
}
-(void)forcebestimage
{
    for(int i = 0; i <[querydrawlist count]; i++)
    {
        query2image * q2i = [querydrawlist objectAtIndex:i];
        [q2i forceselecteditem];
    }
}
@end
