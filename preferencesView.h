//
//  preferencesView.h
//  testDrawSketch
//
//  Created by xusea on 2017/1/12.
//  Copyright © 2017年 xusea. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "preferencesSE.h"
#import "serverOptions.h"
@interface preferencesView : NSViewController
{
    preferencesSE * preferencesse;
    serverOptions * serveroption;
}
@property preferencesSE * preferencesse;
@property serverOptions * serveroption;
@property (weak) IBOutlet NSButton *sebutton;
- (IBAction)opense:(id)sender;
@property (weak) IBOutlet NSView *shellview;
@end
