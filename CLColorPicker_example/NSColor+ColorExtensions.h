//
//  NSColor+ColorExtensions.h
//  
//
//  Created by Volodymyr Boichentsov on 23.02.15.
//  Copyright (c) 2015 Volodymyr Boichentsov. All rights reserved.
//

#ifndef _CL_NSCOLOR_HEX_COLOR_H__
#define _CL_NSCOLOR_HEX_COLOR_H__


#import <Cocoa/Cocoa.h>


@interface NSColor (HexColor)

- (NSString *) hexString;

/**
 Example:
 int color = 0xffc452ff;
 */
+ (NSColor *) colorWithHex:(int)color;
+ (NSColor *) colorWithHexRed:(char)red green:(char)green blue:(char)blue alpha:(char)alpha;

/**
 Example:
 NSString *color = @"00ffdcff";
 */
+ (NSColor *) colorWithHexString:(NSString *)hexString;

/**
 values should be from 0 to 255
 */
+ (NSColor *) colorWithIntegerRed:(int)red
                            green:(int)green
                             blue:(int)blue
                            alpha:(int)alpha;
@end


@interface NSColor (ColorExtensions)

- (NSColor *) lightenColorByValue:(float)value;
- (NSColor *) darkenColorByValue:(float)value;

- (BOOL) isLightColor;

@end

#endif