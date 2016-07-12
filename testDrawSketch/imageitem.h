//
//  imageitem.h
//  testDrawSketch
//
//  Created by xusea on 16/6/14.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MyScrollImageObject;
@interface imageitem : NSObject
{
    NSString * url;
    NSString * se;
    NSString * filename;
    NSString * grayname;
    NSString * logname;
    NSString * transparentname;
    int downflag;
    int ind;
    int type;//0 se , 1 image
    MyScrollImageObject * myiobjectpoint;
    double score;
}
@property NSString * url;
@property NSString * se;
@property NSString * filename;
@property NSString * grayname;
@property NSString * logname;
@property NSString * transparentname;
@property int downflag;
@property int ind;
@property int type;
@property MyScrollImageObject * myiobjectpoint;
@property double score;
@end
