//
//  ScrollPlotView.h
//  iCash
//
//  Created by Vitaly Merenkov on 02.03.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class PlotView;
@interface ScrollPlotView : NSScrollView

@property IBOutlet PlotView *plotView;

@end
