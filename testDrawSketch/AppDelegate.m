//
//  AppDelegate.m
//  testDrawSketch
//
//  Created by xusea on 16/5/26.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate
@synthesize imagedatasource;
@synthesize qi;
@synthesize querydraw;
@synthesize tvc;
@synthesize colorset;
@synthesize colorind;
@synthesize fpos;
@synthesize convert_progress;
@synthesize lock;
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    //初始化颜色
    colorset = [[NSMutableArray alloc]init];
    [colorset addObject:[NSColor blackColor]];
    [colorset addObject:[NSColor blueColor]];
    [colorset addObject:[NSColor brownColor]];
    [colorset addObject:[NSColor clearColor]];
    [colorset addObject:[NSColor cyanColor]];
    [colorset addObject:[NSColor darkGrayColor]];
    [colorset addObject:[NSColor grayColor]];
    [colorset addObject:[NSColor greenColor]];
    [colorset addObject:[NSColor lightGrayColor]];
    [colorset addObject:[NSColor magentaColor]];
    [colorset addObject:[NSColor orangeColor]];
    [colorset addObject:[NSColor purpleColor]];
    [colorset addObject:[NSColor redColor]];
    [colorset addObject:[NSColor whiteColor]];
    [colorset addObject:[NSColor yellowColor]];
    colorind = 0;
    // Insert code here to initialize your application
  /*  [imagetrans test];
    NSString* dir = NSTemporaryDirectory();
    NSString * orgimage = [NSString stringWithFormat:@"/Users/xusea/sketch2photo/imgdata/20.jpg"];
    NSString * grayimage = [NSString stringWithFormat:@"/Users/xusea/sketch2photo/imgdata/out_log/20.png"];
    //NSString * grayimage = [NSString stringWithFormat:@"/Users/xusea/Desktop/123.png"];
    NSString * outimage = [NSString stringWithFormat:@"%@/sketch.png",dir];
    [imagetrans imagesketch:grayimage orgimage:orgimage outimage:outimage];
    NSString * cutimage = [NSString stringWithFormat:@"%@/sketchcut.png",dir];
    [imagetrans cutalpha:outimage outimage:cutimage];*/
    NSLog(@"start");
    //初始化
    //1.整体信息
    querydraw = [[NSMutableArray alloc]init];
    
    //2.左侧初始化
    tvc = [[thumbnailViewCollection alloc]init];
    [_thumblist setDocumentView:tvc];
    [tvc setNeedsDisplay:YES];
    [_thumblist setNeedsDisplay:YES];
    //3.底部初始化
    [_scrollimagelist setContentResizingMask:NSViewWidthSizable];
    
    //4.初始化绘画修正点
    fpos = [_dSC frame].origin;
    
    //5.启动独立线程转换图片
    convert_progress = [[NSThread alloc] initWithTarget:self selector:@selector(run_convert) object:nil];
    [convert_progress setName:@"Thread_convert"];
    [convert_progress start];
 /*   qi = [[query2image alloc]init];
    imagedatasource = [[scrollimagedelegate alloc]init];
    [qi setImagesource:imagedatasource];
    [_scrollimagelist setDataSource:imagedatasource];
    [_scrollimagelist setContentResizingMask:NSViewWidthSizable];
    [qi setIkipoint:_scrollimagelist];
    
    for(int i = 0; i < 15;i++)
    {
        thumbnailView * tV = [[thumbnailView alloc]init];
        [tV setParentcollection:tvc];
        NSRect frame = [tV frame];
        NSString * q = [NSString stringWithFormat:@"query :%d", i];
        [tV setQuery:q];
        frame.origin.y = i * frame.size.height;
        [tV setFrame:frame];
        [[_thumblist documentView] addSubview:tV];
        NSRect scrollframe = frame;
        scrollframe.size.height = i * frame.size.height;
        [[_thumblist documentView] setFrameSize:scrollframe.size];
    }
    
    
    
    for(int i = 0; i < [[tvc subviews] count]; i ++)
    {
        NSLog(@"%d %ld %@", i, [[[tvc subviews]objectAtIndex:i] tag], NSStringFromClass([[[tvc subviews]objectAtIndex:i] class]));
    }*/
    /* [_thumblist setTranslatesAutoresizingMaskIntoConstraints:YES];
    [_thumblist setHasHorizontalScroller:YES];
    [_thumblist setHasVerticalRuler:YES];
    [_thumblist setAutohidesScrollers:NSViewWidthSizable|NSViewHeightSizable];
    for(int i = 0; i < 15;i++)
    {
        thumbnailView * tV = [[thumbnailView alloc]init];
        NSRect frame = [tV frame];
        NSString * q = [NSString stringWithFormat:@"query :%d", i];
        [tV setQuery:q];
        frame.origin.y = i * frame.size.height;
        [tV setFrame:frame];
        [[_thumblist contentView] addSubview:tV];
        NSRect scrollframe = frame;
        scrollframe.size.height = i * frame.size.height;
        NSLog(@"%f %f", [_thumblist contentSize].width, [_thumblist contentSize].height);
        [[_thumblist contentView]setFrame:scrollframe];
        [[_thumblist documentView]setFrame:scrollframe];
    }*/
    //[_thumblist setDocumentView:tvc];
    //[[_thumblist documentView] setFrameSize:NSMakeSize(400, 800)];
    //[_imageT setHasVerticalScroller:NO];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)addDS:(id)sender {
    NSLog(@"add new sketch");
    NSString *prompt = @"Please enter text to append to file name:";
    NSString *infoText = @"What happens here is...";
    NSString *defaultValue = @"Default Value";
    
    NSAlert *alert = [NSAlert alertWithMessageText: prompt
                                     defaultButton:@"Save"
                                   alternateButton:@"Cancel"
                                       otherButton:nil
                         informativeTextWithFormat:infoText];
    
    NSTextField *input = [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 24)];
    [input setStringValue:defaultValue];
    [alert setAccessoryView:input];
    NSString * inputq = @"NONE";
    NSInteger button = [alert runModal];
    if (button == NSAlertDefaultReturn) {
        [input validateEditing];
        NSLog(@"User entered: %@", [input stringValue]);
        inputq = [input stringValue];
    } else if (button == NSAlertAlternateReturn) {
        NSLog(@"User cancelled");
    } else {
        NSLog(@"bla");
    }
    
    // drawSketch
    NSRect dsframe = [_dSC frame];
    dsframe.origin.x = 0;
    dsframe.origin.y = 0;
    drawSketch * dS = [[drawSketch alloc]initWithFrame:dsframe];
    [dS setTracecolor:[colorset objectAtIndex:colorind]];
    [dS setFixpos:fpos];
    [dS setQuery:inputq];
    
    [_dSC addSubview:dS];
    
    //thumbnailView
    thumbnailView * tV = [[thumbnailView alloc]init];
    [tV setParentcollection:tvc];
    [tV setTracecolor:[colorset objectAtIndex:colorind]];
    [tV setDspoint:dS];
    [tV setQuery:inputq];
    [tV setButtomimagelist:_scrollimagelist];
    [dS setTnVpoint:tV];
    
    NSRect frame = [tV frame];
    NSRect scrollframe = frame;
    frame.origin.y = [[tvc subviews]  count] * frame.size.height;
    [tV setFrame:frame];
    scrollframe.size.height = ([[tvc subviews]  count] +1) * frame.size.height;
    [[_thumblist documentView] addSubview:tV];
    [[_thumblist contentView]setFrame:scrollframe];
    [[_thumblist documentView]setFrame:scrollframe];

    //query2image
    query2image * q2i = [[query2image alloc]init];
    [q2i setQuery:@"1"];
    [q2i setThumbnailViewpoint:tV];
    [q2i setDsketch:dS];
    [q2i setQuery:inputq];
    [querydraw addObject:q2i];
    [tV setQ2ipoint:q2i];
    colorind = (colorind + 1) % [colorset count];
  /*  drawSketch *dS = [[drawSketch alloc]initWithFrame:NSMakeRect(100, 100, 100, 100)];
   // [_window contentView addSubview:dS];
    [[_window contentView] addSubview:dS];*/
    
    
    //[self.window.contentView addSubview:dS];
}

- (IBAction)debug:(id)sender {
    /*for(int i = 0; i < [[[_window contentView] subviews] count]; i ++)
    {
        NSLog(@"%d %ld %@", i, [[[[_window contentView] subviews]objectAtIndex:i] tag], NSStringFromClass([[[[_window contentView] subviews]objectAtIndex:i] class]));
    }*/
   /* NSString * info = [NSString stringWithFormat:@"image download progress:{%lu}", (unsigned long)[[qi imageitemlist] count]];
    for(int i = 0; i < [[qi imageitemlist] count]; i++)
    {
        imageitem * image = [[qi imageitemlist]objectAtIndex:i];
        NSString * tstr = [NSString stringWithFormat:@" [%d %@ %d]", i, [image url], [image downflag]];
        //NSLog(@"%@", tstr);
        info = [info stringByAppendingString:tstr] ;
    }
    NSLog(@"%@", info);*/
    
/*    NSString * info = [NSString stringWithFormat:@"image download progress:"];
    NSLog(@"%@",info);
    
    MyScrollImageObject * msi = [[MyScrollImageObject alloc]init];
    //[msi setUrl:@"http://111/111.html"];
    NSString * imagename = @"11234";
    NSImage * image =[[NSImage alloc]initWithContentsOfFile:@"/Users/xusea/sketch2photo/104.jpg"];
    [msi setI:image];
    [[imagedatasource scrollimages] addObject:msi];
    
    [_scrollimagelist reloadData];*/
    //[imagetrans imagecut:@"/var/folders/vn/3_kk6lms28x0032c_v_z721h0000gn/T/IBPQYFGRWF.jpg" outfile:@"/var/folders/vn/3_kk6lms28x0032c_v_z721h0000gn/T/OVIIHWQYTD.png" logfile:@"/var/folders/vn/3_kk6lms28x0032c_v_z721h0000gn/T/VVIWSPVZYL.png"];
    
   /* NSString* dir = NSTemporaryDirectory();
    //NSString * imagedog = [NSString stringWithFormat:@"/Users/xusea/sketch2photo/11.jpg"];
    NSString * imagedog = @"/var/folders/vn/3_kk6lms28x0032c_v_z721h0000gn/T/IBPQYFGRWF.jpg";
    NSString * imagedoggray = [NSString stringWithFormat:@"%@/doggray.png", dir];
    NSString * imagedoglog = [NSString stringWithFormat:@"%@/doglog.png", dir];
    [imagetrans imagecut:imagedog outfile:imagedoggray logfile:imagedoglog];*/
/*    query2image * qi2 = [_scrollimagelist qi2point];
    [_scrollimagelist setDataSource:nil];
    
    [_scrollimagelist reloadData];
    [_scrollimagelist setDataSource:[qi2 imagesource]];
    [_scrollimagelist reloadData];*/
    NSMutableArray * querydrawlist = querydraw;
    NSString * str = @"";
    for(int i = 0; i < [querydrawlist count]; i ++)
    {
        query2image * q2i = [querydrawlist objectAtIndex:i];
        imageitem * it = [q2i getbestimageitem];
        str = [str stringByAppendingString:@" [] "];
        str = [str stringByAppendingString:[it filename]];
    }
    NSLog(@"current selected images %@", str);
}

- (IBAction)trace2png:(id)sender {
    for(int i = 0; i < [[[_window contentView] subviews] count]; i ++)
    {
         NSLog(@"%d %ld %@", i, [[[[_window contentView] subviews]objectAtIndex:i] tag], NSStringFromClass([[[[_window contentView] subviews]objectAtIndex:i] class]));
        NSString * subviewclass = NSStringFromClass([[[[_window contentView] subviews]objectAtIndex:i] class]);
        if([subviewclass isEqualToString:@"drawSketch"])
        {
            drawSketch * ds = [[[_window contentView] subviews]objectAtIndex:i];
            [ds trace2png];
        }
    }
}

- (IBAction)testdownfile:(id)sender {
    //[downfile downloadfile:@"" file:@""];
    
   // downfile * df = [[downfile alloc]init];
   // [df downloadfile:@"" file:@""];
    
   // query2image *qi = [[query2image alloc]init];
    
    
    //[qi setQuery:@"狗跳跃"];
    //[qi getimages];
    
    //[imagetrans resizeimage:@"/Users/xusea/matt/555.jpg" outimage:@"/Users/xusea/matt/556.jpg" newsize:NSMakeSize(400, 300)];
    
}

- (IBAction)start:(id)sender {
    //一、把所有sketch提取图形
    for(int i = 0 ; i < [querydraw count] && i < 10; i ++)
    {
        query2image * q2i = [querydraw objectAtIndex:i];
        [[q2i dsketch] trace2png];
    }
    //二、把所有query下载图片
    for(int i = 0 ; i < [querydraw count] && i < 10; i ++)
    {
        query2image * q2i = [querydraw objectAtIndex:i];
        [q2i getimages];
    }
    //三、拼接
}

- (IBAction)statscore:(id)sender {
    
}

- (IBAction)showscores:(id)sender {
    for(int i = 0 ; i < [querydraw count]; i ++)
    {
        query2image * q2i = [querydraw objectAtIndex:i];
        NSString * str = [q2i query];
        for(int j = 0;j < [[q2i imageitemlist] count] && j < 10; j ++)
        {
            imageitem * it = [[q2i imageitemlist] objectAtIndex:j];
            str = [str stringByAppendingString:[NSString stringWithFormat:@"[%f]",[it score] ]];
            str = [str stringByAppendingString:[[it myiobjectpoint] subtitle]];
        }
        NSLog(@"score: %@", str);
    }
}

-(void)run_convert
{
    while (YES) {
        [NSThread sleepForTimeInterval:0.1];
        [lock lock];
        imageitem * imaget = nil;
        query2image * q2i = nil;
        for(int i = 0 ; i < [querydraw count]; i ++)
        {
            query2image * tempq2i = [querydraw objectAtIndex:i];
            imageitem * temp = [tempq2i getdownimageitem];
            if(temp != nil)
            {
                imaget = temp;
                q2i = tempq2i;
                [imaget setDownflag:2];
                break;
            }
        }
        if(imaget != nil)
        {
/*            NSString * filename = [imaget filename];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *downloadDir = [NSTemporaryDirectory()  stringByAppendingPathComponent:filename];
            NSURL *downloadURL = [NSURL fileURLWithPath:downloadDir];
            NSString * imagename = [[downloadURL absoluteString] substringWithRange:NSMakeRange(7, [[downloadURL absoluteString] length] - 7)];*/
            NSString * imagename = [imaget filename];
            NSString * grayname = [imaget grayname];
            NSString * logname = [imaget logname];
            NSImage * image =[[NSImage alloc]initWithContentsOfFile:imagename];
            NSString * resizename = [NSTemporaryDirectory()  stringByAppendingPathComponent:[self getrandstr]];
            [imagetrans resizeimage:imagename outimage:resizename newsize:NSMakeSize(400, 300)];
            [imagetrans imagecut:resizename outfile:grayname logfile:logname];
            
            if([imaget myiobjectpoint] != nil)
            {
                
                NSString * subtitle = [[imaget myiobjectpoint] subtitle];
                NSArray * strs = [subtitle componentsSeparatedByString:@"_"];
                NSString * newsubtitle = [NSString stringWithFormat:@"2_%@",[strs objectAtIndex:1]];
                [[imaget myiobjectpoint] setSubtitle:newsubtitle];
                [q2i statimagescore:imaget];
                dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                    //Background Thread
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        //Run UI Updates
                        query2image * qi2 = [_scrollimagelist qi2point];
                        [_scrollimagelist setDataSource:nil];
                        
                        [_scrollimagelist reloadData];
                        [_scrollimagelist setDataSource:[qi2 imagesource]];
                        [_scrollimagelist reloadData];
                    });
                });
                /*dispatch_async(dispatch_get_main_queue(), ^{
                    //[_scrollimagelist setDataSource:[[_scrollimagelist qi2point] imagesource] ];
                    [_scrollimagelist reloadData];
                    [_scrollimagelist setNeedsDisplay:YES];
                    NSLog(@"holy shit!");
                });*/
                //[_scrollimagelist reloadData];
            }
            
        }
        /*if(flag == 1 && pw != nil)
        {
            //[[tw pg] setProgressOffset:a++];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[pw pg] setDoubleValue:g_progress];
            });
            //            NSLog(@"%d", a);
            //[alert setshow:a++];
        }
        if(g_progress == 100)
        {
            flag = 0;
            dispatch_async(dispatch_get_main_queue(), ^{
                [NSApp endSheet:[pw window]];
                [_window setMovable:YES];
            });
            g_progress = 0;
        }*/
        [lock unlock];
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
@end
