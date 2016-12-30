//
//  resultimageview.h
//  testDrawSketch
//
//  Created by xusea on 16/7/6.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
@class drawingBoard;
@interface resultimageview : NSView
{
    //NSMutableArray * querydrawlist;
    drawingBoard * parentdb;
}
//@property NSMutableArray * querydrawlist;
@property drawingBoard * parentdb;

@end
