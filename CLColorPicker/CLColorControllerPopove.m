//
//  CLColorControllerPopove.m
//  CircumLunar
//
//  Created by Volodymyr Boichentsov on 29/03/2015.
//  Copyright (c) 2015 Volodymyr Boichentsov. All rights reserved.
//

#import "CLColorControllerPopove.h"
#import "NSColor+ColorExtensions.h"

@interface CLColorControllerPopove ()

@end

@implementation CLColorControllerPopove


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    NSArray *colors = @[
                        @[[NSColor colorWithIntegerRed:100 green:178 blue:233 alpha:255],
                          [NSColor colorWithIntegerRed:73 green:155 blue:201 alpha:255],
                          [NSColor colorWithIntegerRed:53 green:124 blue:163 alpha:255],
                          [NSColor colorWithIntegerRed:23 green:87 blue:120 alpha:255],
                          [NSColor whiteColor]],
                        
                        @[[NSColor colorWithIntegerRed:156 green:226 blue:90 alpha:255],
                          [NSColor colorWithIntegerRed:110 green:193 blue:56 alpha:255],
                          [NSColor colorWithIntegerRed:122 green:174 blue:61 alpha:255],
                          [NSColor colorWithIntegerRed:87 green:135 blue:38 alpha:255],
                          [NSColor lightGrayColor]],
                        
                        @[[NSColor colorWithIntegerRed:255 green:224 blue:97 alpha:255],
                          [NSColor colorWithIntegerRed:241 green:208 blue:48 alpha:255],
                          [NSColor colorWithIntegerRed:226 green:184 blue:1 alpha:255],
                          [NSColor colorWithIntegerRed:198 green:147 blue:0 alpha:255],
                          [NSColor grayColor]],
                        
                        @[[NSColor colorWithIntegerRed:255 green:192 blue:114 alpha:255],
                          [NSColor colorWithIntegerRed:255 green:170 blue:58 alpha:255],
                          [NSColor colorWithIntegerRed:237 green:159 blue:46 alpha:255],
                          [NSColor colorWithIntegerRed:210 green:127 blue:21 alpha:255],
                          [NSColor darkGrayColor]],
                        
                        @[[NSColor colorWithIntegerRed:255 green:96 blue:94 alpha:255],
                          [NSColor colorWithIntegerRed:255 green:45 blue:33 alpha:255],
                          [NSColor colorWithIntegerRed:206 green:35 blue:43 alpha:255],
                          [NSColor colorWithIntegerRed:174 green:25 blue:21 alpha:255],
                          [NSColor blackColor]],
                        
                        @[[NSColor colorWithIntegerRed:157 green:68 blue:184 alpha:255],
                          [NSColor colorWithIntegerRed:108 green:33 blue:133 alpha:255],
                          [NSColor colorWithIntegerRed:85 green:20 blue:108 alpha:255],
                          [NSColor colorWithIntegerRed:60 green:10 blue:73 alpha:255]
                          ]
                        
                        ];
    
    CGFloat x = 2;
    for (NSArray *sub in colors) {
        CGFloat y = 2;
        for (NSColor *color in sub) {
            NSButton *b = [self buttonWithColor:color
                                          frame:NSMakeRect(x, y, 40, 20)];
            [self.view addSubview:b];
            y += 22;
        }
        x += 42;
    }
}

- (NSButton*) buttonWithColor:(NSColor*)color frame:(NSRect)frame {
    NSButton *button = [[NSButton alloc] initWithFrame:frame];
    [[button cell] setBackgroundColor:color];
    [button setTitle:@""];
    [button setBordered:NO];
    [button setTarget:self];
    [button setAction:@selector(selectColor:)];
    return button;
}

- (void) selectColor:(NSButton*)b {
    if ([_target respondsToSelector:_selector]) {
        [_target performSelector:_selector withObject:[[b cell] backgroundColor]];
    }
}


@end

@implementation CLColorControllerView
- (BOOL) isFlipped {
    return YES;
}
@end