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

-(NSArray *)data {
    if (![self cacheData]) {
        [self fillDataWithType:Outcome];
    }
    return [self cacheData];
}

@end
