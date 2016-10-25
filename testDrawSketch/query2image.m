//
//  query2image.m
//  testDrawSketch
//
//  Created by xusea on 16/6/14.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import "query2image.h"




@implementation query2image
@synthesize query;
@synthesize selist;
@synthesize imageitemlist;
@synthesize url2file;
@synthesize imagesource;
@synthesize ikipoint;
@synthesize dsketch;
@synthesize thumbnailViewpoint;
@synthesize selectflag;
@synthesize dir;
@synthesize selectedimageind;
@synthesize bestimageind;
@synthesize visiblerange;
@synthesize backgroundflag;
@synthesize serveroption;
@synthesize lock;
- (id) init
{
    if(self = [super init])
    {
        query = @"NONE";
        selist = [[NSMutableArray alloc]init];
        NSString * se = @"baiduimage";
        [selist addObject:se];
        imageitemlist = [[NSMutableArray alloc]init];
        url2file = [[NSMutableDictionary alloc]init];
        imagesource = [[scrollimagedelegate alloc]init];
        selectflag = 0;
        dir = NSTemporaryDirectory();
        selectedimageind = -1;
        bestimageind = -1;
        visiblerange = -1;
        backgroundflag = 0;
        lock = [[NSLock alloc]init];
    }
    return self; 
}
-(void)downloadfile:(NSString *)url file:(NSString *)file
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    //  session
    NSURLSession *session = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    //NSURLSession *session = [NSURLSession sharedSession];
    
    //         URL
    //NSURL *url1 = [NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/w%3D2048/sign=6be5fc5f718da9774e2f812b8469f919/8b13632762d0f703b0faaab00afa513d2697c515.jpg"];
    //NSURL *url1 = [NSURL URLWithString:@"http://www.baidu.com/"];//  Download
    NSURL *url1 = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url1];
    //NSURLSessionDownloadTask *task =  [session downloadTaskWithURL:url1];
    NSURLSessionDownloadTask *task =  [session downloadTaskWithRequest:request];
    [task resume];
   // NSLog(@"dsdfsd");
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
    //NSString *fileName = [[downloadTask.originalRequest.URL absoluteString]lastPathComponent];
    NSString * orgurl = [downloadTask.originalRequest.URL absoluteString];
    //NSString * filename = [url2file objectForKey:orgurl];
    imageitem * imaget = [url2file objectForKey:orgurl];
    [imaget setDownflag:1];
    NSString * filename = [imaget filename];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    /*NSString *downloadDir = [NSTemporaryDirectory()  stringByAppendingPathComponent:filename];
    NSURL *downloadURL = [NSURL fileURLWithPath:downloadDir];*/
    NSURL *downloadURL = [NSURL fileURLWithPath:filename];
    if ([fileManager moveItemAtURL:location toURL:downloadURL error: &err])
    {
        if([orgurl hasPrefix:@"http://image.baidu.com/search/"])
        {
            NSLog(@"handle search engine %@", orgurl);
            [self getimagesfrombaiduresult:downloadURL];
            //[self getimagesfromseresult:downloadURL sesource:@"baiduimage"];
        }
        if([orgurl hasPrefix:@"http://cn.bing.com/images/"])
        {
            NSLog(@"handle search engine %@", orgurl);
            [self getimagesfrombingresult:downloadURL];
            //[self getimagesfromseresult:downloadURL sesource:@"baiduimage"];
        }
        if([orgurl hasPrefix:@"http://pic.sogou.com/"])
        {
            NSLog(@"handle search engine %@", orgurl);
            [self getimagesfromsogouresult:downloadURL];
            //[self getimagesfromseresult:downloadURL sesource:@"baiduimage"];
        }
        if([imaget type ]==1)
        {
            NSString * imagename = [[downloadURL absoluteString] substringWithRange:NSMakeRange(7, [[downloadURL absoluteString] length] - 7)];
            
            if([self checkdownloadfile:imagename] !=0 )
            {
                return ;
            }
            MyScrollImageObject * msi = [[MyScrollImageObject alloc]init];
            [msi setUrl:[NSURL URLWithString:orgurl]];
            
            NSImage * image =[[NSImage alloc]initWithContentsOfFile:imagename];
            [msi setI:image];
            [msi setTitle:@"123"];
            //设置文件名到subtitle第二位，替换score，用于debug
            NSArray * strs = [[imaget filename] componentsSeparatedByString:@"/"];
            NSString * filenametemp = [[strs lastObject] substringWithRange:NSMakeRange(0, 5)];
            [msi setSubtitle:[NSString stringWithFormat:@"1_%@",filenametemp]];
            [msi changevalue:[imaget se] index:4];
            //[msi setSubtitle:@"1_-1.0"];
            [[imagesource scrollimages] addObject:msi];
            [imaget setMyiobjectpoint:msi];
            int ind = [[imagesource scrollimages] count];
            [imaget setInd:ind];
            //小于10的时候自动滚屏
            if([[imagesource scrollimages] count] < 10)
            {
                
                [imagesource setVisiblerange:(int)[[imagesource scrollimages] count] ];
                [self setVisiblerange:(int)[[imagesource scrollimages] count] ];
                if(selectflag == 1)
                {
                    [ikipoint reloadData];
                }
            }
            
        }
        //NSLog(@"downnewfile %@", location);
    }
    else
    {
        NSLog(@"err %@ ",err);
    }
}

- (void)showResponseCode:(NSURLResponse *)response {
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSInteger responseStatusCode = [httpResponse statusCode];
    NSLog(@"%ld", (long)responseStatusCode);
}
-(void)getimages
{
    NSString * queryencode = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    for(int i = 0; i < [[serveroption selist] count]; i++)
    {
        seOptions * seop = [[serveroption selist] objectAtIndex:i];
        if([seop check] == 0)
        {
            continue;
        }
        NSString * urlpattern = [seop pattern];
        NSRange range = [urlpattern rangeOfString:@"[query]"];
        
        if(range.location != NSNotFound)
        {
            urlpattern = [urlpattern stringByReplacingOccurrencesOfString:@"[query]" withString:queryencode];
            urlpattern = [urlpattern stringByReplacingOccurrencesOfString:@"[number]" withString:[NSString stringWithFormat:@"%d", [seop depth]]];
            NSLog(@"new search %@", urlpattern);
            NSString * filename = [NSString stringWithFormat:@"%@/%@.png", dir, [self getrandstr]];
            NSString * grayname = [NSString stringWithFormat:@"%@/%@.png", dir, [self getrandstr]];
            NSString * logname = [NSString stringWithFormat:@"%@/%@.png", dir, [self getrandstr]];
            
            imageitem * seitem = [[imageitem alloc]init];
            [seitem setUrl:urlpattern];
            [seitem setType:0];
            [seitem setDownflag:0];
            [seitem setFilename:filename];
            [seitem setGrayname:grayname];
            [seitem setLogname:logname];
            [seitem setScore:MAXFLOAT];
            [url2file setObject:seitem  forKey:urlpattern];
            [self downloadfile:urlpattern file:filename];
        }
        else
        {
            NSLog(@"serveroptions error !!! bad pattern %@", urlpattern);
        }
    }
}
-(NSString *)getrandstr
{
    int NUMBER_OF_CHARS = 10;
    char data[NUMBER_OF_CHARS];
    for (int x=0;x < NUMBER_OF_CHARS; x++)
    {
        data[x] = ('A' + (arc4random_uniform(26)));
    }
    NSString *dataPoint = [[NSString alloc] initWithBytes:data length:NUMBER_OF_CHARS encoding:NSUTF8StringEncoding];
    return dataPoint;
}

-(NSString *)getrandnum
{
    int NUMBER_OF_CHARS = 5;
    char data[NUMBER_OF_CHARS];
    for (int x=0;x < NUMBER_OF_CHARS; x++)
    {
        data[x] = ('0' + (arc4random_uniform(10)));
    }
    NSString *dataPoint = [[NSString alloc] initWithBytes:data length:NUMBER_OF_CHARS encoding:NSUTF8StringEncoding];
    return dataPoint;
}
/*
 被其他函数替换
 */
-(int)getimagesfromseresult:(NSURL *)filename sesource:(NSString*) se
{
    NSString * filecontent = [NSString stringWithContentsOfFile:[[filename absoluteString] substringWithRange:NSMakeRange(7, [[filename absoluteString] length] - 7)]  encoding:NSUTF8StringEncoding error:nil];
    //NSLog(@"substring %@", [filecontent substringWithRange:NSMakeRange(0, 10)]);
    NSArray * strs = [filecontent componentsSeparatedByString:@"\""];
    for(int i = 0;i < [strs count] ; i ++)
    {
        if([[strs objectAtIndex:i] isEqualToString:@"objURL"])
        {
           //NSLog(@"get pic url %@", [strs objectAtIndex:(i +2)]);
            imageitem * image = [[imageitem alloc]init];
            NSString * url = [strs objectAtIndex:(i +2)];
            NSArray * urls = [url componentsSeparatedByString:@"."];
            NSString * suffix = [urls lastObject];
            [image setSe:se];
            [image setType:1];
            [image setUrl:url];
            [image setDownflag:0];
            [image setInd:[imageitemlist count]];
            NSString * prefixstr = [self getrandnum];
            NSString * filename =[NSString stringWithFormat:@"%@/%@%@.%@", dir,prefixstr, [self getrandstr], suffix];
            
            NSString * grayname = [NSString stringWithFormat:@"%@/%@%@.png", dir, prefixstr, [self getrandstr]];
            NSString * logname = [NSString stringWithFormat:@"%@/%@%@.png", dir, prefixstr, [self getrandstr]];
            NSString * transparentname = [NSString stringWithFormat:@"%@/%@%@.png", dir, prefixstr, [self getrandstr]];
            NSString * strokename = [NSString stringWithFormat:@"%@/%@%@.png", dir, prefixstr, [self getrandstr]];
            [image setFilename:filename];
            [image setGrayname:grayname];
            [image setLogname:logname];
            [image setTransparentname:transparentname];
            [image setStrokename:strokename];
            [image setMyiobjectpoint:nil];
            [image setInd:-1];
            [imageitemlist addObject:image];
            
            [url2file setObject:image forKey:url];
            i+=2;
        }
    }
    
    for(int i = 0; i < [imageitemlist count] && i < 30; i++)
    {
        imageitem * image = [imageitemlist objectAtIndex:i];
        [self downloadfile:[image url] file:[image filename]];
    }
    return 0;
}
-(int)getimagesfrombaiduresult:(NSURL *)filename
{
    NSString * filecontent = [NSString stringWithContentsOfFile:[[filename absoluteString] substringWithRange:NSMakeRange(7, [[filename absoluteString] length] - 7)]  encoding:NSUTF8StringEncoding error:nil];
    NSArray * strs = [filecontent componentsSeparatedByString:@"\""];
    for(int i = 0;i < [strs count]; i ++)
    {
        if([[strs objectAtIndex:i] isEqualToString:@"objURL"])
        {
            //NSLog(@"get pic url %@", [strs objectAtIndex:(i +2)]);
            imageitem * image = [[imageitem alloc]init];
            NSString * url = [strs objectAtIndex:(i +2)];
            NSArray * urls = [url componentsSeparatedByString:@"."];
            NSString * suffix = [urls lastObject];
            [image setSe:@"baiduimage"];
            [image setType:1];
            [image setUrl:url];
            [image setDownflag:0];
            [image setInd:[imageitemlist count]];
            NSString * prefixstr = [self getrandnum];
            NSString * filename =[NSString stringWithFormat:@"%@/%@%@.%@", dir,prefixstr, [self getrandstr], suffix];
            
            NSString * grayname = [NSString stringWithFormat:@"%@/%@%@.png", dir, prefixstr, [self getrandstr]];
            NSString * logname = [NSString stringWithFormat:@"%@/%@%@.png", dir, prefixstr, [self getrandstr]];
            NSString * transparentname = [NSString stringWithFormat:@"%@/%@%@.png", dir, prefixstr, [self getrandstr]];
            NSString * strokename = [NSString stringWithFormat:@"%@/%@%@.png", dir, prefixstr, [self getrandstr]];
            [image setFilename:filename];
            [image setGrayname:grayname];
            [image setLogname:logname];
            [image setTransparentname:transparentname];
            [image setStrokename:strokename];
            [image setMyiobjectpoint:nil];
            [image setInd:-1];
            [lock lock];
            [imageitemlist addObject:image];
            [lock unlock];
            [url2file setObject:image forKey:url];
            i+=2;
        }
    }
     NSLog(@"downstart baiduimage");
    [self downloadimagefromse:@"baiduimage"];

    return 0;
}
-(int)getimagesfrombingresult:(NSURL *)filename
{
    NSString * filecontent = [NSString stringWithContentsOfFile:[[filename absoluteString] substringWithRange:NSMakeRange(7, [[filename absoluteString] length] - 7)]  encoding:NSUTF8StringEncoding error:nil];
    NSArray * strs = [filecontent componentsSeparatedByString:@"\""];
    for(int i = 0;i < [strs count] - 5; i ++)
    {
        if([[strs objectAtIndex:i] isEqualToString:@"thumb"]
           &&[[strs objectAtIndex:(i+1)] isEqualToString:@" target="]
           &&[[strs objectAtIndex:(i+2)] isEqualToString:@"_blank"]
           &&[[strs objectAtIndex:(i+3)] isEqualToString:@" href="])
        {
            //NSLog(@"get pic url %@", [strs objectAtIndex:(i +2)]);
            imageitem * image = [[imageitem alloc]init];
            NSString * url = [strs objectAtIndex:(i+4)];
            NSArray * urls = [url componentsSeparatedByString:@"."];
            NSString * suffix = [urls lastObject];
            [image setSe:@"bingimage"];
            [image setType:1];
            [image setUrl:url];
            [image setDownflag:0];
            [image setInd:[imageitemlist count]];
            NSString * prefixstr = [self getrandnum];
            NSString * filename =[NSString stringWithFormat:@"%@/%@%@.%@", dir,prefixstr, [self getrandstr], suffix];
            
            NSString * grayname = [NSString stringWithFormat:@"%@/%@%@.png", dir, prefixstr, [self getrandstr]];
            NSString * logname = [NSString stringWithFormat:@"%@/%@%@.png", dir, prefixstr, [self getrandstr]];
            NSString * transparentname = [NSString stringWithFormat:@"%@/%@%@.png", dir, prefixstr, [self getrandstr]];
            NSString * strokename = [NSString stringWithFormat:@"%@/%@%@.png", dir, prefixstr, [self getrandstr]];
            [image setFilename:filename];
            [image setGrayname:grayname];
            [image setLogname:logname];
            [image setTransparentname:transparentname];
            [image setStrokename:strokename];
            [image setMyiobjectpoint:nil];
            [image setInd:-1];
            [lock lock];
            [imageitemlist addObject:image];
            [lock unlock];
            
            [url2file setObject:image forKey:url];
            i+=4;
        }
    }
    NSLog(@"downstart bingimage");
    [self downloadimagefromse:@"bingimage"];
    return 0;
}
-(int)getimagesfromsogouresult:(NSURL *)filename
{
    NSString * filecontent = [NSString stringWithContentsOfFile:[[filename absoluteString] substringWithRange:NSMakeRange(7, [[filename absoluteString] length] - 7)]  encoding:NSUTF8StringEncoding error:nil];
    NSArray * strs = [filecontent componentsSeparatedByString:@"\""];
    for(int i = 0;i < [strs count]; i ++)
    {
        if([[strs objectAtIndex:i] isEqualToString:@"objURL"])
        {
            //NSLog(@"get pic url %@", [strs objectAtIndex:(i +2)]);
            imageitem * image = [[imageitem alloc]init];
            NSString * url = [strs objectAtIndex:(i +2)];
            NSArray * urls = [url componentsSeparatedByString:@"."];
            NSString * suffix = [urls lastObject];
            [image setSe:@"sogouimage"];
            [image setType:1];
            [image setUrl:url];
            [image setDownflag:0];
            [image setInd:[imageitemlist count]];
            NSString * prefixstr = [self getrandnum];
            NSString * filename =[NSString stringWithFormat:@"%@/%@%@.%@", dir,prefixstr, [self getrandstr], suffix];
            
            NSString * grayname = [NSString stringWithFormat:@"%@/%@%@.png", dir, prefixstr, [self getrandstr]];
            NSString * logname = [NSString stringWithFormat:@"%@/%@%@.png", dir, prefixstr, [self getrandstr]];
            NSString * transparentname = [NSString stringWithFormat:@"%@/%@%@.png", dir, prefixstr, [self getrandstr]];
            NSString * strokename = [NSString stringWithFormat:@"%@/%@%@.png", dir, prefixstr, [self getrandstr]];
            [image setFilename:filename];
            [image setGrayname:grayname];
            [image setLogname:logname];
            [image setTransparentname:transparentname];
            [image setStrokename:strokename];
            [image setMyiobjectpoint:nil];
            [image setInd:-1];
            [lock lock];
            [imageitemlist addObject:image];
            [lock unlock];
            
            [url2file setObject:image forKey:url];
            i+=2;
        }
    }
    [self downloadimagefromse:@"sogouimage"];
    return 0;
}
-(int)downloadimagefromse:(NSString *)se
{
    [lock lock];
    int c = 0;
    for(int i = 0; i < [imageitemlist count] ; i++)
    {
        imageitem * image = [imageitemlist objectAtIndex:i];
        if([[image se]isEqualToString:se])
        {
            c++;
            [self downloadfile:[image url] file:[image filename]];
            if(c==[serveroption sedepth])
            {
                break;
            }
        }
    }
    [lock unlock];
    return 0;
}
-(imageitem *)getdownimageitem
{
    imageitem * rimage = nil;
    for(int i = 0 ;i < [imageitemlist count]; i ++)
    {
        imageitem * temp = [imageitemlist objectAtIndex:i];
        if([temp downflag] == 1)
        {
            rimage = temp;
            break;
        }
    }
    return rimage;
}

-(void)statimagescore:(imageitem *)it
{
    if(it == nil)
    {
        return ;
    }
    for(int i = 0 ; i < [imageitemlist count]; i ++)
    {
        imageitem * temp = [imageitemlist objectAtIndex:i];
        if(temp == it)
        {
            double score = [imagetrans imagecom:[dsketch tracefillcontourpath] rightfile:[temp logname]];
            //NSLog(@"score %lf", score);
            [temp setScore:score];
           
            // #####暂时注释掉份数，为了debug 文件名
            //[[temp myiobjectpoint] changevalue:[NSString stringWithFormat:@"%lf", score] index:1];
            if([temp ind] > [self visiblerange])
            {
                
            }
            else
            {
                if(score < 0)
                {

                }
                else
                {
                    if(bestimageind == -1)
                    {
                        bestimageind = i;
                        if(bestimageind != selectedimageind)
                        {
                            [[temp myiobjectpoint] changevalue:@"3" index:0];
                        }
                    }
                    else if(bestimageind > -1 && bestimageind < [imageitemlist count])
                    {
                        imageitem * bit = [imageitemlist objectAtIndex:bestimageind];
                        double mscore = [bit score];
                        if(score > 0.0001 && score < mscore && i != bestimageind)
                        {
                           
                            //修改旧的属性
                            if(bestimageind != selectedimageind)
                            {
                                [[bit myiobjectpoint] changevalue:@"2" index:0];
                            }
                            bestimageind = i;
        
                            if(bestimageind != selectedimageind)
                            {
                                [[temp myiobjectpoint] changevalue:@"3" index:0];
                            }
                        }
                    }
                }
            }
            break;
        }
    }
}

-(imageitem *)getbestimageitem
{
    imageitem * it = nil;
    if(bestimageind != -1  && bestimageind < [imageitemlist count])
    {
        it = [imageitemlist objectAtIndex:bestimageind];
    }
    return it;
}
-(imageitem *)getselectedimageitem
{
    imageitem * it = nil;
    if(selectedimageind != -1  && selectedimageind < [imageitemlist count])
    {
        it = [imageitemlist objectAtIndex:selectedimageind];
    }

    return it;
}
-(int)checkdownloadfile:(NSString *)filename
{
    NSImage * i = [[NSImage alloc]initWithContentsOfFile:filename];
    if(i == nil)
    {
        return -1;
    }
    if([i size].width == 0 || [i size].height == 0)
    {
        return -2;
    }
    return 0;
}
-(void)resetbestimagescore
{
    int imagecount = [[imagesource scrollimages] count];
    [imagesource setVisiblerange:imagecount];
    [ikipoint reloadData];
    int bestind = [self bestimageind];
    float tempscore = -1;
    if(bestind != -1)
    {
        tempscore = [[imageitemlist objectAtIndex:bestind] score];
    }
    for(int i = 0 ; i < [imageitemlist count]; i ++)
    {
        imageitem * temp = [imageitemlist objectAtIndex:i];
        if([temp score] > 0.0001)
        {
            if(bestind < 0)
            {
                bestind = i;
            }
            else
            {
                if([temp score] < tempscore)
                {
                    bestind = i;
                    tempscore = [temp score];
                }
            }
        }
    }
    if(bestind != -1 && bestind != [self bestimageind])
    {
        imageitem * bit = [imageitemlist objectAtIndex:bestimageind];
        [[bit myiobjectpoint] changevalue:@"2" index:0];
        bit = [imageitemlist objectAtIndex:bestind];
        [[bit myiobjectpoint] changevalue:@"3" index:0];
    }
    [self setBestimageind:bestind];
}
@end
