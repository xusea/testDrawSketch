//
//  scrollimagedelegate.m
//  testDrawSketch
//
//  Created by xusea on 16/6/16.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import "scrollimagedelegate.h"

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
    return visiblerange;
}
- (void)imageBrowserSelectionDidChange:(IKImageBrowserView *)aBrowser
{
    /* NSLog(@"holy fuck");
     NSIndexSet * ind = [aBrowser selectionIndexes];
     //ind = [imagebrowsertemplet selectionIndexes];
     int a = (int)[ind firstIndex];
     if(a>=0 || a<[scrollimages count])
     {
     NSLog(@"ffffont name :%@ ",[[fontArray objectAtIndex:a] fontname]);
     [tv settextfontname:[[fontArray objectAtIndex:a] fontname]];
     //[tv setdisplayfont:[NSFont fontWithName:[[fontArray objectAtIndex:a] fontname] size:15.0]];
     }
     else
     {
     NSLog(@"out of bound");
     }
     */
}
@end
