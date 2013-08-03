//
//  PlotWindowToolbarController.h
//  iCash
//
//  Created by Vitaly Merenkov on 11.03.13.

//

#import <Foundation/Foundation.h>

@class PlotView;

@interface PlotWindowToolbarController : NSObject

@property (strong) IBOutlet NSPanel *filterPanel;
@property (strong) IBOutlet NSWindow *plotWindow;
@property (weak) IBOutlet PlotView *plotView;
@property NSDate *fromDate;
@property NSDate *toDate;

-(IBAction)openFilterDialog:(id)sender;
-(IBAction)applyFilter:(id)sender;

@end
