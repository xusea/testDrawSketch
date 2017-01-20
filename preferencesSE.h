//
//  preferencesSE.h
//  testDrawSketch
//
//  Created by xusea on 2017/1/12.
//  Copyright © 2017年 xusea. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "serverOptions.h"
#import "ICImageCell.h"
@interface preferencesSE : NSViewController
{
    serverOptions * serveroption;
}
//-(void)showthumbnailimage:(NSImage *)image;
@property serverOptions * serveroption;
@property (weak) IBOutlet NSTableView *setableview;
-(void)loadserveroptions:(serverOptions *)serveroption;
@end
