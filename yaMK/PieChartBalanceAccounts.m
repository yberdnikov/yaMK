//
//  PieChartBalanceAccounts.m
//  iCash
//
//  Created by Vitaly Merenkov on 13.01.13.

//

#import "PieChartBalanceAccounts.h"

@implementation PieChartBalanceAccounts

-(NSArray *)dataUsingFilter:(NSPredicate *)predicate {
    if ([self recalculate]) {
        return [self data:Balance usingFilter:predicate];
    }
    return [self cacheData];
}

@end
