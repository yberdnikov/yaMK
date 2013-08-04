//
//  IncomeExpenseBar.m
//  iCash
//
//  Created by Vitaly Merenkov on 27.01.13.

//

#import "IncomeExpenseBar.h"
#import "AccountFinder.h"
#import "TransactionFinder.h"
#import "Transaction.h"
#import "DataSourceContainer.h"
#include "Statistics.h"

@implementation IncomeExpenseBar

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
    NSArray *ExpenseTransactions = [self findExpenses:predicate];
    NSDate *startDate = [self startDateOfIncomes:incomeTransactions Expenses:ExpenseTransactions];
    NSDate *endDate = [self endDateOfIncomes:incomeTransactions Expenses:ExpenseTransactions];
    
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
            double income = [[NSDecimalNumber decimalNumberWithDecimal:[stat sumValueOfType:Income forMonth:m year:y]] doubleValue];
            double expense = [[NSDecimalNumber decimalNumberWithDecimal:[stat sumValueOfType:Expense forMonth:m year:y]] doubleValue];
            DataSourceContainer *groupDSC = [[DataSourceContainer alloc] initWithName:[self labelText:[cal dateFromComponents:thisComps]]];
            NSMutableArray *subData = [NSMutableArray arrayWithCapacity:2];
            [subData addObject:[[DataSourceContainer alloc] initWithName:@"Income"
                                                                   value:income
                                                                   color:[NSColor colorWithSRGBRed:31.0/255.0 green:92.0/255.0 blue:20.0/255.0 alpha:1]]];
            [subData addObject:[[DataSourceContainer alloc] initWithName:@"Expense"
                                                                   value:expense
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
    NSPredicate *recipientExpenseP = [NSPredicate predicateWithFormat:@"recipient.type = %@" argumentArray:[NSArray arrayWithObject:[NSNumber numberWithInt:Balance]]];
    NSPredicate *sourceExpenseP = [NSPredicate predicateWithFormat:@"source.type = %@" argumentArray:[NSArray arrayWithObject:[NSNumber numberWithInt:Income]]];
    NSPredicate *filter = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:predicate, recipientExpenseP, sourceExpenseP, nil]];
    NSArray *result = [TransactionFinder findTransactionsUsingPredicate:filter];
    return [result sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]]];
}

-(NSArray *)findExpenses:(NSPredicate *)predicate {
    NSPredicate *recipientExpenseP = [NSPredicate predicateWithFormat:@"recipient.type = %@" argumentArray:[NSArray arrayWithObject:[NSNumber numberWithInt:Expense]]];
    NSPredicate *sourceExpenseP = [NSPredicate predicateWithFormat:@"source.type = %@" argumentArray:[NSArray arrayWithObject:[NSNumber numberWithInt:Balance]]];
    NSPredicate *filter = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:predicate, recipientExpenseP, sourceExpenseP, nil]];
    NSArray *result = [TransactionFinder findTransactionsUsingPredicate:filter];
    return [result sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]]];
}

-(NSDate *)startDateOfIncomes:(NSArray *)incomes
                     Expenses:(NSArray *)Expenses {
    NSDate *incomeStart = [[incomes objectAtIndex:0] date];
    NSDate *ExpenseStart = [[Expenses objectAtIndex:0] date];
    if ([incomeStart compare:ExpenseStart] == NSOrderedAscending) {
        return incomeStart;
    } else {
        return ExpenseStart;
    }
}

-(NSDate *)endDateOfIncomes:(NSArray *)incomes
                   Expenses:(NSArray *)Expenses {
    NSDate *incomeEnd = [[incomes objectAtIndex:([incomes count] - 1)] date];
    NSDate *ExpenseEnd = [[Expenses objectAtIndex:([Expenses count] - 1)] date];
    if ([incomeEnd compare:ExpenseEnd] == NSOrderedDescending) {
        return incomeEnd;
    } else {
        return ExpenseEnd;
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

-(NSString *)labelText:(id)key {
    NSDateFormatter* df_local = [[NSDateFormatter alloc] init];
    [df_local setTimeZone:[NSTimeZone localTimeZone]];
    [df_local setDateFormat:@"yyyy.MM"];
    return [df_local stringFromDate:key];
}

@end
