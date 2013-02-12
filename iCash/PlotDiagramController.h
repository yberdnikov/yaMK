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
@property IBOutlet NSPanel *plotPanel;
@property Plotter *currentPlotter;

-(IBAction)plotPieChartOutcome:(id)sender;
-(IBAction)plotPieChartIncome:(id)sender;
-(IBAction)plotPieChartBalance:(id)sender;

-(IBAction)plotBarChartIncomeOutcome:(id)sender;
-(IBAction)plotBarChartOutcome:(id)sender;

@end
