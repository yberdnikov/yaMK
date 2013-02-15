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
#import "IncomeBar.h"
#import "BalanceBar.h"

@implementation PlotDiagramController

-(IBAction)plotPieChartOutcome:(id)sender {
    [self clearView];
    [_plotView setPlotter:[[PieChartPlotter alloc] init]];
    [[_plotView plotter] setDataSource:[[PieChartOutcomeAccounts alloc] init]];
    [self redrawView:sender];
}

-(IBAction)plotPieChartIncome:(id)sender{
    [self clearView];
    [_plotView setPlotter:[[PieChartPlotter alloc] init]];
    [[_plotView plotter] setDataSource:[[PieChartIncomeAccounts alloc] init]];
    [self redrawView:sender];
}

-(IBAction)plotPieChartBalance:(id)sender{
    [self clearView];
    [_plotView setPlotter:[[PieChartPlotter alloc] init]];
    [[_plotView plotter] setDataSource:[[PieChartBalanceAccounts alloc] init]];
    [self redrawView:sender];
}

-(IBAction)plotBarChartIncomeOutcome:(id)sender {
    [self clearView];
    [_plotView setPlotter:[[BarChartGroupPlotter alloc] init]];
    [[_plotView plotter] setDataSource:[[IncomeOutcomeBar alloc] init]];
   [self redrawView:sender];
}

-(IBAction)plotBarChartOutcome:(id)sender {
    [self clearView];
    [_plotView setPlotter:[[BarChartPlotter alloc] init]];
    [[_plotView plotter] setDataSource:[[OutcomeBar alloc] init]];
    [self redrawView:sender];
}

-(IBAction)plotBarChartIncome:(id)sender {
    [self clearView];
    [_plotView setPlotter:[[BarChartPlotter alloc] init]];
    [[_plotView plotter] setDataSource:[[IncomeBar alloc] init]];
    [self redrawView:sender];
}

-(IBAction)plotBarChartBalance:(id)sender {
    [self clearView];
    [_plotView setPlotter:[[BarChartPlotter alloc] init]];
    [[_plotView plotter] setDataSource:[[BalanceBar alloc] init]];
    [self redrawView:sender];
}

-(void)clearView {
    for (NSTrackingArea *trackingArea in [[_plotView plotter] trackingAreas]) {
        [_plotView removeTrackingArea:trackingArea];
    }
}

-(void)redrawView:(id)sender {
    [[_plotView plotter] setFont:[NSFont fontWithName:@"Times" size:14]];
    [[_plotView plotter] setPlotView:_plotView];
    [_plotPanel makeKeyAndOrderFront:sender];
    [_plotPanel display];
}

@end
