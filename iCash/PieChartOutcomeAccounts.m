//
//  AllAccountsDatasource.m
//  iCash
//
//  Created by Vitaly Merenkov on 06.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "PieChartOutcomeAccounts.h"

@implementation PieChartOutcomeAccounts

-(NSArray *)data {
    if ([self cacheData]) {
        return [self cacheData];
    } else {
        return [self data:Outcome];
    }
}

@end
