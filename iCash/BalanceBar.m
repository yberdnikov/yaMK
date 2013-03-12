//
//  BalanceBar.m
//  iCash
//
//  Created by Vitaly Merenkov on 13.02.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "BalanceBar.h"

@implementation BalanceBar

-(NSArray *)dataUsingFilter:(NSPredicate *)predicate {
    if ([self recalculate]) {
        [self fillDataWithType:Balance usingFilter:predicate];
    }
    return [self cacheData];
}

@end
