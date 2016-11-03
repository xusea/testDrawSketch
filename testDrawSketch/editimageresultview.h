//
//  editimageresultview.h
//  testDrawSketch
//
//  Created by xusea on 2016/11/1.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "resultimageview.h"
#import "query2image.h"
@interface editimageresultview : NSView
{
    resultimageview * riv;
    NSRect selectedrect;
}
@property resultimageview * riv;
@property NSRect selectedrect;
-(void)initial;
-(void)getSelectedDS:(NSPoint)point;
@end
