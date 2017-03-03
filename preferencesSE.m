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
    else if([aTableColumn.identifier isEqualToString:@"secheck"])
    {
        return @"";
    }
    return @"";
}
- (NSCell *)tableView:(NSTableView *)tableView dataCellForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    //NSLog(@"image image image");
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
- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    //NSLog(@"fffffff");
    //SimpleData *data = [array objectAtIndex:row];
    if(serveroption == nil || [[serveroption selist] count] == 0)
    {
        return;
    }
    seOptions * se = [[serveroption selist] objectAtIndex:row];
    NSString *identifier = [tableColumn identifier];
    
    if ([identifier isEqualToString:@"secheck"]) {
        YepCheckImageCell *checkCell = cell;
        [checkCell setTitle:@"      "];
        [checkCell setIsChecked:[se check]];
    }
   /* else if ([identifier isEqualToString:@"id"])
    {
        NSTextFieldCell *textCell = cell;
        [textCell setTitle:[data iD]];
    }*/
}

-(void) setCheckItem:(id) data
{
    NSNumber *row = data;
    if(serveroption == nil || [[serveroption selist] count] == 0)
    {
        return;
    }
    seOptions * se = [[serveroption selist] objectAtIndex:[row intValue]];
    [se setCheck:1-[se check]];
    [serveroption save];
    [_setableview setNeedsDisplay:YES];
}
- (NSIndexSet *)tableView:(NSTableView *)tableView selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes
{
    [proposedSelectionIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        NSLog(@"index by %lu", (unsigned long)idx);
        //... do something with idx
        // *stop = YES; to stop iteration early
    }];

    return proposedSelectionIndexes;
}
@end
