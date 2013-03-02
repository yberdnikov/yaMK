//
//  PlotDiagramController.h
//  iCash
//
//  Created by Vitaly Merenkov on 12.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlotView.h"
#import "Plotter.h"

@interface PlotDiagramController : NSObject

@property IBOutlet PlotView *plotView;
@property IBOutlet NSScrollView *scrollView;
@property IBOutlet NSPanel *plotPanel;
@property (strong, retain) Plotter *currentPlotter;

-(IBAction)plotPieChartOutcome:(id)sender;
-(IBAction)plotPieChartIncome:(id)sender;
-(IBAction)plotPieChartBalance:(id)sender;

-(IBAction)plotBarChartIncomeOutcome:(id)sender;
-(IBAction)plotBarChartOutcome:(id)sender;
-(IBAction)plotBarChartIncome:(id)sender;
-(IBAction)plotBarChartBalance:(id)sender;

@end
