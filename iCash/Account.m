//
//  Account.m
//  iCash
//
//  Created by Vitaly Merenkov on 05.11.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import "Account.h"
#import "Account.h"
#import "Transaction.h"


@implementation Account

@dynamic name;
@dynamic type;
@dynamic parent;
@dynamic recipientTransaction;
@dynamic sourceTransaction;
@dynamic subAccounts;

- (NSImage *) typeImage
{
    switch ([[self type] intValue]) {
        case Income:
            return [NSImage imageNamed:@"NSStatusAvailable"];
        case Outcome:
            return [NSImage imageNamed:@"NSStatusUnavailable"];
        case Balance:
            return [NSImage imageNamed:@"NSStatusPartiallyAvailable"];
        default:
            return [NSImage imageNamed:@"NSStatusNone"];
    }
}

- (void) setTypeImage:(NSImage *)image {
    
}

- (double) valueSum {
    NSLog(@"[ account %@", [self name]);
    double income = 0;
    double outcome = 0;
    
    if ([[self type] intValue] == Balance || [[self type] intValue] == Outcome) {
        income = [[[self recipientTransaction] valueForKeyPath:@"@sum.value"] doubleValue];
        
    }
    if ([[self type] intValue] == Balance) {
        outcome = [[[self sourceTransaction] valueForKeyPath:@"@sum.value"] doubleValue];
    } else if ([[self type] intValue] == Income) {
        income = [[[self sourceTransaction] valueForKeyPath:@"@sum.value"] doubleValue];
    }
    NSLog(@"income = %f", income);
    NSLog(@"outcome = %f", outcome);
    double result = 0;
    for (Account *child in [self subAccounts]) {
        result += [child valueSum];
    }
    NSLog(@"] %f", result + (income - outcome));
    return result + (income - outcome);
}

- (void) setValueSum:(double)value {
    
}

- (NSArray *)viewedTransactions {
    NSMutableArray *transactions = [NSMutableArray array];
    if ([[self type] intValue] == Balance) {
        [transactions addObjectsFromArray:[[self recipientTransaction] sortedArrayUsingDescriptors:nil]];
        [transactions addObjectsFromArray:[[self sourceTransaction] sortedArrayUsingDescriptors:nil]];
    } else if ([[self type] intValue] == Outcome) {
        [transactions addObjectsFromArray:[[self recipientTransaction] sortedArrayUsingDescriptors:nil]];
    } else if ([[self type] intValue] == Income) {
        [transactions addObjectsFromArray:[[self sourceTransaction] sortedArrayUsingDescriptors:nil]];
    }
    for (Account *child in [self subAccounts]) {
        [transactions addObjectsFromArray:[child viewedTransactions]];
    }
    return transactions;
}
@end
