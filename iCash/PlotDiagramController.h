//
//  PlotDiagramController.h
//  iCash
//
//  Created by Vitaly Merenkov on 12.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlotView.h"

@interface PlotDiagramController : NSObject

@property IBOutlet PlotView *plotView;
@property IBOutlet NSPanel *plotPanel;

-(IBAction)plotPieChartOutcome:(id)sender;
-(IBAction)plotPieChartIncome:(id)sender;
-(IBAction)plotPieChartBalance:(id)sender;

@end
