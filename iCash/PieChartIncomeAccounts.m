//
//  PieChartIncomeAccounts.m
//  iCash
//
//  Created by Vitaly Merenkov on 13.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "PieChartIncomeAccounts.h"

@implementation PieChartIncomeAccounts

-(NSDictionary *)getData {
    if ([self data]) {
        return [self data];
    } else {
        return [self getData:Income];
    }
}

@end
