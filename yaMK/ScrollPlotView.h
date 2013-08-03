//
//  ScrollPlotView.h
//  iCash
//
//  Created by Vitaly Merenkov on 02.03.13.

//

#import <Cocoa/Cocoa.h>
@class PlotView;
@interface ScrollPlotView : NSScrollView

@property IBOutlet PlotView *plotView;

@end
