//
//  NSColor+ColorExtensions.m
//
//
//  Created by Volodymyr Boichentsov on 23.02.15.
//  Copyright (c) 2015 Volodymyr Boichentsov. All rights reserved.
//

#import "NSColor+ColorExtensions.h"


@implementation NSColor (HexColor)

- (NSString *) hexString {
    const CGFloat *_color = CGColorGetComponents(self.CGColor);
    NSString *hex = [NSString stringWithFormat:@"#%02X%02X%02X", (int)(_color[0]*255.0), (int)(_color[1]*255.0), (int)(_color[2]*255.0)];
    
    return hex;
}

+ (NSColor *) colorWithHex:(int)color {

    float red = (color & 0xff000000) >> 24;
    float green = (color & 0x00ff0000) >> 16;
    float blue = (color & 0x0000ff00) >> 8;
    float alpha = (color & 0x000000ff);
    
    return [NSColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha/255.0];
}

+ (NSColor *) colorWithHexRed:(char)red green:(char)green blue:(char)blue alpha:(char)alpha {
    int x = 0;
    x |= (red & 0xff) << 24;
    x |= (green & 0xff) << 16;
    x |= (blue & 0xff) << 8;
    x |= (alpha & 0xff);
    return [NSColor colorWithHex:x];
}


+ (NSColor *) colorWithHexString:(NSString *)hexString {
	
	/* convert the string into a int */
	unsigned int colorValueR,colorValueG,colorValueB,colorValueA;
	NSString *hexStringCleared = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
	if(hexStringCleared.length == 3) {
		/* short color form */
		/* im lazy, maybe you have a better idea to convert from #fff to #ffffff */
		hexStringCleared = [NSString stringWithFormat:@"%@%@%@%@%@%@", [hexStringCleared substringWithRange:NSMakeRange(0, 1)],[hexStringCleared substringWithRange:NSMakeRange(0, 1)],
												[hexStringCleared substringWithRange:NSMakeRange(1, 1)],[hexStringCleared substringWithRange:NSMakeRange(1, 1)],
												[hexStringCleared substringWithRange:NSMakeRange(2, 1)],[hexStringCleared substringWithRange:NSMakeRange(2, 1)]];
	}
	if(hexStringCleared.length == 6) {
		hexStringCleared = [hexStringCleared stringByAppendingString:@"ff"];
	}
	
	/* im in hurry ;) */
	NSString *red = [hexStringCleared substringWithRange:NSMakeRange(0, 2)];
	NSString *green = [hexStringCleared substringWithRange:NSMakeRange(2, 2)];
	NSString *blue = [hexStringCleared substringWithRange:NSMakeRange(4, 2)];
	NSString *alpha = [hexStringCleared substringWithRange:NSMakeRange(6, 2)];
	
	[[NSScanner scannerWithString:red] scanHexInt:&colorValueR];
	[[NSScanner scannerWithString:green] scanHexInt:&colorValueG];
	[[NSScanner scannerWithString:blue] scanHexInt:&colorValueB];
	[[NSScanner scannerWithString:alpha] scanHexInt:&colorValueA];
	

	return [NSColor colorWithRed:((colorValueR)&0xFF)/255.0 
					green:((colorValueG)&0xFF)/255.0 
					 blue:((colorValueB)&0xFF)/255.0 
					alpha:((colorValueA)&0xFF)/255.0];
	

}

+ (NSColor *) colorWithIntegerRed:(int)red
                            green:(int)green
                             blue:(int)blue
                            alpha:(int)alpha {

    if (alpha > 1 ) {
        alpha = alpha/255.f;
    }
    
    return [NSColor colorWithRed:red/255.f
                           green:green/255.f
                            blue:blue/255.f
                           alpha:alpha];
}


@end




@implementation NSColor (ColorExtensions)

- (NSColor *) lightenColorByValue:(float)value {
    float red = [self redComponent];
    red += value;
    
    float green = [self greenComponent];
    green += value;
    
    float blue = [self blueComponent];
    blue += value;
    
    return [NSColor colorWithCalibratedRed:red green:green blue:blue alpha:1.0f];
}

- (NSColor *) darkenColorByValue:(float)value {
    float red = [self redComponent];
    red -= value;
    
    float green = [self greenComponent];
    green -= value;
    
    float blue = [self blueComponent];
    blue -= value;
    
    return [NSColor colorWithCalibratedRed:red green:green blue:blue alpha:1.0f];
}

- (BOOL) isLightColor {
    NSInteger   totalComponents = [self numberOfComponents];
    bool  isGreyscale     = totalComponents == 2 ? YES : NO;
    
    CGFloat sum;
    
    if (isGreyscale) {
        sum = [self redComponent];
    } else {
        sum = ([self redComponent]+[self greenComponent]+[self blueComponent])/3.0;
    }
    
    return (sum > 0.8);
}

@end
