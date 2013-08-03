//
//  AllAccountsDatasource.m
//  iCash
//
//  Created by Vitaly Merenkov on 06.01.13.

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
