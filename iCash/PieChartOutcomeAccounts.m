//
//  AllAccountsDatasource.m
//  iCash
//
//  Created by Vitaly Merenkov on 06.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "PieChartOutcomeAccounts.h"

@implementation PieChartOutcomeAccounts

-(NSArray *)dataUsingFilter:(NSPredicate *)predicate {
    if ([self recalculate]) {
        return [self data:Outcome usingFilter:predicate];
    }
    return [self cacheData];
}

@end
