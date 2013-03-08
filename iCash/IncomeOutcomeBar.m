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

-(NSArray *)data {
    if ([self cacheData]) {
        return [self cacheData];
    } else {
        return [self computeData];
    }
}

-(NSArray *)computeData {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSArray *incomeTransactions = [TransactionFinder findTransactionsBetweenStartDate:nil endDate:nil recipientType:Balance sourceType:Income];
    incomeTransactions = [incomeTransactions sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]]];
    unsigned yearMonthComps = NSYearCalendarUnit | NSMonthCalendarUnit;
    NSDate *key;
    NSMutableDictionary *tmpResult = [NSMutableDictionary dictionary];
    for (Transaction *t in incomeTransactions) {
        key = [cal dateFromComponents:[cal components:yearMonthComps fromDate:[t date]]];
        [self addToDataMap:tmpResult key:key subKey:@"Income" color:[NSColor colorWithSRGBRed:31.0/255.0 green:92.0/255.0 blue:20.0/255.0 alpha:1] value:[t value]];
    }
    NSArray *outcomeTransactions = [TransactionFinder findTransactionsBetweenStartDate:nil endDate:nil recipientType:Outcome sourceType:Balance];
    for (Transaction *t in outcomeTransactions) {
        key = [cal dateFromComponents:[cal components:yearMonthComps fromDate:[t date]]];
        [self addToDataMap:tmpResult key:key subKey:@"Outcome" color:[NSColor colorWithSRGBRed:195.0/255.0 green:25.0/255.0 blue:32.0/255.0 alpha:1] value:[t value]];
    }
    [self computeValue:tmpResult];
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[tmpResult count]];
    NSArray *keys = [tmpResult allKeys];
    keys = [keys sortedArrayUsingSelector:@selector(compare:)];
    for (id key in keys) {
        NSDictionary *subGroups = [tmpResult objectForKey:key];
        NSMutableArray *subGroupsArr = [NSMutableArray arrayWithCapacity:[subGroups count]];
        [self addObjectIfNotNull:[subGroups objectForKey:@"Income"] toArray:subGroupsArr];
        [self addObjectIfNotNull:[subGroups objectForKey:@"Outcome"] toArray:subGroupsArr];
        DataSourceContainer *dsc = [[DataSourceContainer alloc] initWithName:[self labelText:key]];
        [dsc setSubData:subGroupsArr];
        [result addObject:dsc];
    }
    NSLog(@"result = %@", result);
    [self setCacheData:result];
    return [self cacheData];
}

-(void)addObjectIfNotNull:(const id)object
                  toArray:(NSMutableArray *)array{
    if (object) {
        [array addObject:object];
    }
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
        [[result objectForKey:key] setObject:[[DataSourceContainer alloc] initWithName:subKey] forKey:subKey];
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
