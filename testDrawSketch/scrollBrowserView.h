//
//  scrollBrowserView.h
//  testDrawSketch
//
//  Created by xusea on 16/6/29.
//  Copyright © 2016年 xusea. All rights reserved.
//
#import <Quartz/Quartz.h>
@class query2image;
@interface scrollBrowserView : IKImageBrowserView
{
    query2image * q2ipoint;
}
@property query2image * q2ipoint;
@end
