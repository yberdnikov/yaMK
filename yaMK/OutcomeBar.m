//
//  OutcomeBar.m
//  iCash
//
//  Created by Vitaly Merenkov on 10.02.13.

//

#import "OutcomeBar.h"
#import "AccountFinder.h"
#import "DataSourceContainer.h"

@implementation OutcomeBar

-(NSArray *)dataUsingFilter:(NSPredicate *)predicate {
    if ([self recalculate]) {
        [self fillDataWithType:Outcome usingFilter:predicate];
    }
    return [self cacheData];
}

@end
