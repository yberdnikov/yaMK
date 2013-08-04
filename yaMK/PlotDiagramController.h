//
//  PlotDiagramController.h
//  iCash
//
//  Created by Vitaly Merenkov on 12.01.13.

//

#import <Foundation/Foundation.h>
#import "PlotView.h"
#import "Plotter.h"

@interface PlotDiagramController : NSObject

@property IBOutlet PlotView *plotView;
@property IBOutlet NSScrollView *scrollView;
@property IBOutlet NSPanel *plotPanel;
@property (strong, retain) Plotter *currentPlotter;

-(IBAction)plotPieChartExpense:(id)sender;
-(IBAction)plotPieChartIncome:(id)sender;
-(IBAction)plotPieChartBalance:(id)sender;

-(IBAction)plotBarChartIncomeExpense:(id)sender;
-(IBAction)plotBarChartExpense:(id)sender;
-(IBAction)plotBarChartIncome:(id)sender;
-(IBAction)plotBarChartBalance:(id)sender;

@end
