//
//  scrollCell.h
//  testDrawSketch
//
//  Created by xusea on 16/6/29.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import <Quartz/Quartz.h>

@interface scrollCell : IKImageBrowserCell
{
    NSRect internalimageframe;
}
@property (readwrite)NSRect internalimageframe;
@end
