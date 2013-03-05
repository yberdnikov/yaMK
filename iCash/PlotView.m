//
//  PlotView.m
//  iCash
//
//  Created by Vitaly Merenkov on 12.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "PlotView.h"
#import "Plotter.h"

@implementation PlotView


-(void)awakeFromNib {
    [self setZoom:1];
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [_plotter plot:[self frame]];
}

- (void)setZoom:(CGFloat)scaleFactor {
    NSRect frame = [self frame];
    NSRect bounds = [self bounds];
    frame.size.width = bounds.size.width * scaleFactor;
    frame.size.height = bounds.size.height * scaleFactor;
    [self setFrameSize: frame.size];    // Change the view's size.
    [self setBoundsSize: frame.size];  // Restore the view's bounds, which causes the view to be scaled.
}

- (void)mouseEntered:(NSEvent *)theEvent {
    NSLog(@"mouseEntered");
}

@end
