//
//  AccountsPieChartDataSource.m
//  iCash
//
//  Created by Vitaly Merenkov on 13.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "PieChartAccountsDataSource.h"
#import "AccountFinder.h"
#import "DataSourceContainer.h"

@implementation PieChartAccountsDataSource

-(PieChartAccountsDataSource *)init {
    self = [super init];
    [self setRecalculate:YES];
    return self;
}

-(NSArray *)data {
    return [self dataUsingFilter:nil];
}

-(NSArray *)dataUsingFilter:(NSPredicate *)predicate {
    return nil;
}

-(NSArray *)data:(AccountType)at
     usingFilter:(NSPredicate *)predicate{
    NSMutableArray *result = [NSMutableArray array];
    AccountFinder *af = [[AccountFinder alloc] init];
    NSArray *accounts = [af findAccounts:at];
    double sum = 0;
    for (Account *account in accounts) {
        if (![account parent]) {
            sum = [[account valueSumUsingFilter:predicate] doubleValue];
        }
    }
    for (Account *account in accounts) {
        if ([account parent] && ![[account parent] parent]) {
            NSDecimal valueSum = [[account valueSumUsingFilter:predicate] decimalValue];
            NSDecimal zero;
            if (NSDecimalCompare(&valueSum, &zero)) {
                double percentVal = [[NSDecimalNumber decimalNumberWithDecimal:valueSum] doubleValue] / sum;
                DataSourceContainer *cont = [[DataSourceContainer alloc] init];
                [cont setColor:[account color]];
                [cont setValue:percentVal];
                [cont setName:[account name]];
                [result addObject:cont];
            }
        }
    }
    [self setCacheData:result];
    [self setRecalculate:NO];
    return result;
}

@end
