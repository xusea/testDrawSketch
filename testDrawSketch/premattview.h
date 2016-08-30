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
    NSImageView * strokeimage;
    NSImageView * toolimage;
}
@property NSImageView * thumbnailimage;
@property NSImageView * toolimage;
@property NSImageView * strokeimage;
-(void)initiation;
-(void)showthumbnailimage:(NSImage *)image;
-(void)showstrokeimage:(NSImage *)image;
-(void)disableallimage;
-(void)disablethumbnailimage;
-(void)disablestrokeimage;
@end
