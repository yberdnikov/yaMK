//
//  PieChartController.h
//  iCash
//
//  Created by Vitaly Merenkov on 06.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PieChartView;

@interface PieChartController : NSObject<NSComboBoxDelegate>

@property (weak) IBOutlet PieChartView *view;
@property (weak) IBOutlet NSComboBox *chartType;

@end
