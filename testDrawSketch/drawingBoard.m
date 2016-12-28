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
- (void)drawRect:(NSRect)dirtyRect {
 
}
-(void)initial
{
    NSRect frame = [self bounds];
    [bs setFrame:frame];
    [bsinner setFrame:frame];
    [riv setFrame:frame];
    [dsc setFrame:frame];
    [eirv setFrame:frame];
    [bgv setFrame:frame];
    [bge setFrame:frame];
}
-(void)forcebestimage
{
    for(int i = 0; i < [[riv querydrawlist] count]; i++)
    {
        query2image * q2i = [[riv querydrawlist] objectAtIndex:i];
        [q2i forceselecteditem];
    }
}
@end
