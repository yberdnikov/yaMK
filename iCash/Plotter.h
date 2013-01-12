//
//  Plotter.h
//  iCash
//
//  Created by Vitaly Merenkov on 12.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PieChartDatasource.h"

@interface Plotter : NSObject

@property NSObject<PieChartDatasource> *dataSource;

-(void)plot:(NSRect)rect;

@end
