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
    int dragflag;
    NSPoint lastpoint;
    query2image * q2i;
}
@property resultimageview * riv;
@property NSRect selectedrect;
@property int dragflag;
@property NSPoint lastpoint;
@property query2image * q2i;
-(void)initial;
-(void)getSelectedDS:(NSPoint)point;
@end
