//
//  PlotDiagramController.m
//  iCash
//
//  Created by Vitaly Merenkov on 12.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "PlotDiagramController.h"
#import "PieChartPlotter.h"
#import "AllOutcomeAccountsDataSource.h"

@implementation PlotDiagramController

-(IBAction)plotPieChartOutcome:(id)sender {
    NSLog(@"plotPieChartOutcome");
    Plotter *plotter = [[PieChartPlotter alloc] init];
    [plotter setDataSource:[[AllOutcomeAccountsDataSource alloc] init]];
    [_plotView setPlotter:plotter];
    [_plotPanel makeKeyAndOrderFront:sender];
    [_plotPanel display];
}

@end
