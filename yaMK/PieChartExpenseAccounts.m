//
//  AllAccountsDatasource.m
//  iCash
//
//  Created by Vitaly Merenkov on 06.01.13.

//

#import "PieChartExpenseAccounts.h"

@implementation PieChartExpenseAccounts

-(NSArray *)dataUsingFilter:(NSPredicate *)predicate {
    if ([self recalculate]) {
        return [self data:Expense usingFilter:predicate];
    }
    return [self cacheData];
}

@end
