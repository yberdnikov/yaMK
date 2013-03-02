//
//  ScrollPlotView.m
//  iCash
//
//  Created by Vitaly Merenkov on 02.03.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "ScrollPlotView.h"
#import "PlotView.h"
#import "Plotter.h"

@implementation ScrollPlotView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)viewDidEndLiveResize {
    NSRect rect = [self bounds];
    rect.size = [self contentSize];
    [_plotView setFrame:[[_plotView plotter] getMinSize:rect]];
}

@end
