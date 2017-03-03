//
//  YepCheckImageCell.m
//  testDrawSketch
//
//  Created by xusea on 2017/1/22.
//  Copyright © 2017年 xusea. All rights reserved.
//

#import "YepCheckImageCell.h"

@implementation YepCheckImageCell
@synthesize isChecked;
-(void)awakeFromNib
{
    //初始化复选框图片
    NSString *checkPath = [[NSBundle mainBundle] pathForResource:@"check-yes" ofType:@"png"];
    checkImage[1] = [[NSImage alloc] initByReferencingFile:checkPath];
    
    NSString *uncheckPath = [[NSBundle mainBundle] pathForResource:@"check-no" ofType:@"png"];
    checkImage[0] = [[NSImage alloc] initByReferencingFile:uncheckPath];
    
    //设置偏移量
    imageOffset = 6;
}

-(NSRect)drawTitle:(NSAttributedString *)title withFrame:(NSRect)frame inView:(NSView *)controlView
{
    //NSLog(@"drawTitle");
    NSRect imageRect = frame;
    NSImage *image = checkImage[isChecked];
    imageRect.origin.x += imageOffset;
    imageRect.origin.y += (imageRect.size.height - image.size.height)/2;
    imageRect.size = image.size;
    [image drawInRect:imageRect fromRect:NSZeroRect operation:NSCompositingOperationSourceOver fraction:1 respectFlipped:YES hints:nil];
    frame.origin.x += image.size.width + imageOffset * 2;
    return [super drawTitle:title withFrame:frame inView:controlView];
}

-(BOOL)trackMouse:(NSEvent *)theEvent inRect:(NSRect)cellFrame ofView:(NSView *)controlView untilMouseUp:(BOOL)flag
{
    //NSLog(@"click ooo");
    //如果不是点击事件直接返回
    if([theEvent type]!= NSEventTypeLeftMouseDown)
    {
        return NSCellHitContentArea;
    }
    
    //获取点击坐标在表格的行数
    NSTableView *myView = (NSTableView *)controlView;
    NSPoint p = [theEvent locationInWindow];
    NSPoint local_point = [myView convertPoint:p fromView:nil];
    NSUInteger row = [myView rowAtPoint:local_point];
    //NSLog(@"click at %lu", (unsigned long)row);
    //isChecked = !isChecked;
    [controlView setNeedsDisplay:YES];
    //NSImage *image = checkImage[isChecked];
    [[myView delegate] performSelector:@selector(setCheckItem:) withObject:[NSNumber numberWithInteger:row]];
    /*//判断点击的位置是在复选框内
    if (local_point.x >= imageOffset && local_point.x <= (image.size.width + imageOffset)) {
        
        [[myView delegate] performSelector:@selector(setCheckItem:) withObject:[NSNumber numberWithInteger:row]];
        return NSCellHitContentArea;
    }*/
    
    return NSNullCellType;
}
@end
