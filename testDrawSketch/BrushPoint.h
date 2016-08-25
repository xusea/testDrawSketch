//
//  BrushPoint.h
//  testDrawSketch
//
//  Created by taochang on 16/8/25.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrushPoint : NSObject
{
    NSPoint p;
    int t;
    int bsize;
    int inoutflag;
    int undoflag;
}
@property(readwrite) NSPoint p;
@property(readwrite) int t;
@property(readwrite) int bsize;
@property(readwrite) int inoutflag;
@property(readwrite) int undoflag;
@end
