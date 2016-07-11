//
//  downfile.h
//  testDrawSketch
//
//  Created by xusea on 16/6/13.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "query2image.h"
//废弃
@interface downfile : NSObject<NSURLSessionDownloadDelegate>
{
   // query2image * qi;
}
-(void)downloadfile:(NSString *)url file:(NSString *)file;
-(NSString *)getDocumentsPath;
-(void)showResponseCode:(NSURLResponse *)response ;
@end
