//
//  Statistics.m
//  iCash
//
//  Created by Vitaly Merenkov on 10.03.13.

//

#import "Statistics.h"
#import "AccountFinder.h"
@implementation Statistics

-(Statistics *)init{
    self = [super init];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setThisMonth:) userInfo:nil repeats:YES];
    return self;
}

-(NSDecimalNumber *)thisMonth {
    NSDecimal result = [[NSDecimalNumber decimalNumberWithMantissa:0 exponent:0 isNegative:NO] decimalValue];
    NSArray *incomes = [[[AccountFinder alloc] init] findAccounts:Income];
    NSArray *Expenses = [[[AccountFinder alloc] init] findAccounts:Expense];
    if ([incomes count] > 0 || [Expenses count] > 0) {
        NSCalendar *cal = [NSCalendar currentCalendar];
        unsigned yearMonthComps = NSYearCalendarUnit | NSMonthCalendarUnit;
        NSDate *fromDate = [cal dateFromComponents:[cal components:yearMonthComps fromDate:[NSDate date]]];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setMonth:1];
        NSDate *toDate = [cal dateByAddingComponents:comps toDate:fromDate options:0];
        NSPredicate *predicate = [Statistics predicateByFromDate:fromDate toDate:toDate];
        NSDecimal incomeVal = [self computeValueUsingFilter:predicate accounts:incomes];
        NSDecimal ExpenseVal = [self computeValueUsingFilter:predicate accounts:Expenses];
        NSDecimalSubtract(&result, &incomeVal, &ExpenseVal, NSRoundBankers);
    }
    return [NSDecimalNumber decimalNumberWithDecimal:result];
}

-(void)setThisMonth:(NSDecimalNumber *)val {
}

+(NSPredicate *)predicateByFromDate:(NSDate *)fromDate
                             toDate:(NSDate *)toDate {
    NSPredicate *fromDateP = [NSPredicate predicateWithFormat:@"date >= %@" argumentArray:[NSArray arrayWithObject:fromDate]];
    NSPredicate *toDateP = [NSPredicate predicateWithFormat:@"date < %@" argumentArray:[NSArray arrayWithObject:toDate]];
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:fromDateP, toDateP, nil]];
    return predicate;
}

-(NSDecimal)computeValueUsingFilter:(NSPredicate *)predicate accounts:(NSArray *)accounts {
    NSDecimal result = [[NSDecimalNumber decimalNumberWithMantissa:0 exponent:0 isNegative:NO] decimalValue];
    for (Account *a in accounts) {
        if (![a parent]) {
            NSDecimal val = [[a valueSumUsingFilter:predicate] decimalValue];
            NSDecimalAdd(&result, &result, &val, NSRoundBankers);
        }
    }
    return result;
}

-(NSDecimal)sumValueOfType:(AccountType)type
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
