//
//  CLColorPicker.h
//  CircumLunar
//
//  Created by Volodymyr Boichentsov on 29/03/2015.
//  Copyright (c) 2015 Volodymyr Boichentsov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CLColorPickerSegmentedControl.h"

@interface CLColorPicker : NSControl

@property (nonatomic, strong) NSColor *selectedColor;

@end
