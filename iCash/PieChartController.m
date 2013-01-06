//
//  PieChartController.m
//  iCash
//
//  Created by Vitaly Merenkov on 06.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "PieChartController.h"
#import "AllAccountsDatasource.h"
#import "PieChartView.h"

@implementation PieChartController

-(void)comboBoxSelectionDidChange:(NSNotification *)notification {
    AllAccountsDatasource *dataSource = [[AllAccountsDatasource alloc] init];
    [_view setDataSource:dataSource];
    [_view setNeedsDisplay:YES];
}

@end
