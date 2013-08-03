//
//  IncomeBar.m
//  iCash
//
//  Created by Vitaly Merenkov on 13.02.13.

//

#import "IncomeBar.h"

@implementation IncomeBar

-(NSArray *)dataUsingFilter:(NSPredicate *)predicate {
    if ([self recalculate]) {
        [self fillDataWithType:Income usingFilter:predicate];
    }
    return [self cacheData];
}

@end
