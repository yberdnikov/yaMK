//
//  ScrollPlotView.m
//  iCash
//
//  Created by Vitaly Merenkov on 02.03.13.

//

#import "ScrollPlotView.h"
#import "PlotView.h"
#import "Plotter.h"

@implementation ScrollPlotView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    
    return self;
}

-(void)recalcPlotViewSize {
    NSRect rect = [self bounds];
    rect.size = [self contentSize];
    [[_plotView plotter] setFastPlot:NO];
    [_plotView setFrame:[[_plotView plotter] getMinSize:rect]];
    [_plotView setNeedsDisplay:YES];
}

-(void)drawRect:(NSRect)dirtyRect {
    [self recalcPlotViewSize];
}

@end
