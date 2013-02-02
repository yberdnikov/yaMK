//
//  PieChartIncomeAccounts.m
//  iCash
//
//  Created by Vitaly Merenkov on 13.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "PieChartIncomeAccounts.h"

@implementation PieChartIncomeAccounts

-(NSDictionary *)data {
    if ([self cacheData]) {
        return [self cacheData];
    } else {
        return [self data:Income];
    }
}

@end
