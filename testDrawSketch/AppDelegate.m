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
@synthesize mattwindow =_mattwindow;
@synthesize serveroption;
@synthesize zoomFactor;
@synthesize g_draworder;
@synthesize curzoomFactor;
@synthesize preferenceswindow;
@synthesize preferencesview;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
   // [imagetrans color2stroke:@"/Users/xusea/Desktop/df23js773_resultfilepath.png" strokename:@"/Users/xusea/Desktop/123.png"];
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
    
    //初始化常量
    zoomFactor = 1.3;
    g_draworder = 0;
    curzoomFactor = 1.0;
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
    
    //0.初始化配置文件
    serveroption = [[serverOptions alloc]init];
    [serveroption initial];
    //1.整体信息
    querydraw = [[NSMutableArray alloc]init];
    
    //2.左侧初始化
    tvc = [[thumbnailViewCollection alloc]init];
    [_thumblist setDocumentView:tvc];
    [tvc setNeedsDisplay:YES];
    [_thumblist setNeedsDisplay:YES];
    //3.底部初始化
    [_scrollimagelist setContentResizingMask:NSViewWidthSizable];
   // [_scrollimagelist setIntercellSpacing:NSMakeSize(5, 0)];
   // [_scrollimagelist setCellspace:[_scrollimagelist intercellSpacing].width];
    NSPoint fixpos = [_imageT frame].origin;
    [_imageT setHasVerticalScroller:NO];
    [_scrollimagelist setFixpos:fixpos];
    if([_window backingScaleFactor] > 1.0)
    {
        [_scrollimagelist setDPIScale:2];
    }
    //4.初始化绘画修正点
   // fpos = [_dSC frame].origin;
    fpos = [[_drawingboard dsc] frame].origin ;
    //5.启动独立线程转换图片
    convert_progress = [[NSThread alloc] initWithTarget:self selector:@selector(run_convert) object:nil];
    [convert_progress setName:@"Thread_convert"];
    [convert_progress start];
    
    //6.初始化左下角缩略图
   // [_resultimage setQuerydrawlist:querydraw];
    
    //7.右下角按钮
    [_extendbutton setEnabled:YES];
    
    //8.放大缩略图
    [_bigsizeimage initiation];
    [_bigsizeimage setHidden:YES];
    [_scrollimagelist setBigsizeimage:_bigsizeimage];
    [[_bigsizeimage thumbnailimage] setImageFrameStyle:NSImageFrameGrayBezel];
    [[_bigsizeimage strokeimage] setImageFrameStyle:NSImageFrameGrayBezel];
    
    //9.mattview（人工编辑框）初始化
/*    mattview = [[mattviewController alloc]init];
    bool ret = [[NSBundle mainBundle] loadNibNamed:@"mattviewController" owner:mattview topLevelObjects:nil];
    NSLog(@"load mattviewController %d", ret);
    [mattview viewDidLoad];
    [mattview setWindow:_window];
    [[_window contentView]addSubview:[mattview allview]];
    [[mattview allview]setHidden:YES];
    [_scrollimagelist setMattview:mattview];*/
    
    //10.mattwindow
   /* mattwindow = [[mattwindowcontroller alloc]init];
    ret = [[NSBundle mainBundle]loadNibNamed:@"mattwindowcontroller" owner:mattwindow topLevelObjects:nil];
    NSLog(@"load mattwindowController %d", ret);
    [[mattwindow window]setCanHide:YES];*/
    //[mattwindow windowDidLoad];
   // [[[mattwindow window] contentView] addSubview:[mattview allview]];
    //[NSApp runModalForWindow:[mattwindow window]];
    
    //12.初始化大图编辑
    resultdetailView = [[resultdetailViewController alloc]init];
    bool ret = [[NSBundle mainBundle]loadNibNamed:@"resultdetailViewController" owner:resultdetailView topLevelObjects:nil];
    NSLog(@"load resultdetailViewController %d", ret);
    //[[resultdetailView resultimage] setQuerydrawlist:querydraw];
    
    [[resultdetailView allview]setFrame:[_dSC frame]];
    [[_window contentView] addSubview:[resultdetailView allview]];
    [[resultdetailView allview]setHidden:YES];
    
    //13.初始化大图结果，12即将废弃
    //[_drawingboard setHidden:YES];
    [_drawingboard setQuerydrawlist:querydraw];
    [_drawingboard setRiv:_rivindrawingboard];
    //[_drawingboard setBackgroundview:_backgroundviewindrawingboard];
    [_drawingboard setDsc:_dscindrawingboard];
    [_drawingboard setBs:_bsindrawingboard];
    [_drawingboard setBsinner:_bsinnerindrawingboard];
    [_drawingboard setEirv:_eirvindrawingboard];
    [_drawingboard setBgv:_bgvindrawingboard];
    [_drawingboard setBge:_bgeindrawingboard];
    
    [_eirvindrawingboard initial];
    [_eirvindrawingboard setRiv:_rivindrawingboard];
   // [_rivindrawingboard setQuerydrawlist:querydraw];
    [_eirvindrawingboard setBrightnessslider:_showbrightness];
    [_eirvindrawingboard setContrastslider:_showcontrast];
    [_eirvindrawingboard setSaturationslider:_showsaturation];
    [_drawingboard initial];
    
    [tvc setDb:_drawingboard];
    NSLog(@"%f %f", [_bgeindrawingboard frame].size.width, [_bgeindrawingboard frame].size.height);
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
    //NSRect dsframe = [_dSC frame];
    NSRect dsframe = [[_drawingboard dsc]frame];
    dsframe.origin.x = 0;
    dsframe.origin.y = 0;
    drawSketch * dS = [[drawSketch alloc]initWithFrame:dsframe];
    [dS setTracecolor:[colorset objectAtIndex:colorind]];
    [dS setFixpos:fpos];
    [dS setQuery:inputq];
    
    [[_drawingboard dsc] addSubview:dS];
    //[_dSC addSubview:dS];
    
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
    [q2i setDisplayflag:1];
    [q2i setQuery:@"1"];
    [q2i setThumbnailViewpoint:tV];
    [q2i setDsketch:dS];
    [q2i setQuery:inputq];
    [q2i setIkipoint:_scrollimagelist];
    [q2i setServeroption:serveroption];
    [q2i setRiv:[_drawingboard riv]];
    [querydraw addObject:q2i];
    [tV setQ2ipoint:q2i];
    [q2i setDraworder:g_draworder];
    g_draworder ++;
    
    //设置刚插入为最高优先级
    //设置底部备选图片
    [[tV buttomimagelist] setDataSource:[[tV q2ipoint] imagesource]];
    //[[tV buttomimagelist] reloadData];
    [_scrollimagelist setDataSource:[q2i imagesource]];
    [_scrollimagelist reloadData];
    [_scrollimagelist setQ2ipoint:q2i];
    [q2i setSelectflag:1];
    
    [[tV edittext] setHidden:NO];
    [[tV edittext] setStringValue:inputq];
    [tV setSelectflag:1];
    //[tV selectflag] = 1;
    //bring front drawsketch

    if([tV parentcollection] != nil)
    {
        for(int i = 0;i < [[[tV parentcollection] subviews] count];i ++)
        {
            NSString * classname = NSStringFromClass([[[[tV parentcollection] subviews]objectAtIndex:i] class]);
            // NSLog(@"%@", classname);
            if([classname isEqualToString:@"thumbnailView"])
            {
                thumbnailView * tv = (thumbnailView *)[[[tV parentcollection] subviews] objectAtIndex:i];
                if(tv == tV)
                {
                    //NSLog(@"current selected item %d", i);
                }
                else
                {
                    [tv setSelectflag:0];
                    [[tv edittext]setHidden:YES];
                    
                }
                [tv setNeedsDisplay:YES];
            }
            
            
        }
    }
    ////////
    colorind = (colorind + 1) % [colorset count];
  /*  drawSketch *dS = [[drawSketch alloc]initWithFrame:NSMakeRect(100, 100, 100, 100)];
   // [_window contentView addSubview:dS];
    [[_window contentView] addSubview:dS];*/
    
    
    //[self.window.contentView addSubview:dS];
}

- (IBAction)debug:(id)sender {
   
    //////////测试透明文件生成
  /*  NSString * imagename = @"/var/folders/vn/3_kk6lms28x0032c_v_z721h0000gn/T/123456/filename.jpg";
    NSString * imagedpi72=@"/var/folders/vn/3_kk6lms28x0032c_v_z721h0000gn/T/123456/dpi72.jpg";
    NSString * grayname =  @"/var/folders/vn/3_kk6lms28x0032c_v_z721h0000gn/T/123456/grayname.jpg";
    NSString * logname = @"/var/folders/vn/3_kk6lms28x0032c_v_z721h0000gn/T/123456/logname.jpg";
    NSString * transparentname = @"/var/folders/vn/3_kk6lms28x0032c_v_z721h0000gn/T/123456/transparentname.jpg";
    NSString * strokename = @"/var/folders/vn/3_kk6lms28x0032c_v_z721h0000gn/T/123456/strokename.jpg";
    NSString * transparenttemp = @"/var/folders/vn/3_kk6lms28x0032c_v_z721h0000gn/T/123456/transparenttemp.jpg";
       NSString * resizename = @"/var/folders/vn/3_kk6lms28x0032c_v_z721h0000gn/T/123456/resizename.jpg";
    
    NSString * orgsizelogname = @"/var/folders/vn/3_kk6lms28x0032c_v_z721h0000gn/T/123456/orgsizelogname.jpg";
    
    NSImage * image =[[NSImage alloc]initWithContentsOfFile:imagename];

    [imagetrans convertDPI72:imagename outimage:imagedpi72];
    NSImage * image72 = [[NSImage alloc]initWithContentsOfFile:imagedpi72];
    [imagetrans resizeimage:imagedpi72 outimage:resizename newsize:NSMakeSize(400, 300)];
    [imagetrans imagecut:resizename outfile:grayname logfile:logname];
    [imagetrans gray2stroke:logname strokename:strokename];
    
    [imagetrans resizeimage:logname outimage:orgsizelogname newsize:[image72 size]];
    [imagetrans imagesketch:orgsizelogname orgimage:imagedpi72 outimage:transparenttemp];
    //[imagetrans imagesketch:logname orgimage:resizename outimage:transparenttemp];
    [imagetrans cutalpha:transparenttemp outimage:transparentname];*/
    /////////////////测试结束
    
    NSLog(@"%f %f", [_bgeindrawingboard frame].size.width, [_bgeindrawingboard frame].size.height);
    [_resultimage setNeedsDisplay:YES];
    [[resultdetailView resultimage] setNeedsDisplay: YES];
    [[_drawingboard riv]setNeedsDisplay:YES];

}//debug end

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
    int c = 0;
    while (YES) {
        [NSThread sleepForTimeInterval:0.1];
        [lock lock];
        query2image * q2i = nil;
        imageitem * imaget = nil;
        if([querydraw count] != 0)
        {
            c = c + 1;
            c = c % [querydraw count];
            
            q2i = [querydraw objectAtIndex:c];
            imaget = [q2i getdownimageitem];
            [imaget setDownflag:2];
        }
        
        /*for(int i = 0 ; i < [querydraw count]; i ++)
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
        }*/
        if(imaget != nil)
        {
            NSString * imagename = [imaget filename];
            NSString * grayname = [imaget grayname];
            NSString * logname = [imaget logname];
            NSString * transparentname = [imaget transparentname];
            NSString * strokename = [imaget strokename];
            NSString * image72name = [NSTemporaryDirectory()  stringByAppendingPathComponent:[self getrandstr]];
            [imagetrans convertDPI72:imagename outimage:image72name];
            
            NSString * transparenttemp = [NSTemporaryDirectory()  stringByAppendingPathComponent:[self getrandstr]];
            NSImage * image =[[NSImage alloc]initWithContentsOfFile:imagename];
            NSImage * image72 = [[NSImage alloc]initWithContentsOfFile:image72name];
            NSString * resizename = [NSTemporaryDirectory()  stringByAppendingPathComponent:[self getrandstr]];
            [imagetrans resizeimage:image72name outimage:resizename newsize:NSMakeSize(400, 300)];
            [imagetrans imagecut:resizename outfile:grayname logfile:logname];
            [imagetrans gray2stroke:logname strokename:strokename];
            NSString * orgsizelogname = [NSTemporaryDirectory()  stringByAppendingPathComponent:[self getrandstr]];
            [imagetrans resizeimage:logname outimage:orgsizelogname newsize:[image72 size]];
            [imagetrans imagesketch:orgsizelogname orgimage:imagename outimage:transparenttemp];
            //[imagetrans imagesketch:logname orgimage:resizename outimage:transparenttemp];
            [imagetrans cutalpha:transparenttemp outimage:transparentname];
            if([imaget myiobjectpoint] != nil)
            {
                [[imaget myiobjectpoint] changevalue:@"2" index:0];
                [q2i statimagescore:imaget];
                dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                    //Background Thread
                    dispatch_async(dispatch_get_main_queue(), ^(void){
                        //Run UI Updates
                        [_scrollimagelist setNeedsDisplay:YES];
                    });
                });
            }
            
        }
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
- (IBAction)extend:(id)sender {
    NSLog(@"click extend button");
    [[_scrollimagelist q2ipoint] resetbestimagescore];
}
- (IBAction)showindex:(id)sender {
    NSIndexSet * indexset = [_scrollimagelist visibleItemIndexes];
    NSUInteger ind;
    for(ind = [indexset firstIndex]; ind != NSNotFound; ind = [indexset indexGreaterThanIndex:ind])
    {
        NSLog(@"%ld", ind);
    }
}

- (IBAction)scrollposition:(id)sender {
    [[mattview allview]setHidden:NO];
    [[mattview allview] setNeedsDisplay:YES];
    //[_bigsizeimage setHidden:YES];
    //[_scrollimagelist scrollIndexToVisible:3];
}

- (IBAction)opendetail:(id)sender {
    [_drawingboard setHidden:NO];
   // [[resultdetailView allview]setHidden:NO];
}

- (IBAction)closedetail:(id)sender {
    [_drawingboard setHidden:YES];
   // [[resultdetailView allview]setHidden:YES];
}
- (IBAction)zoomin:(id)sender {
    if (curzoomFactor < 1.0001)
    {
        NSRect bsinnerindrawingboardframe = [_bsinnerindrawingboard frame];
        bsinnerindrawingboardframe.size.width /= zoomFactor;
        bsinnerindrawingboardframe.size.height /= zoomFactor;
        bsinnerindrawingboardframe.origin.x = ([_bsindrawingboard frame].size.width - bsinnerindrawingboardframe.size.width) / 2;
        bsinnerindrawingboardframe.origin.y = ([_bsindrawingboard frame].size.height - bsinnerindrawingboardframe.size.height) / 2;
        [_bsinnerindrawingboard scaleUnitSquareToSize:NSMakeSize(1/zoomFactor, 1/zoomFactor)];
        [_bsinnerindrawingboard setFrame:bsinnerindrawingboardframe];
        [_drawingboard setNeedsDisplay:YES];
    }
    else
    {
        NSRect visible = [_drawingboard documentVisibleRect];
        NSRect newrect = NSOffsetRect(visible, -NSWidth(visible)*(zoomFactor - 1)/2.0, -NSHeight(visible)*(zoomFactor - 1)/2.0);
        
        NSRect frame = [_drawingboard.documentView frame];
        [_drawingboard.documentView scaleUnitSquareToSize:NSMakeSize(1/zoomFactor, 1/zoomFactor)];
        
        
        
        [_drawingboard.documentView setFrame:NSMakeRect(0, 0, frame.size.width / zoomFactor, frame.size.height / zoomFactor)];
       
        
        [[_drawingboard documentView] scrollPoint:newrect.origin];
    }
    curzoomFactor /= zoomFactor;
}

- (IBAction)zoomout:(id)sender {
    if (curzoomFactor < 1.0001)
    {
        NSRect bsinnerindrawingboardframe = [_bsinnerindrawingboard frame];
        bsinnerindrawingboardframe.size.width *= zoomFactor;
        bsinnerindrawingboardframe.size.height *= zoomFactor;
        bsinnerindrawingboardframe.origin.x = ([_bsindrawingboard frame].size.width - bsinnerindrawingboardframe.size.width) / 2;
        bsinnerindrawingboardframe.origin.y = ([_bsindrawingboard frame].size.height - bsinnerindrawingboardframe.size.height) / 2;
        [_bsinnerindrawingboard scaleUnitSquareToSize:NSMakeSize(zoomFactor, zoomFactor)];
        [_bsinnerindrawingboard setFrame:bsinnerindrawingboardframe];
        [_drawingboard setNeedsDisplay:YES];
    }
    else
    {
        NSRect visible = [_drawingboard documentVisibleRect];
        NSRect newrect = NSInsetRect(visible, NSWidth(visible)*(1 - 1/zoomFactor)/2.0, NSHeight(visible)*(1 - 1/zoomFactor)/2.0);
        NSRect frame = [[_drawingboard documentView] frame];
        [_drawingboard.documentView scaleUnitSquareToSize:NSMakeSize(zoomFactor, zoomFactor)];
        [_drawingboard.documentView setFrame:NSMakeRect(0, 0, frame.size.width * zoomFactor, frame.size.height * zoomFactor)];
        
        [[_drawingboard documentView] scrollPoint:newrect.origin];
    }
    curzoomFactor /= zoomFactor;


}

- (IBAction)block:(id)sender {
    [_drawingboard forcebestimage];
}
- (IBAction)eriveditenable:(id)sender {
    bool display = [_dscindrawingboard isHidden];
    [_dscindrawingboard setHidden:!display];
}

- (IBAction)upimage:(id)sender {
    if([[_drawingboard eirv] q2i] == nil )
    {
        return;
    }
    for(int i = 0 ;i<[querydraw count]; i ++)
    {
        if([[_drawingboard eirv] q2i] == [querydraw objectAtIndex:i])
        {
            if(i < [querydraw count] - 1)
            {
                [querydraw exchangeObjectAtIndex:i withObjectAtIndex:i+1];
                NSLog(@"click %@", [[[_drawingboard eirv] q2i] query]);
                break;
            }
        }
    }
}

- (IBAction)downimage:(id)sender {
    if([[_drawingboard eirv] q2i] == nil )
    {
        return;
    }
    for(int i = 0 ;i<[querydraw count]; i ++)
    {
        if([[_drawingboard eirv] q2i] == [querydraw objectAtIndex:i])
        {
            if(i != 0 )
            {
                [querydraw exchangeObjectAtIndex:i withObjectAtIndex:i-1];
                NSLog(@"click %@", [[[_drawingboard eirv] q2i] query]);
                break;
            }
        }
    }
}

- (IBAction)flipx:(id)sender {
    if([[_drawingboard eirv] q2i] == nil )
    {
        return;
    }
    [[[_drawingboard eirv] q2i] setFlipx:1-[[[_drawingboard eirv] q2i]flipx]];
    [[_drawingboard eirv] setNeedsDisplay:YES];
}

- (IBAction)flipy:(id)sender {
    if([[_drawingboard eirv] q2i] == nil )
    {
        return;
    }
    [[[_drawingboard eirv] q2i] setFlipy:1-[[[_drawingboard eirv] q2i]flipy]];
    [[_drawingboard eirv] setNeedsDisplay:YES];
}
- (IBAction)modifycontrast:(id)sender {
    [_eirvindrawingboard setBCS:[_showcontrast floatValue] BCS:IMGTcontrast];
}
- (IBAction)modifysaturation:(id)sender {
    [_eirvindrawingboard setBCS:[_showsaturation floatValue] BCS:IMGTsaturation];
}
- (IBAction)modifybrightness:(id)sender {
    [_eirvindrawingboard setBCS:[_showbrightness floatValue] BCS:IMGTbrightness];
}
- (IBAction)backgroundedit:(id)sender {
    [[_drawingboard bge] setEditflag:1 - [[_drawingboard bge]editflag] ];
    bool display = [[_drawingboard eirv] isHidden];
    [[_drawingboard eirv] setHidden:!display];
    [_drawingboard setNeedsDisplay:YES];
    
}

- (IBAction)openPreferences:(id)sender {
    
    /*
     mattview = [[mattviewController alloc]init];
     bool ret = [[NSBundle mainBundle] loadNibNamed:@"mattviewController" owner:mattview topLevelObjects:nil];
     NSLog(@"load mattviewController %d", ret);
     [mattview viewDidLoad];
     mattwindow = [[mattwindowcontroller alloc]init];
    
    ret = [[NSBundle mainBundle]loadNibNamed:@"mattwindowcontroller" owner:mattwindow topLevelObjects:nil];
    NSLog(@"load mattwindowController %d", ret);
    [mattview addimage:[it filename] strokename:[it strokename] transparentname:[it transparentname]];
    [[[mattwindow window] contentView] addSubview:[mattview allview]];
    */
    preferencesview = [[preferencesView alloc]init];
    bool ret = [[NSBundle mainBundle] loadNibNamed:@"preferencesView" owner:preferencesview topLevelObjects:nil];
    NSLog(@"preferencesview load %d", ret);

    [preferencesview setServeroption:serveroption];
    [preferencesview viewDidLoad];
    

    preferenceswindow = [[preferencesWindow alloc]init];
    ret = [[NSBundle mainBundle]loadNibNamed:@"preferencesWindow" owner:preferenceswindow topLevelObjects:nil];
    [[[preferenceswindow window] contentView] addSubview:[preferencesview view]];
    NSLog(@"preferencesview load %d", ret);
}
@end
