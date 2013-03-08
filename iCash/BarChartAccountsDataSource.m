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

- (double)addAccount:(Account *)a toArray:(NSMutableArray *)result {
    DataSourceContainer *dc = [[DataSourceContainer alloc] initWithName:[a name]];
    double childrenSum = 0;
    NSMutableArray *subData = [NSMutableArray array];
    for (Account *subAcc in [a subAccounts]) {
        childrenSum += [self addAccount:subAcc toArray:subData];
    }
    [dc setValue:([a valueSum] / 100.0 - childrenSum)];
    [dc setColor:[a color]];
    [dc setSubData:subData];
    [result addObject:dc];
    return [dc value];
}

-(void)fillDataWithType:(AccountType)accountType {
    NSArray *accounts = [[[AccountFinder alloc] init] findAccounts:accountType ascending:NO];
    NSMutableArray *result = [NSMutableArray array];
    for (Account *a in accounts) {
        if ([a parent] && ![[a parent] parent] && [a valueSum] > 0) {
            [self addAccount:a toArray:result];
        }
    }
    [self setCacheData:result];
}

@end
