//
//  YepCheckImageCell.h
//  testDrawSketch
//
//  Created by xusea on 2017/1/22.
//  Copyright © 2017年 xusea. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@interface YepCheckImageCell : NSButtonCell
{
    BOOL isChecked;
    NSImage* checkImage[2];
    NSUInteger imageOffset;
}

@property (readwrite,assign) BOOL isChecked;
@end
