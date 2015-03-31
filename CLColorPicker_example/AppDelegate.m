//
//  AppDelegate.m
//  CLColorPicker_example
//
//  Created by Volodymyr Boichentsov on 30/03/2015.
//  Copyright (c) 2015 Volodymyr Boichentsov. All rights reserved.
//

#import "AppDelegate.h"
#import "CLColorPicker.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (nonatomic, weak) IBOutlet CLColorPicker *colorControl;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [_colorControl setSelectedColor:[NSColor colorWithRed:130.0/255.0 green:80.0/255.0 blue:183.0/255.0 alpha:1]];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction) bgSelectedColor:(CLColorPicker*)sender {
    NSLog(@"%@", sender.selectedColor);
}

@end
