//
//  ExpenseBar.m
//  iCash
//
//  Created by Vitaly Merenkov on 10.02.13.

//

#import "ExpenseBar.h"
#import "AccountFinder.h"
#import "DataSourceContainer.h"

@implementation ExpenseBar

-(NSArray *)dataUsingFilter:(NSPredicate *)predicate {
    if ([self recalculate]) {
        [self fillDataWithType:Expense usingFilter:predicate];
    }
    return [self cacheData];
}

@end
