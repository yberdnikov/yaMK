//
//  PlotWindowToolbarController.m
//  iCash
//
//  Created by Vitaly Merenkov on 11.03.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "PlotWindowToolbarController.h"
#import "PlotView.h"
#import "Plotter.h"

@implementation PlotWindowToolbarController

-(PlotWindowToolbarController *)init {
    self = [super init];
    [self setToDate:[NSDate date]];
    NSDateComponents *yearComp = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:_toDate];
    [self setFromDate:[[NSCalendar currentCalendar] dateFromComponents:yearComp]];
    return self;
}

-(IBAction)openFilterDialog:(id)sender {
    [NSApp beginSheet:_filterPanel modalForWindow:_plotWindow modalDelegate:self didEndSelector:nil contextInfo:nil];
}

-(IBAction)applyFilter:(id)sender {
    NSPredicate *fromDateP = [NSPredicate predicateWithFormat:@"date >= %@" argumentArray:[NSArray arrayWithObject:_fromDate]];
    NSPredicate *toDateP = [NSPredicate predicateWithFormat:@"date < %@" argumentArray:[NSArray arrayWithObject:_toDate]];
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:fromDateP, toDateP, nil]];
    [[_plotView plotter] setFilters:predicate];
    [[[_plotView plotter] dataSource] setRecalculate:YES];
    [_plotView setNeedsDisplay:YES];
    
    [_filterPanel orderOut:nil];
    [NSApp endSheet:_filterPanel];
}

@end
