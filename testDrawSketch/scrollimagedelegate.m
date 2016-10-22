//
//  scrollimagedelegate.m
//  testDrawSketch
//
//  Created by xusea on 16/6/16.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import "scrollimagedelegate.h"
#import "scrollBrowserView.h"
#import "query2image.h"
@implementation MyScrollImageObject

@synthesize url;
@synthesize i;
@synthesize fontname;
@synthesize subtitle;
@synthesize title;
- (void)dealloc
{
    //[url release];
    //[super dealloc];
}
#pragma mark - Item data source protocol

- (NSString *)imageRepresentationType
{
    return IKImageBrowserNSImageRepresentationType;;
}

- (id)imageRepresentation
{
    return  self.i;
    //return self.url;
}

- (NSString *)imageUID
{
    return [NSString stringWithFormat:@"%p", self];
}

- (id)imageTitle
{
    return [url lastPathComponent];
}
- (id)imageSubtitle
{
    return subtitle;
}

-(void)changevalue:(NSString *)value index:(int)ind
{
    NSArray * strs = [subtitle componentsSeparatedByString:@"_"];
    NSString * newsubtitle = @"";
    int c = ind + 1;
    if([strs count] > c)
    {
        c = (int)[strs count];
    }
    if(ind !=0)
    {
        if([strs count] != 0)
        {
            newsubtitle = [strs objectAtIndex:0];
        }
        else
        {
            newsubtitle = @"-1";
        }
    }
    else
    {
        newsubtitle = value;
    }
    for(int j = 1;j < c ; j ++)
    {
        if(j == ind)
        {
            newsubtitle = [newsubtitle stringByAppendingString:[NSString stringWithFormat:@"_%@", value]];
        }
        else
        {
            if(j < [strs count])
            {
                newsubtitle = [newsubtitle stringByAppendingString:[NSString stringWithFormat:@"_%@", strs[j]]];
            }
            else
            {
                newsubtitle = [newsubtitle stringByAppendingString:@"_-1.0"];
            }
        }
    }
    subtitle = newsubtitle;
    return;
}
-(NSString *)getvalue:(int)ind
{
    NSArray * strs = [subtitle componentsSeparatedByString:@"_"];
    if(ind < [strs count])
    {
        return [strs objectAtIndex:ind];
    }
    else
    {
        return nil;
    }
}
@end
scrollimagedelegate * g_scrollimagedelegate;
@implementation scrollimagedelegate
@synthesize scrollimages;
@synthesize visiblerange;
- (id) init
{
    if(self = [super init])
    {
        //g_scrollimagedelegate = self;
        scrollimages = [[NSMutableArray alloc] init];
        visiblerange = 0;
       /* MyScrollImageObject * msi = [[MyScrollImageObject alloc]init];
        //[msi setUrl:@"http://111/111.html"];
        NSString * imagename = @"11234";
        NSImage * image =[[NSImage alloc]initWithContentsOfFile:@"/Users/xusea/sketch2photo/101.jpg"];
        [msi setI:image];
        [scrollimages addObject:msi];*/
        //为子类增加属性进行初始化
    }
    return self;
}
- (id)imageBrowser:(IKImageBrowserView *)view itemAtIndex:(NSUInteger)index
{
    return [scrollimages objectAtIndex:index];
}
- (NSUInteger)numberOfItemsInImageBrowser:(IKImageBrowserView *)view
{
    //NSLog(@"call image count %lu ", (unsigned long)[scrollimages count]);
    //return [scrollimages count];
    if([scrollimages count] < 10)
    {
        visiblerange = [scrollimages count];
    }
    return visiblerange;
}
- (void)imageBrowserSelectionDidChange:(IKImageBrowserView *)aBrowser
{
    
    NSIndexSet * ind = [aBrowser selectionIndexes];
    
    scrollBrowserView * sBV = (scrollBrowserView *)aBrowser;
    query2image * q2i = [sBV q2ipoint];
    
    //ind = [imagebrowsertemplet selectionIndexes];
     int a = (int)[ind firstIndex];
     if(a>=0 || a<[[[q2i imagesource] scrollimages] count])
     {
         MyScrollImageObject *mio = [[[q2i imagesource] scrollimages] objectAtIndex:a];
        /* for(int i = 0;i < [[q2i imageitemlist] count]; i ++)
         {
             if(mio == [[[q2i imageitemlist]objectAtIndex:i] myiobjectpoint])
             {
                 [q2i setSelectedimageind:i];
                 
             }
         }*/
         NSLog(@"subtit name :%@ ",[mio subtitle]);
     }
     else
     {
         NSLog(@"out of bound");
     }
    
}
@end
