//
//  serverOptions.m
//  testDrawSketch
//
//  Created by xusea on 2016/10/25.
//  Copyright © 2016年 xusea. All rights reserved.
//

#import "serverOptions.h"
@implementation seOptions
@synthesize logofile;
@synthesize sename;
@synthesize pattern;
@synthesize depth;
@synthesize check;
@end


@implementation serverOptions
@synthesize selist;
@synthesize sedepth;
-(void)initial
{
    selist = [[NSMutableArray alloc]init];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"serveroptions" ofType:@"plist"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    sedepth =[[dictionary objectForKey:@"sedepth"] intValue];
    NSDictionary *selistdict = [dictionary objectForKey:@"selist"];
    NSArray * keys = [selistdict allKeys];
    for(int i = 0; i< [keys count]; i++)
    {
        NSLog(@"%@", [keys objectAtIndex:i]);
        NSDictionary * values = [selistdict objectForKey:[keys objectAtIndex:i]];
        seOptions *seoptions = [[seOptions alloc]init];
        [seoptions setSename:[values objectForKey:@"sename"]];
        [seoptions setLogofile:[values objectForKey:@"logofile"]];
        [seoptions setPattern:[values objectForKey:@"pattern"]];
        [seoptions setDepth:[[values objectForKey:@"depth"] intValue]];
        [seoptions setCheck:[[values objectForKey:@"check"] intValue]];
        [selist addObject:seoptions];
    }
    filetype = [dictionary objectForKey:@"filetype"];
}
-(BOOL)supporttype:(NSString *) type
{
    BOOL ret = true;
    if([filetype objectForKey:[type lowercaseString]] == nil)
    {
        ret = false;
    }
    return ret;
}
-(void)save
{
    if(selist == nil)
    {
        return;
    }
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"serveroptions" ofType:@"plist"];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    [dictionary setValue:[NSString stringWithFormat:@"%d", sedepth] forKey:@"sedepth"];
    
    
    NSMutableDictionary *tempselistdict = [dictionary objectForKey:@"selist"];
    NSArray * keys = [tempselistdict allKeys];
    for(int i = 0; i< [keys count]; i++)
    {
        NSMutableDictionary * values = [tempselistdict objectForKey:[keys objectAtIndex:i]];
        for(int j = 0;j < [selist count]; j++)
        {
            if([[[selist objectAtIndex:j] sename] isEqualToString:[values objectForKey:@"sename"]])
            {
                [values setValue:[NSString stringWithFormat:@"%d", [[selist objectAtIndex:j] check]] forKey:@"check"];
                break;
            }
        }
    }
    [dictionary writeToFile:plistPath atomically:YES];
}
@end
