//
//  ViewController.m
//  CLColorPicker_example
//
//  Created by Volodymyr Boichentsov on 30/03/2015.
//  Copyright (c) 2015 Volodymyr Boichentsov. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_colorControl setSelectedColor:[NSColor purpleColor]];
    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction) bgSelectedColor:(CLColorPicker*)sender {
    NSLog(@"%@", sender.selectedColor);
}

@end
