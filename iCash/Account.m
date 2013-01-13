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
    NSLog(@"[ account %@", [self name]);
    NSInteger income = 0;
    NSInteger outcome = 0;
    
    if ([[self type] intValue] == Balance) {
        income = [[[self recipientTransaction] valueForKeyPath:@"@sum.value"] integerValue];
        outcome = [[[self sourceTransaction] valueForKeyPath:@"@sum.value"] integerValue];
        NSLog(@"Balance");
        NSLog(@"income = %lu", income);
        NSLog(@"outcome = %lu", outcome);
    } else if ([[self type] intValue] == Outcome) {
        income = [[[self recipientTransaction] valueForKeyPath:@"@sum.value"] integerValue];
        NSLog(@"Outcome");
        NSLog(@"income = %lu", income);
        NSLog(@"outcome = %lu", outcome);
    } else if ([[self type] intValue] == Income) {
        income = [[[self sourceTransaction] valueForKeyPath:@"@sum.value"] integerValue];
        NSLog(@"Income");
        NSLog(@"income = %lu", income);
        NSLog(@"outcome = %lu", outcome);
    }
    double result = 0;
    for (Account *child in [self subAccounts]) {
        result += [child valueSum];
    }
    NSLog(@"] %f", result + (income - outcome));
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
