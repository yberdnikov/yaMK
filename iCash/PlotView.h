//
//  PlotView.h
//  iCash
//
//  Created by Vitaly Merenkov on 12.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Plotter;

@interface PlotView : NSView

@property (strong) Plotter *plotter;
@property IBOutlet NSPopover *details;

@end
