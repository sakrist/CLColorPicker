//
//  CLColorPicker.m
//  CircumLunar
//
//  Created by Volodymyr Boichentsov on 29/03/2015.
//  Copyright (c) 2015 Volodymyr Boichentsov. All rights reserved.
//

#import "CLColorPicker.h"
#import "CLColorControllerPopove.h"

@interface CLColorPicker ()

@property (nonatomic, strong) CLColorPickerSegmentedControl *control;

@property BOOL enableColorChoose;
@property (strong) NSPopover *popover;
@end

@implementation CLColorPicker

- (instancetype) initWithCoder:(NSCoder *)coder {
    CLColorPicker *cp = [super initWithCoder:coder];
    [cp initSegmetedControl];
    return cp;
}

- (instancetype) initWithFrame:(NSRect)frameRect {
    CLColorPicker *cp = [super initWithFrame:frameRect];
    [cp initSegmetedControl];
    return cp;
}

- (void) initSegmetedControl {
    self.control = [[CLColorPickerSegmentedControl alloc] initWithFrame:NSMakeRect(0, 0, 70, 24)];
    [_control setSegmentCount:2];
    [_control setTarget:self];
    [_control setAction:@selector(selectedSegment:)];
    [self addSubview:_control];
}

- (void) setFrame:(NSRect)frame {
    [super setFrame:frame];
    [_control setFrame:NSMakeRect(0, 0, 70, 24)];
}

- (void)selectedSegment:(CLColorPickerSegmentedControl*)sender {
    if (sender.selectedSegment == 0) {
        
        NSColorPanel *cp = [NSColorPanel sharedColorPanel];
        [cp close];
        
        _popover = [[NSPopover alloc] init];
        _popover.behavior = NSPopoverBehaviorTransient;
        [_popover setContentViewController:[self colorPopoverController]];
        [_popover setAnimates:NO];
        [_popover showRelativeToRect:self.bounds ofView:self preferredEdge:NSMinYEdge];
        
    } else {
        _enableColorChoose = !_enableColorChoose;
        [_control setSelected:_enableColorChoose forSegment:1];

        NSColorPanel *cp = [NSColorPanel sharedColorPanel];
        if (_enableColorChoose) {
            [cp setTarget:self];
            [cp setAction:@selector(colorUpdate:)];
            [cp orderFront:nil];
        } else {
            [cp close];
        }
    }
}

- (void) setSelectedColor:(NSColor *)selectedColor {
    _control.selectedColor = selectedColor;
}

- (NSColor*) selectedColor {
    return _control.selectedColor;
}

- (void)colorUpdate:(NSColorPanel*)colorPanel {
    if (_enableColorChoose) {
        _control.selectedColor = colorPanel.color;
    }
}

- (void)colorUpdatePopover:(NSColor*)color {
    _control.selectedColor = color;
    [_popover close];
}

- (NSViewController*) colorPopoverController {
    CLColorControllerPopove *controller = [[CLColorControllerPopove alloc] initWithNibName:@"CLColorControllerPopove" bundle:nil];
    [controller setTarget:self];
    [controller setSelector:@selector(colorUpdatePopover:)];
    return controller;
}


@end
