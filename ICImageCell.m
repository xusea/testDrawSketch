//
//  ICImageCell.m
//  testDrawSketch
//
//  Created by xusea on 2017/1/20.
//  Copyright © 2017年 xusea. All rights reserved.
//

#import "ICImageCell.h"
#define kImageOriginXOffset     3
#define kImageOriginYOffset     1

#define kTextOriginXOffset      2
#define kTextOriginYOffset      2
#define kTextHeightAdjust       4
@implementation ICImageCell
// -------------------------------------------------------------------------------
//	initTextCell:aString
// -------------------------------------------------------------------------------
- (instancetype)initTextCell:(NSString *)aString
{
    self = [super initTextCell:aString];
    if (self != nil)
    {
        // we want a smaller font
        [self setFont:[NSFont systemFontOfSize:[NSFont smallSystemFontSize]]];
    }
    return self;
}

// -------------------------------------------------------------------------------
//	copyWithZone:zone
// -------------------------------------------------------------------------------
- (id)copyWithZone:(NSZone *)zone
{
    ICImageCell *cell = (ICImageCell *)[super copyWithZone:zone];
    cell.myImage = self.myImage;
    return cell;
}

// -------------------------------------------------------------------------------
//	titleRectForBounds:cellRect
//
//	Returns the proper bound for the cell's title while being edited
// -------------------------------------------------------------------------------
- (NSRect)titleRectForBounds:(NSRect)cellRect
{
    // the cell has an image: draw the normal item cell
    NSSize imageSize;
    NSRect imageFrame;
    
    imageSize = [self.myImage size];
    NSDivideRect(cellRect, &imageFrame, &cellRect, 3 + imageSize.width, NSMinXEdge);
    
    imageFrame.origin.x += kImageOriginXOffset;
    imageFrame.origin.y -= kImageOriginYOffset;
    imageFrame.size = imageSize;
    
    imageFrame.origin.y += ceil((cellRect.size.height - imageFrame.size.height) / 2);
    
    NSRect newFrame = cellRect;
    newFrame.origin.x += kTextOriginXOffset;
    newFrame.origin.y += kTextOriginYOffset;
    newFrame.size.height -= kTextHeightAdjust;
    
    return newFrame;
}

// -------------------------------------------------------------------------------
//	editWithFrame:inView:editor:delegate:event
// -------------------------------------------------------------------------------
- (void)editWithFrame:(NSRect)aRect inView:(NSView *)controlView editor:(NSText *)textObj delegate:(id)anObject event:(NSEvent *)theEvent
{
    NSRect textFrame = [self titleRectForBounds:aRect];
    [super editWithFrame:textFrame inView:controlView editor:textObj delegate:anObject event:theEvent];
}

// -------------------------------------------------------------------------------
//	selectWithFrame:inView:editor:delegate:event:start:length
// -------------------------------------------------------------------------------
- (void)selectWithFrame:(NSRect)aRect inView:(NSView *)controlView editor:(NSText *)textObj delegate:(id)anObject start:(NSInteger)selStart length:(NSInteger)selLength
{
    NSRect textFrame = [self titleRectForBounds:aRect];
    [super selectWithFrame:textFrame inView:controlView editor:textObj delegate:anObject start:selStart length:selLength];
}

// -------------------------------------------------------------------------------
//	drawWithFrame:cellFrame:controlView
// -------------------------------------------------------------------------------
- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
    NSRect newCellFrame = cellFrame;
    
    if (self.myImage != nil)
    {
        NSSize imageSize;
        NSRect imageFrame;
        
        imageSize = [self.myImage size];
        NSDivideRect(newCellFrame, &imageFrame, &newCellFrame, imageSize.width, NSMinXEdge);
        if ([self drawsBackground])
        {
            [[self backgroundColor] set];
            NSRectFill(imageFrame);
        }
        
        imageFrame.origin.y += 2;
        imageFrame.origin.x += 2;
        //imageFrame.size = imageSize;
        imageFrame.size.width = 25;
        imageFrame.size.height = 13;
        float rate = (float)[self.myImage size].width / (float)[self.myImage size].height;
        if( rate > (float)imageFrame.size.width / (float)imageFrame.size.height)
        {
            imageFrame.size.height = imageFrame.size.width / rate;
        }
        else
        {
            imageFrame.size.width = rate * imageFrame.size.height;
        }
        imageFrame.origin.x += (25 - imageFrame.size.width ) /2 ;
        [self.myImage drawInRect:imageFrame
                        fromRect:NSZeroRect
                       operation:NSCompositeSourceOver
                        fraction:1.0
                  respectFlipped:YES
                           hints:nil];
    }
    
    [super drawWithFrame:newCellFrame inView:controlView];
}

// -------------------------------------------------------------------------------
//	cellSize
// -------------------------------------------------------------------------------
- (NSSize)cellSize
{
    NSSize cellSize = [super cellSize];
    cellSize.width += (self.myImage ? [self.myImage size].width : 0) + 3;
    return cellSize;
}
-(BOOL)trackMouse:(NSEvent *)theEvent inRect:(NSRect)cellFrame ofView:(NSView *)controlView untilMouseUp:(BOOL)flag
{
    NSLog(@"click on");
   /* //如果不是点击事件直接返回
    if([theEvent type]!= NSEventTypeLeftMouseDown)
    {
        return NSCellHitContentArea;
    }
    
    //获取点击坐标在表格的行数
    NSTableView *myView = (NSTableView *)controlView;
    NSPoint p = [theEvent locationInWindow];
    NSPoint local_point = [myView convertPoint:p fromView:nil];
    NSUInteger row = [myView rowAtPoint:local_point];
    
    NSImage *image = checkImage[isChecked];
    
    //判断点击的位置是在复选框内
    if (local_point.x >= imageOffset && local_point.x <= (image.size.width + imageOffset)) {
        
        [[myView delegate] performSelector:@selector(setCheckItem:) withObject:[NSNumber numberWithInteger:row]];
        return NSCellHitContentArea;
    }
    */
    return NSNullCellType;
}

@end
