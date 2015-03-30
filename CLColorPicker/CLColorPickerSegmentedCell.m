//
//  CLColorPickerSegmentedCell.m
//  CircumLunar
//
//  Created by Volodymyr Boichentsov on 18/03/2015.
//  Copyright (c) 2015 Volodymyr Boichentsov. All rights reserved.
//

#import "CLColorPickerSegmentedCell.h"
#import "CLColorPickerSegmentedControl.h"
#import "NSColor+ColorExtensions.h"

@interface CLColorPickerSegmentedCell ()
@property (nonatomic) NSInteger higlightedSegment;
@property (nonatomic) NSInteger saved_higlightedSegment;

@property (nonatomic, strong) NSTrackingArea *trackArea;
@property BOOL mouseInside;
@property (nonatomic, weak) NSView *cView;
@end


@implementation CLColorPickerSegmentedCell

- (id) initWithCoder:(NSCoder *)aDecoder {
    CLColorPickerSegmentedCell *cell = [super initWithCoder:aDecoder];
    cell.higlightedSegment = -1;
    return cell;
}

- (void)setTrackingMode:(NSSegmentSwitchTracking)trackingMode {
    [super setTrackingMode:NSSegmentSwitchTrackingMomentary];
}


- (BOOL)startTrackingAt:(NSPoint)startPoint inView:(NSView *)controlView {
    [self _identifyHighlightedSegment:startPoint start:YES];
    _saved_higlightedSegment = _higlightedSegment;
    return [super startTrackingAt:startPoint inView:controlView];
}

- (void)stopTracking:(NSPoint)lastPoint at:(NSPoint)stopPoint inView:(NSView *)controlView mouseIsUp:(BOOL)flag {
    _higlightedSegment = -1;
    _saved_higlightedSegment = -1;
    [super stopTracking:lastPoint at:stopPoint inView:controlView mouseIsUp:flag];
}

- (BOOL)continueTracking:(NSPoint)lastPoint at:(NSPoint)currentPoint inView:(NSView *)controlView {
    NSInteger oldSegment = _higlightedSegment;
    [self _identifyHighlightedSegment:currentPoint start:NO];
    NSInteger newSegment = _higlightedSegment;
    if (oldSegment != newSegment) {
        [controlView setNeedsDisplay:YES];
    }
    return [super continueTracking:lastPoint at:currentPoint inView:controlView];
}

- (void) _identifyHighlightedSegment:(NSPoint)point start:(BOOL)start{
    CGFloat delta = 0;
    for (NSInteger i = 0; i < self.segmentCount; i++) {
        CGFloat width = [self widthForSegment:i];
        if (CGRectContainsPoint(CGRectMake(delta, 0, width, 25), point)) {
            _higlightedSegment = i;
            break;
        }
        delta += width;
    }
    if (_higlightedSegment != _saved_higlightedSegment && !start) {
        _higlightedSegment = -1;
    }
}

- (void) mouseEntered:(NSEvent*)theEvent {
    // Mouse entered tracking area.
    if (!_mouseInside) {
        _mouseInside = YES;
        [_cView setNeedsDisplay:YES];
    }
}

- (void) mouseExited:(NSEvent*)theEvent {
    // Mouse exited tracking area.
    if (_mouseInside) {
        _mouseInside = NO;
        [_cView setNeedsDisplay:YES];
    }
}


- (void)drawSegment:(NSInteger)segment inFrame:(NSRect)frame withView:(NSView *)controlView {

    if (!_trackArea && segment == 0) {
        _cView = controlView;
        NSTrackingAreaOptions options = NSTrackingEnabledDuringMouseDrag | NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways;
        NSTrackingArea *area = [[NSTrackingArea alloc] initWithRect:frame options:options owner:self userInfo:nil];
        [controlView addTrackingArea:area];
    }
    
    NSGraphicsContext* ctx = [NSGraphicsContext currentContext];
    [ctx saveGraphicsState];
    if (segment == 0) {
        
//        CGContextClearRect(ctx.CGContext, frame);
        frame.origin.x -= 2;
        frame.origin.y += 1.75;
        frame.size.height -= 3.5;
        frame.size.width += 4;
        
        
        CLColorPickerSegmentedControl *control = (CLColorPickerSegmentedControl*)controlView;
        
        CGFloat radius = 5;
        
        NSBezierPath *path = [NSBezierPath bezierPath];
        
        NSRect rect = frame;
        
        [path moveToPoint:NSMakePoint(rect.origin.x+radius, NSMaxY(rect))];
        [path lineToPoint:NSMakePoint(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height)];
        [path lineToPoint:NSMakePoint(rect.origin.x + rect.size.width, rect.origin.y)];
        
//        [path appendBezierPathWithArcWithCenter:NSMakePoint(rect.origin.x + rect.size.width - radius, rect.origin.y + rect.size.height - radius) radius: radius startAngle: 90 endAngle: 0.0f clockwise:YES];
//        [path appendBezierPathWithArcWithCenter:NSMakePoint(rect.origin.x + rect.size.width - radius, rect.origin.y + radius) radius: radius  startAngle:360.0f endAngle: 270 clockwise:YES] ;
        [path appendBezierPathWithArcWithCenter:NSMakePoint(rect.origin.x + radius, rect.origin.y + radius) radius:radius startAngle:270 endAngle: 180 clockwise:YES];
        [path appendBezierPathWithArcWithCenter:NSMakePoint(rect.origin.x + radius, rect.origin.y + rect.size.height - radius) radius:radius startAngle: 180 endAngle: 90 clockwise:YES];
        [path closePath];
        

        [path setLineWidth:0.75];
        [[NSColor colorWithIntegerRed:173 green:173 blue:173 alpha:255] setStroke];
        [control.selectedColor setFill];
        [path fill];
        [path stroke];
        [ctx restoreGraphicsState];
        
        if (_mouseInside) {
            [ctx saveGraphicsState];
            NSBezierPath *circle = [NSBezierPath bezierPathWithRoundedRect:NSMakeRect(29, 5, 13, 13) xRadius:6.5 yRadius:6.5];
            [[NSColor colorWithHex:0x77777777] setFill];
            [circle fill];
            
            NSBezierPath *pathArrow = [NSBezierPath bezierPath];
            [pathArrow moveToPoint:NSMakePoint(31.75, 10)];
            [pathArrow lineToPoint:NSMakePoint(35, 13.5)];
            [pathArrow lineToPoint:NSMakePoint(38.25, 10)];
            [[NSColor whiteColor] setStroke];
            [pathArrow stroke];
            
            [ctx restoreGraphicsState];
        }
        
    } else {
#warning "Don't forget add `colorpicker_icon` to your project"
        NSImage *image = [NSImage imageNamed:@"colorpicker_icon"];
        [image drawInRect:NSMakeRect(48, (24-image.size.height)/2, image.size.width, image.size.height)];
    }

}

@end
