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
#import "YepCheckImageCell.h"
@interface preferencesSE : NSViewController
{
    serverOptions * serveroption;
}
//-(void)showthumbnailimage:(NSImage *)image;
@property serverOptions * serveroption;
@property (weak) IBOutlet NSTableView *setableview;
-(void)loadserveroptions:(serverOptions *)serveroption;
-(void) setCheckItem:(id) data;
@end
