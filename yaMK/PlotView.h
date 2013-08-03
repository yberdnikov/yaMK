//
//  PlotView.h
//  iCash
//
//  Created by Vitaly Merenkov on 12.01.13.

//

#import <Cocoa/Cocoa.h>
#import "DetailsViewContainer.h"

@class Plotter;

@interface PlotView : NSClipView

@property (strong) Plotter *plotter;
@property IBOutlet NSPopover *details;
@property DetailsViewContainer *detailsVC;

@end
