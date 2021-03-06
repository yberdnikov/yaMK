//
//  PlotDiagramController.m
//  iCash
//
//  Created by Vitaly Merenkov on 12.01.13.

//

#import "PlotDiagramController.h"
#import "PieChartPlotter.h"
#import "BarChartPlotter.h"
#import "PieChartExpenseAccounts.h"
#import "PieChartIncomeAccounts.h"
#import "PieChartBalanceAccounts.h"
#import "IncomeExpenseBar.h"
#import "DataSourceContainer.h"
#import "BarChartGroupPlotter.h"
#import "ExpenseBar.h"
#import "IncomeBar.h"
#import "BalanceBar.h"
#import "Statistics.h"

@implementation PlotDiagramController

-(NSPredicate *)defaultPredicate {
    NSDate *toDate = [NSDate date];
    NSDateComponents *yearComp = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:toDate];
    NSDate *fromDate = [[NSCalendar currentCalendar] dateFromComponents:yearComp];
    return [Statistics predicateByFromDate:fromDate toDate:toDate];
}

-(IBAction)plotPieChartExpense:(id)sender {
    [self clearView];
    [_plotView setPlotter:[[PieChartPlotter alloc] init]];
    [[_plotView plotter] setDataSource:[[PieChartExpenseAccounts alloc] init]];
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

-(IBAction)plotBarChartIncomeExpense:(id)sender {
    [self clearView];
    [_plotView setPlotter:[[BarChartGroupPlotter alloc] init]];
    [[_plotView plotter] setDataSource:[[IncomeExpenseBar alloc] init]];
   [self redrawView:sender];
}

-(IBAction)plotBarChartExpense:(id)sender {
    [self clearView];
    [_plotView setPlotter:[[BarChartPlotter alloc] init]];
    [[_plotView plotter] setDataSource:[[ExpenseBar alloc] init]];
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
    [[_plotView plotter] setScrollView:_scrollView];
    [[_plotView plotter] setFilters:[self defaultPredicate]];
    [_plotPanel makeKeyAndOrderFront:sender];
    [_plotPanel display];
}

@end
