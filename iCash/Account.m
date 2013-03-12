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
@dynamic colorRed;
@dynamic colorBlue;
@dynamic colorGreen;

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

- (NSInteger) valueSum {
    return [self valueSumUsingFilter:nil];
}

- (NSInteger) valueSumUsingFilter:(NSPredicate *)predicate {
    NSInteger income = 0;
    NSInteger outcome = 0;
    NSSet *recipientTransactions = [self recipientTransaction];
    NSSet *sourceTransactions = [self sourceTransaction];
    if (predicate) {
        recipientTransactions = [[self recipientTransaction] filteredSetUsingPredicate:predicate];
        sourceTransactions = [[self sourceTransaction] filteredSetUsingPredicate:predicate];
    }
    
    if ([[self type] intValue] == Balance) {
        income = [[recipientTransactions valueForKeyPath:@"@sum.value"] integerValue];
        outcome = [[sourceTransactions valueForKeyPath:@"@sum.value"] integerValue];
    } else if ([[self type] intValue] == Outcome) {
        income = [[recipientTransactions valueForKeyPath:@"@sum.value"] integerValue];
    } else if ([[self type] intValue] == Income) {
        income = [[sourceTransactions valueForKeyPath:@"@sum.value"] integerValue];
    }
    double result = 0;
    for (Account *child in [self subAccounts]) {
        result += [child valueSumUsingFilter:predicate];
    }
    return result + (income - outcome);
}

- (void) setValueSum:(NSInteger)value {
    
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
