//
//  Account.m
//  iCash
//
//  Created by Vitaly Merenkov on 05.11.12.

//

#import "Account.h"
#import "Transaction.h"

@implementation Account
    

@dynamic name;
@dynamic type;
@dynamic parent;
@dynamic recipientTransaction;
@dynamic sourceTransaction;
@dynamic subAccounts;
@dynamic colorRed;
@dynamic colorBlue;
@dynamic colorGreen;

- (NSImage *) typeImage
{
    switch ([[self type] intValue]) {
        case Income:
            return [NSImage imageNamed:@"NSStatusAvailable"];
        case Expense:
            return [NSImage imageNamed:@"NSStatusUnavailable"];
        case Balance:
            return [NSImage imageNamed:@"NSStatusPartiallyAvailable"];
        default:
            return [NSImage imageNamed:@"NSStatusNone"];
    }
}

- (void) setTypeImage:(NSImage *)image {
    
}

- (NSDecimalNumber *) valueSum {
    return [self valueSumUsingFilter:nil];
}

- (NSDecimalNumber *) valueSumUsingFilter:(NSPredicate *)predicate {
    return [self valueSumUsingFilter:predicate recursive:YES];
}

- (NSDecimalNumber *) valueSumUsingFilter:(NSPredicate *)predicate recursive:(BOOL)rec {
    NSDecimal income = [[NSDecimalNumber decimalNumberWithMantissa:0 exponent:0 isNegative:NO] decimalValue];
    NSDecimal expense = [[NSDecimalNumber decimalNumberWithMantissa:0 exponent:0 isNegative:NO] decimalValue];
    NSSet *recipientTransactions = [self recipientTransaction];
    NSSet *sourceTransactions = [self sourceTransaction];
    if (predicate) {
        recipientTransactions = [[self recipientTransaction] filteredSetUsingPredicate:predicate];
        sourceTransactions = [[self sourceTransaction] filteredSetUsingPredicate:predicate];
    }
    
    if ([[self type] intValue] == Balance) {
        income = [[recipientTransactions valueForKeyPath:@"@sum.value"] decimalValue];
        expense = [[sourceTransactions valueForKeyPath:@"@sum.value"] decimalValue];
    } else if ([[self type] intValue] == Expense) {
        income = [[recipientTransactions valueForKeyPath:@"@sum.value"] decimalValue];
    } else if ([[self type] intValue] == Income) {
        income = [[sourceTransactions valueForKeyPath:@"@sum.value"] decimalValue];
    }
    NSDecimal result = [[NSDecimalNumber decimalNumberWithMantissa:0 exponent:0 isNegative:NO] decimalValue];
    if (rec) {
        for (Account *child in [self subAccounts]) {
            NSDecimalNumber *childValueSum = [child valueSumUsingFilter:predicate];
            NSDecimal childValueSumD = [childValueSum decimalValue];
            NSDecimalAdd(&result, &result, &childValueSumD, NSRoundBankers);
        }
    }
    NSDecimal diff = [[NSDecimalNumber decimalNumberWithMantissa:0 exponent:0 isNegative:NO] decimalValue];
    NSDecimalSubtract(&diff, &income, &expense, NSRoundBankers);
    NSDecimalAdd(&result, &result, &diff, NSRoundBankers);
    return [NSDecimalNumber decimalNumberWithDecimal:result];
}

- (void) setValueSum:(NSDecimal)value {
    
}

- (void) setName:(NSString *)name {
    [self setPrimitiveValue:[name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"name"];
    [self didChangeValueForKey:@"name"];
}

- (NSColor *) color {
    return [NSColor colorWithDeviceRed:[[self colorRed] doubleValue] green:[[self colorGreen] doubleValue] blue:[[self colorBlue] doubleValue] alpha:1];
}

- (void) setColor:(NSColor *)color {
    [self setColorRed:[NSNumber numberWithDouble:[color redComponent]]];
    [self setColorGreen:[NSNumber numberWithDouble:[color greenComponent]]];
    [self setColorBlue:[NSNumber numberWithDouble:[color blueComponent]]];
}

@end
