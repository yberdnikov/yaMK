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

-(BarChartAccountsDataSource *)init {
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

- (double)addAccount:(Account *)a
             toArray:(NSMutableArray *)result {
    return [self addAccount:a toArray:result usingFilter:nil];
}

- (double)addAccount:(Account *)a
             toArray:(NSMutableArray *)result
         usingFilter:(NSPredicate *)predicate{
    DataSourceContainer *dc = [[DataSourceContainer alloc] initWithName:[a name]];
    double childrenSum = 0;
    NSMutableArray *subData = [NSMutableArray array];
    for (Account *subAcc in [a subAccounts]) {
        childrenSum += [self addAccount:subAcc toArray:subData usingFilter:predicate];
    }
    [dc setValue:([[a valueSumUsingFilter:predicate] doubleValue] - childrenSum)];
    [dc setColor:[a color]];
    [dc setSubData:subData];
    [result addObject:dc];
    return [dc value];
}

-(void)fillDataWithType:(AccountType)accountType {
    [self fillDataWithType:accountType usingFilter:nil];
}

-(void)fillDataWithType:(AccountType)accountType
            usingFilter:(NSPredicate *)predicate {
    NSArray *accounts = [[[AccountFinder alloc] init] findAccounts:accountType ascending:NO];
    NSMutableArray *result = [NSMutableArray array];
    for (Account *a in accounts) {
        if ([a parent] && ![[a parent] parent] && [[a valueSum] doubleValue] > 0) {
            [self addAccount:a toArray:result usingFilter:predicate];
        }
    }
    [self setCacheData:result];
    [self setRecalculate:NO];
}

@end
