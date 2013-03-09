//
//  BarChartPlotter.h
//  iCash
//
//  Created by Vitaly Merenkov on 28.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Plotter.h"

@interface BarChartPlotter : Plotter<NSPopoverDelegate>

@property NSMutableArray *details;
@property IBOutlet NSPopover *detailsPopover;

-(void)drawXYAxis:(CGContextRef)context
             rect:(NSRect)rect
           xSpace:(double)xSpace
           ySpace:(double)ySpace;

-(double)findMaxValFromDataSet:(NSArray *)dataSet;

-(NSInteger)maxRoundedVal:(double)maxVal;

-(void)drawMajorLines:(CGContextRef)context
               maxVal:(double)maxVal
                 rect:(NSRect)rect
               xSpace:(double)xSpace
               ySpace:(double)ySpace
            maxHeigth:(double)maxHeight;

- (double)getMinBarWidth;

@end
