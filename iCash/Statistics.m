//
//  Statistics.m
//  iCash
//
//  Created by Vitaly Merenkov on 10.03.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "Statistics.h"
#include "AccountFinder.h"

@implementation Statistics

-(Statistics *)init{
    self = [super init];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setThisMonth:) userInfo:nil repeats:YES];
    return self;
}

-(NSInteger)thisMonth {
    NSArray *incomes = [[[AccountFinder alloc] init] findAccounts:Income];
    NSArray *outcomes = [[[AccountFinder alloc] init] findAccounts:Outcome];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned yearMonthComps = NSYearCalendarUnit | NSMonthCalendarUnit;
    NSDate *fromDate = [cal dateFromComponents:[cal components:yearMonthComps fromDate:[NSDate date]]];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:1];
    NSDate *toDate = [cal dateByAddingComponents:comps toDate:fromDate options:0];
    NSPredicate *predicate = [Statistics predicateByFromDate:fromDate toDate:toDate];
    NSInteger incomeVal = [self computeValueUsingFilter:predicate accounts:incomes];
    NSInteger outcomeVal = [self computeValueUsingFilter:predicate accounts:outcomes];
    return incomeVal - outcomeVal;
}

-(void)setThisMonth:(NSInteger)val {
}

+(NSPredicate *)predicateByFromDate:(NSDate *)fromDate
                             toDate:(NSDate *)toDate {
    NSPredicate *fromDateP = [NSPredicate predicateWithFormat:@"date >= %@" argumentArray:[NSArray arrayWithObject:fromDate]];
    NSPredicate *toDateP = [NSPredicate predicateWithFormat:@"date < %@" argumentArray:[NSArray arrayWithObject:toDate]];
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:fromDateP, toDateP, nil]];
    return predicate;
}

-(NSInteger)computeValueUsingFilter:(NSPredicate *)predicate accounts:(NSArray *)accounts {
    NSInteger value = 0;
    for (Account *a in accounts) {
        if (![a parent]) {
            value += [a valueSumUsingFilter:predicate];
        }
    }
    return value;
}

-(NSInteger)sumValueOfType:(AccountType)type
               forMonth:(NSInteger)month
                   year:(NSInteger)year{
    NSArray *accounts = [[[AccountFinder alloc] init] findAccounts:type];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *startComps = [[NSDateComponents alloc] init];
    [startComps setMonth:month];
    [startComps setYear:year];
    NSDateComponents *offsetComps = [[NSDateComponents alloc] init];
    [offsetComps setMonth:1];
    NSDate *fromDate = [cal dateFromComponents:startComps];
    NSDate *toDate = [cal dateByAddingComponents:offsetComps toDate:fromDate options:0];
    return [self computeValueUsingFilter:[Statistics predicateByFromDate:fromDate toDate:toDate] accounts:accounts];
}

@end
