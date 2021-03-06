//
//  WindowController.m
//  RdioMini
//
//  Created by Connor Montgomery on 12/2/12.
//  Copyright (c) 2012 Connor Montgomery. All rights reserved.
//

#import "WindowController.h"
#import "INAppStoreWindow.h"

@implementation WindowController

- (void)windowDidLoad
{
    [super windowDidLoad];
    // The class of the window has been set in INAppStoreWindow in Interface Builder
    INAppStoreWindow *aWindow = (INAppStoreWindow*)[self window];
    aWindow.titleBarHeight = 40.0;
    aWindow.trafficLightButtonsLeftMargin = 13.0;
    aWindow.titleBarDrawingBlock = ^(BOOL drawsAsMainWindow, CGRect drawingRect, CGPathRef clippingPath) {
        CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
        CGContextAddPath(ctx, clippingPath);
        CGContextClip(ctx);
        
        NSGradient *gradient = nil;
        if (drawsAsMainWindow) {
            gradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedRed:0 green:0.319 blue:1 alpha:1]
                                                     endingColor:[NSColor colorWithCalibratedRed:0 green:0.627 blue:1 alpha:1]];
            [[NSColor darkGrayColor] setFill];
        } else {
            // set the default non-main window gradient colors
            gradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedWhite:0.851f alpha:1]
                                                     endingColor:[NSColor colorWithCalibratedWhite:0.929f alpha:1]];
            [[NSColor colorWithCalibratedWhite:0.6f alpha:1] setFill];
        }
        [gradient drawInRect:drawingRect angle:90];
        NSRectFill(NSMakeRect(NSMinX(drawingRect), NSMinY(drawingRect), NSWidth(drawingRect), 1));
    };
    
    NSView *titleBarView = aWindow.titleBarView;
    NSSize segmentSize = NSMakeSize(104, 25);
    NSRect segmentFrame = NSMakeRect(NSMidX(titleBarView.bounds) - (segmentSize.width / 2.f),
                                     NSMidY(titleBarView.bounds) - (segmentSize.height / 2.f),
                                     segmentSize.width, segmentSize.height);
    NSSegmentedControl *segment = [[NSSegmentedControl alloc] initWithFrame:segmentFrame];
    [segment setSegmentCount:3];
    [segment setImage:[NSImage imageNamed:NSImageNameIconViewTemplate] forSegment:0];
    [segment setImage:[NSImage imageNamed:NSImageNameListViewTemplate] forSegment:1];
    [segment setImage:[NSImage imageNamed:NSImageNameFlowViewTemplate] forSegment:2];
    [segment setSelectedSegment:0];
    [segment setSegmentStyle:NSSegmentStyleTexturedRounded];
    [titleBarView addSubview:segment];
}

@end
