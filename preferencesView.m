//
//  preferencesView.m
//  testDrawSketch
//
//  Created by xusea on 2017/1/12.
//  Copyright © 2017年 xusea. All rights reserved.
//

#import "preferencesView.h"

@interface preferencesView ()

@end

@implementation preferencesView
@synthesize preferencesse;
@synthesize serveroption;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
}

- (IBAction)opense:(id)sender {
    NSLog(@"open se setting");
    if(preferencesse == nil)
    {
        preferencesse = [[preferencesSE alloc]initWithNibName:@"preferencesSE" bundle:nil];
        [preferencesse loadserveroptions:serveroption];
    }
    [[self view] addSubview:[preferencesse view]];
    //[_shellview addSubview:[preferencesse view]];
}
@end
