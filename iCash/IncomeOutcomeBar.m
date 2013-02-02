//
//  IncomeOutcomeBar.m
//  iCash
//
//  Created by Vitaly Merenkov on 27.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "IncomeOutcomeBar.h"
#import "AccountFinder.h"
#import "TransactionFinder.h"
#import "Transaction.h"
#import "DataSourceContainer.h"

@implementation IncomeOutcomeBar

-(NSDictionary *)data {
    if ([self cacheData]) {
        return [self cacheData];
    } else {
        return [self computeData];
    }
}

-(NSDictionary *)computeData {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSArray *incomeTransactions = [TransactionFinder findTransactionsBetweenStartDate:nil endDate:nil recipientType:Balance sourceType:Income];
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    unsigned yearMonthComps = NSYearCalendarUnit | NSMonthCalendarUnit;
    NSDate *key;
    for (Transaction *t in incomeTransactions) {
        key = [cal dateFromComponents:[cal components:yearMonthComps fromDate:[t date]]];
        [self addToDataMap:result key:key subKey:@"Income" color:[NSColor colorWithSRGBRed:31.0/255.0 green:92.0/255.0 blue:20.0/255.0 alpha:1] value:[t value]];
    }
    NSArray *outcomeTransactions = [TransactionFinder findTransactionsBetweenStartDate:nil endDate:nil recipientType:Outcome sourceType:Balance];
    for (Transaction *t in outcomeTransactions) {
        key = [cal dateFromComponents:[cal components:yearMonthComps fromDate:[t date]]];
        [self addToDataMap:result key:key subKey:@"Outcome" color:[NSColor colorWithSRGBRed:195.0/255.0 green:25.0/255.0 blue:32.0/255.0 alpha:1] value:[t value]];
    }
    [self computeValue:result];
    NSLog(@"result = %@", result);
    [self setCacheData:result];
    return [self cacheData];
}

-(void)addToDataMap:(NSMutableDictionary *)result
                key:(id)key
             subKey:(NSString *)subKey
              color:(NSColor *)color
              value:(NSNumber *)value{
    if (![result objectForKey:key]) {
        [result setObject:[[NSMutableDictionary alloc] init] forKey:key];
    }
    if (![[result objectForKey:key] objectForKey:subKey]) {
        [[result objectForKey:key] setObject:[[DataSourceContainer alloc] init] forKey:subKey];
        [[[result objectForKey:key] objectForKey:subKey] setColor:color];
    }
    [(DataSourceContainer *)[[result objectForKey:key] objectForKey:subKey] setIntValue:([(DataSourceContainer *)[[result objectForKey:key] objectForKey:subKey] intValue] + [value integerValue])];
}

-(void)computeValue:(NSMutableDictionary *)result {
    NSArray *monthsVals = [result allValues];
    for (NSMutableDictionary *io in monthsVals) {
        NSArray *ioDS = [io allValues];
        for (DataSourceContainer *ds in ioDS) {
            [ds setValue:((double)[ds intValue] / 100.0)];
        }
    }
}

-(NSString *)labelText:(id)key {
    NSDateFormatter* df_local = [[NSDateFormatter alloc] init];
    [df_local setTimeZone:[NSTimeZone localTimeZone]];
    [df_local setDateFormat:@"yyyy.MM"];
    return [df_local stringFromDate:key];
}

@end
