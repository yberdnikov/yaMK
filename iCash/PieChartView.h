//
//  PieChartView.h
//  iCash
//
//  Created by Vitaly Merenkov on 04.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PieChartDatasource.h"

@interface PieChartView : NSView

@property NSObject<PieChartDatasource> *dataSource;

@end
