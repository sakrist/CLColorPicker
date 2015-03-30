//
//  CLColorPickerSegmentedControl.h
//  CircumLunar
//
//  Created by Volodymyr Boichentsov on 18/03/2015.
//  Copyright (c) 2015 Volodymyr Boichentsov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CLColorPickerSegmentedCell.h"

@interface CLColorPickerSegmentedControl : NSSegmentedControl

@property (nonatomic, strong) NSColor *selectedColor;

@end
