//
//  AccountsPieChartDataSource.m
//  iCash
//
//  Created by Vitaly Merenkov on 13.01.13.

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
    NSLog(@"sum = %f", sum);
    double percentSum = 0;
    for (Account *account in accounts) {
        NSDecimal valueSum = [[NSNumber numberWithInt:0] decimalValue];
        if ([account parent] && ![[account parent] parent]) {
            valueSum = [[account valueSumUsingFilter:predicate] decimalValue];
        } else if (![account parent]) {
            valueSum = [[account valueSumUsingFilter:predicate recursive:NO] decimalValue];
        }
        NSDecimal zero = [[NSNumber numberWithInt:0] decimalValue];
        NSLog(@"account name = %@", [account name]);
        NSLog(@"valuesum = %f", [[NSDecimalNumber decimalNumberWithDecimal:valueSum] doubleValue]);
        if (NSDecimalCompare(&valueSum, &zero) != 0) {
            double percentVal = [[NSDecimalNumber decimalNumberWithDecimal:valueSum] doubleValue] / sum;
            NSLog(@"percentVal = %f", percentVal);
//            NSLog(@"percentVal = %f", percentVal);
            DataSourceContainer *cont = [[DataSourceContainer alloc] init];
            [cont setColor:[account color]];
            [cont setValue:percentVal];
            [cont setName:[account name]];
            [result addObject:cont];
            percentSum += percentVal;
        }
        NSLog(@"percentSum = %f", percentSum);
    }
    [self setCacheData:result];
    [self setRecalculate:NO];
    return result;
}

@end
