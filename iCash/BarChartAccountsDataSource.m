//
//  BarChartAccountsDataSource.m
//  iCash
//
//  Created by Vitaly Merenkov on 27.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "BarChartAccountsDataSource.h"
#include "AccountFinder.h"
#include "DataSourceContainer.h"

@implementation BarChartAccountsDataSource
-(NSDictionary *)data {
    return nil;
}

-(void)fillDataWithType:(AccountType)accountType {
    NSArray *accounts = [[[AccountFinder alloc] init] findAccounts:Outcome ascending:NO];
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for (Account *a in accounts) {
        if ([a parent]) {
            DataSourceContainer *dc = [[DataSourceContainer alloc] init];
            [dc setValue:[a valueSum] / 100.0];
            [dc setColor:[a color]];
            [result setObject:dc forKey:[a name]];
        }
    }
    [self setCacheData:result];
}

@end
