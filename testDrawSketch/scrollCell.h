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
    int selectedflag;
    int mouseoverflag;
    int imagestatus;;
}
@property (readwrite)NSRect internalimageframe;
@property (readwrite)int selectedflag;
@property (readwrite)int mouseoverflag;
@property (readwrite)int imagestatus;
-(void)getallstatus;
@end
