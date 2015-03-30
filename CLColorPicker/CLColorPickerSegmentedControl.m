//
//  CLColorPickerSegmentedControl.m
//  CircumLunar
//
//  Created by Volodymyr Boichentsov on 18/03/2015.
//  Copyright (c) 2015 Volodymyr Boichentsov. All rights reserved.
//

#import "CLColorPickerSegmentedControl.h"

@implementation CLColorPickerSegmentedControl

- (instancetype)initWithCoder: (NSCoder *)origCoder {
    BOOL sub = YES;
    
    sub = sub && [origCoder isKindOfClass: [NSKeyedUnarchiver class]]; // no support for 10.1 nibs
    sub = sub && ![self isMemberOfClass: [NSControl class]]; // no raw NSControls
    sub = sub && [[self superclass] cellClass] != nil; // need to have something to substitute
    sub = sub && [[self superclass] cellClass] != [[self class] cellClass]; // pointless if same
    
    if( !sub )
    {
        self = [super initWithCoder: origCoder];
    }
    else
    {
        NSKeyedUnarchiver *coder = (id)origCoder;
        
        // gather info about the superclass's cell and save the archiver's old mapping
        Class superCell = [[self superclass] cellClass];
        NSString *oldClassName = NSStringFromClass( superCell );
        Class oldClass = [coder classForClassName: oldClassName];
        if( !oldClass )
            oldClass = superCell;
        
        // override what comes out of the unarchiver
        [coder setClass: [[self class] cellClass] forClassName: oldClassName];
        
        // unarchive
        self = [super initWithCoder: coder];
        
        // set it back
        [coder setClass: oldClass forClassName: oldClassName];
    }
    [self _init];
    return self;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
    CLColorPickerSegmentedControl *c = [super initWithFrame:frameRect];
    [c _init];
    return c;
}

- (void) _init {
    [self setSegmentCount:2];
    [self setWidth:41 forSegment:0];
    [self setWidth:21 forSegment:1];
    [self setFrame:self.frame];
    self.selectedColor = [NSColor blackColor];
}

- (void) setSelectedColor:(NSColor *)selectedColor {
    _selectedColor = selectedColor;
    [self setNeedsDisplay:YES];
}

- (void) setWidth:(CGFloat)width forSegment:(NSInteger)segment {
    [super setWidth:41 forSegment:0];
    [super setWidth:21 forSegment:1];
}


- (void)setSegmentCount:(NSInteger)segmentCount {
    [super setSegmentCount:2];
}

- (void) setSegmentStyle:(NSSegmentStyle)segmentStyle {
    [super setSegmentStyle:NSSegmentStyleRounded];
}


- (void) setFrame:(NSRect)frame {
    frame.size = CGSizeMake(70, 24);
    [super setFrame:frame];
}

+ (Class)cellClass
{
    return [CLColorPickerSegmentedCell class];
}

@end
