//
//  resultdetailViewController.h
//  testDrawSketch
//
//  Created by xusea on 2016/9/21.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "resultimageview.h"
@interface resultdetailViewController : NSViewController
{
    //NSMutableArray * querydrawlist;
}
//@property NSMutableArray * querydrawlist;
@property (weak) IBOutlet resultimageview *resultimage;
@property (strong) IBOutlet NSView *allview;

@end
