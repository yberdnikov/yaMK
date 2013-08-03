//
//  OutcomeBar.m
//  iCash
//
//  Created by Vitaly Merenkov on 10.02.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
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
