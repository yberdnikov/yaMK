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
#include "Statistics.h"

@implementation IncomeOutcomeBar

-(NSArray *)data {
    return [self dataUsingFilter:nil];
}

-(NSArray *)dataUsingFilter:(NSPredicate *)predicate {
    if ([self recalculate]) {
        return [self computeData:predicate];
    }
    return [self cacheData];
}

-(NSArray *)computeData:(NSPredicate *)predicate {
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSArray *incomeTransactions = [self findIncomes:predicate];
    NSArray *outcomeTransactions = [self findOutcomes:predicate];
    NSDate *startDate = [self startDateOfIncomes:incomeTransactions outcomes:outcomeTransactions];
    NSDate *endDate = [self endDateOfIncomes:incomeTransactions outcomes:outcomeTransactions];
    
    NSInteger firstMonth = [[cal components:NSMonthCalendarUnit fromDate:startDate] month];
    NSInteger lastMonth = [[cal components:NSMonthCalendarUnit fromDate:endDate] month];
    NSInteger firstYear = [[cal components:NSYearCalendarUnit fromDate:startDate] year];
    NSInteger lastYear = [[cal components:NSYearCalendarUnit fromDate:endDate] year];

    Statistics *stat = [[Statistics alloc] init];
    
    NSMutableArray *result = [NSMutableArray array];
    NSInteger m = firstMonth;
    for (NSInteger y = firstYear; y <= lastYear; y++) {
        for (; m <= lastMonth || (m <= 12 && y < lastYear); m++) {
            NSDateComponents *thisComps = [[NSDateComponents alloc] init];
            [thisComps setMonth:m];
            [thisComps setYear:y];
            NSInteger income = [stat sumValueOfType:Income forMonth:m year:y];
            NSInteger outcome = [stat sumValueOfType:Outcome forMonth:m year:y];
            DataSourceContainer *groupDSC = [[DataSourceContainer alloc] initWithName:[self labelText:[cal dateFromComponents:thisComps]]];
            NSMutableArray *subData = [NSMutableArray arrayWithCapacity:2];
            [subData addObject:[[DataSourceContainer alloc] initWithName:@"Income"
                                                                intValue:income
                                                                   color:[NSColor colorWithSRGBRed:31.0/255.0 green:92.0/255.0 blue:20.0/255.0 alpha:1]]];
            [subData addObject:[[DataSourceContainer alloc] initWithName:@"Outcome"
                                                                intValue:outcome
                                                                   color:[NSColor colorWithSRGBRed:195.0/255.0 green:25.0/255.0 blue:32.0/255.0 alpha:1]]];
            [groupDSC setSubData:subData];
            [result addObject:groupDSC];
        }
        m = 1;
    }
    
    [self setCacheData:result];
    [self setRecalculate:NO];
    return [self cacheData];
}

-(NSArray *)findIncomes:(NSPredicate *)predicate {
    NSPredicate *recipientOutcomeP = [NSPredicate predicateWithFormat:@"recipient.type = %@" argumentArray:[NSArray arrayWithObject:[NSNumber numberWithInt:Balance]]];
    NSPredicate *sourceOutcomeP = [NSPredicate predicateWithFormat:@"source.type = %@" argumentArray:[NSArray arrayWithObject:[NSNumber numberWithInt:Income]]];
    NSPredicate *filter = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:predicate, recipientOutcomeP, sourceOutcomeP, nil]];
    NSArray *result = [TransactionFinder findTransactionsUsingPredicate:filter];
    return [result sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]]];
}

-(NSArray *)findOutcomes:(NSPredicate *)predicate {
    NSPredicate *recipientOutcomeP = [NSPredicate predicateWithFormat:@"recipient.type = %@" argumentArray:[NSArray arrayWithObject:[NSNumber numberWithInt:Outcome]]];
    NSPredicate *sourceOutcomeP = [NSPredicate predicateWithFormat:@"source.type = %@" argumentArray:[NSArray arrayWithObject:[NSNumber numberWithInt:Balance]]];
    NSPredicate *filter = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:predicate, recipientOutcomeP, sourceOutcomeP, nil]];
    NSArray *result = [TransactionFinder findTransactionsUsingPredicate:filter];
    return [result sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]]];
}

-(NSDate *)startDateOfIncomes:(NSArray *)incomes
                     outcomes:(NSArray *)outcomes {
    NSDate *incomeStart = [[incomes objectAtIndex:0] date];
    NSDate *outcomeStart = [[outcomes objectAtIndex:0] date];
    if ([incomeStart compare:outcomeStart] == NSOrderedAscending) {
        return incomeStart;
    } else {
        return outcomeStart;
    }
}

-(NSDate *)endDateOfIncomes:(NSArray *)incomes
                   outcomes:(NSArray *)outcomes {
    NSDate *incomeEnd = [[incomes objectAtIndex:([incomes count] - 1)] date];
    NSDate *outcomeEnd = [[outcomes objectAtIndex:([outcomes count] - 1)] date];
    if ([incomeEnd compare:outcomeEnd] == NSOrderedDescending) {
        return incomeEnd;
    } else {
        return outcomeEnd;
    }
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
