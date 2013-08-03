//
//  PieChartIncomeAccounts.m
//  iCash
//
//  Created by Vitaly Merenkov on 13.01.13.

//

#import "PieChartIncomeAccounts.h"

@implementation PieChartIncomeAccounts

-(NSArray *)dataUsingFilter:(NSPredicate *)predicate {
    if ([self recalculate]) {
        return [self data:Income usingFilter:predicate];
    }
    return [self cacheData];
}

@end
