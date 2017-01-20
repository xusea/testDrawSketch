//
//  preferencesSE.m
//  testDrawSketch
//
//  Created by xusea on 2017/1/12.
//  Copyright © 2017年 xusea. All rights reserved.
//

#import "preferencesSE.h"

@interface preferencesSE ()

@end

@implementation preferencesSE
//@synthesize setableview;
@synthesize serveroption;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_setableview setDataSource:(id<NSTableViewDataSource>)self];
    [_setableview setDelegate:(id<NSTableViewDelegate>)self];
    // Do view setup here.
}
-(void)loadserveroptions:(serverOptions *)serveroptionin
{
    serveroption = serveroptionin;
    //[seView setNeedsDisplay:YES];
}
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    if(serveroption == nil)
    {
        return 0;
    }
    else
    {
        return [[serveroption selist] count];
    }
}
- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    if(serveroption == nil || [[serveroption selist] count] == 0)
    {
        return nil;
    }
    seOptions * se = [[serveroption selist] objectAtIndex:rowIndex];
    if ([[aTableColumn identifier] isEqualToString:@"sename"]) {
        return [se sename];
    }
    else if([aTableColumn.identifier isEqualToString:@"sepattern"])
    {
        return [se pattern];
        //return @"6666" ;
    }
    else if([aTableColumn.identifier isEqualToString:@"selogo"])
    {
        return @"";
    }
    return @"";
}
- (NSCell *)tableView:(NSTableView *)tableView dataCellForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSLog(@"image image image");
    if(serveroption == nil || [[serveroption selist] count] == 0)
    {
        return nil;
    }
    
    if ([tableColumn.identifier isEqualToString:@"selogo"]) {
        seOptions * se = [[serveroption selist] objectAtIndex:row];
        ICImageCell * imc = [[ICImageCell alloc]init];
        imc.myImage = [NSImage imageNamed:[se logofile]];
        //imc.myImage = [[NSImage alloc]initWithContentsOfFile:[se logofile ]];
        return imc;
    }
    return nil;
}

@end
