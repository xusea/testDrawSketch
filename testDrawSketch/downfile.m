//
//  downfile.m
//  testDrawSketch
//
//  Created by xusea on 16/6/13.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import "downfile.h"

@implementation downfile
//下载单个文件
-(void)downloadfile:(NSString *)url file:(NSString *)file
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    //  session
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    //NSURLSession *session = [NSURLSession sharedSession];
    
    //         URL
    //NSURL *url1 = [NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/w%3D2048/sign=6be5fc5f718da9774e2f812b8469f919/8b13632762d0f703b0faaab00afa513d2697c515.jpg"];
    NSURL *url1 = [NSURL URLWithString:@"http://www.baidu.com/"];//  Download
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url1];
    //NSURLSessionDownloadTask *task =  [session downloadTaskWithURL:url1];
    NSURLSessionDownloadTask *task =  [session downloadTaskWithRequest:request];
    [task resume];
    //NSLog(@"dsdfsd");
    /*NSURL *URL = [NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/w%3D2048/sign=6be5fc5f718da9774e2f812b8469f919/8b13632762d0f703b0faaab00afa513d2697c515.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request
                                                            completionHandler:
                                              ^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                  [self showResponseCode:response];
                                                  
                                                  // 输出下载文件原来的存放目录
                                                  NSLog(@"location :    %@", location);
                                                  
                                                  // 设置文件的存放目标路径
                                                  NSString *documentsPath = [self getDocumentsPath];
                                                  NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:documentsPath];
                                                  NSURL *fileURL = [documentsDirectoryURL URLByAppendingPathComponent:[[response URL] lastPathComponent]];
                                                  
                                                  // 如果该路径下文件已经存在，就要先将其移除，在移动文件
                                                  NSFileManager *fileManager = [NSFileManager defaultManager];
                                                  if ([fileManager fileExistsAtPath:[fileURL path] isDirectory:NULL]) {
                                                      [fileManager removeItemAtURL:fileURL error:NULL];
                                                  }
                                                  [fileManager moveItemAtURL:location toURL:fileURL error:NULL];
                                                  
                                                  // 在webView中加载图片文件
//                                                  NSURLRequest *showImage_request = [NSURLRequest requestWithURL:fileURL];
                                                  
                                              }];
    
    [downloadTask resume];*/
}
- (NSString *)getDocumentsPath {
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = documents[0];
    NSLog(@"path %@" ,documentsPath);
    return documentsPath;
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSError *err = nil;
    //
    NSString *fileName = [[downloadTask.originalRequest.URL absoluteString]lastPathComponent];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *downloadDir = [[NSHomeDirectory()
                              stringByAppendingPathComponent:@"Downloads"] stringByAppendingPathComponent:fileName];
    NSURL *downloadURL = [NSURL fileURLWithPath:downloadDir];
    sleep(20);
    if ([fileManager moveItemAtURL:location toURL:downloadURL error: &err])
    {
        NSLog(@"nonono %@", location);
    }
    else
    {
        NSLog(@"err %@ ",err);
    }
}

- (void)showResponseCode:(NSURLResponse *)response {
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSInteger responseStatusCode = [httpResponse statusCode];
    NSLog(@"%d", responseStatusCode);
}
@end
