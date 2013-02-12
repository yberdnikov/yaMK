//
//  PlotDiagramController.m
//  iCash
//
//  Created by Vitaly Merenkov on 12.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "PlotDiagramController.h"
#import "PieChartPlotter.h"
#import "BarChartPlotter.h"
#import "PieChartOutcomeAccounts.h"
#import "PieChartIncomeAccounts.h"
#import "PieChartBalanceAccounts.h"
#import "IncomeOutcomeBar.h"
#import "DataSourceContainer.h"
#import "BarChartGroupPlotter.h"
#import "OutcomeBar.h"

@implementation PlotDiagramController

-(IBAction)plotPieChartOutcome:(id)sender {
    Plotter *plotter = [[PieChartPlotter alloc] init];
    [plotter setDataSource:[[PieChartOutcomeAccounts alloc] init]];
    [_plotView setPlotter:plotter];
    [_plotPanel makeKeyAndOrderFront:sender];
    [_plotPanel display];
}

-(IBAction)plotPieChartIncome:(id)sender{
    Plotter *plotter = [[PieChartPlotter alloc] init];
    [plotter setDataSource:[[PieChartIncomeAccounts alloc] init]];
    [_plotView setPlotter:plotter];
    [_plotPanel makeKeyAndOrderFront:sender];
    [_plotPanel display];
}

-(IBAction)plotPieChartBalance:(id)sender{
    Plotter *plotter = [[PieChartPlotter alloc] init];
    [plotter setDataSource:[[PieChartBalanceAccounts alloc] init]];
    [_plotView setPlotter:plotter];
    [_plotPanel makeKeyAndOrderFront:sender];
    [_plotPanel display];
}

-(IBAction)plotBarChartIncomeOutcome:(id)sender {
    Plotter *plotter = [[BarChartGroupPlotter alloc] init];
    [plotter setDataSource:[[IncomeOutcomeBar alloc] init]];
    [plotter setFont:[NSFont fontWithName:@"Times" size:14]];
    [plotter setPlotView:_plotView];
    [_plotView setPlotter:plotter];
    [_plotPanel makeKeyAndOrderFront:sender];
    [_plotPanel display];
}

-(IBAction)plotBarChartOutcome:(id)sender {
    Plotter *plotter = [[BarChartPlotter alloc] init];
    [plotter setDataSource:[[OutcomeBar alloc] init]];
    [plotter setFont:[NSFont fontWithName:@"Times" size:14]];
    [plotter setPlotView:_plotView];
    [self setCurrentPlotter:plotter];
    [_plotView setPlotter:plotter];
    [_plotPanel makeKeyAndOrderFront:sender];
    [_plotPanel display];
}

@end
