//
//  serverOptions.h
//  testDrawSketch
//
//  Created by xusea on 2016/10/25.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface seOptions : NSObject
{
    NSString * logofile;
    NSString * sename;
    NSString * pattern;
    int depth;
    int check;
}
@property (retain) NSString * logofile;
@property (retain) NSString * sename;
@property (retain) NSString * pattern;
@property int depth;
@property int check;

@end
@interface serverOptions : NSObject
{
    NSMutableArray * selist;
    int sedepth;
    NSDictionary * filetype;
}
@property NSMutableArray * selist;
@property int sedepth;
@property NSDictionary * filetype;
-(void)initial;
-(BOOL)supporttype:(NSString *) type;
@end
