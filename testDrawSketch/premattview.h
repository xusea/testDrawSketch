//
//  premattview.h
//  testDrawSketch
//
//  Created by xusea on 16/8/26.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface premattview : NSView
{
    NSImageView * thumbnailimage;
    NSImageView * toolimage;
}
@property NSImageView * thumbnailimage;
@property NSImageView * toolimage;
-(void)initiation;
@end
