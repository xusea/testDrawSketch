//
//  scrollimagedelegate.h
//  testDrawSketch
//
//  Created by xusea on 16/6/16.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Quartz/Quartz.h>
@interface MyScrollImageObject : NSObject
{
    NSURL *url;
    NSImage * i;
    NSString * fontname;
    NSString * subtitle;//1 下载 2 转换 3 选中
    NSString * title;
}

@property (retain) NSURL *url;
@property (retain) NSImage * i;
@property (retain) NSString * fontname;
@property (retain) NSString * subtitle;
@property (retain) NSString * title;
@end

@interface scrollimagedelegate : NSObject
{
    NSMutableArray * scrollimages;

}
@property NSMutableArray * scrollimages;
@end
