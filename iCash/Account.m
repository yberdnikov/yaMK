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
    double income = 0;
    double outcome = 0;
    
    if ([[self type] intValue] == Balance || [[self type] intValue] == Outcome) {
        for (Transaction *inT in [self recipientTransaction]) {
            income += [[inT value] doubleValue];
        }
    }
    
    if ([[self type] intValue] == Balance) {
        for (Transaction *outT in [self sourceTransaction]) {
            outcome += [[outT value] doubleValue];
        }
    } else if ([[self type] intValue] == Income) {
        for (Transaction *outT in [self sourceTransaction]) {
            income += [[outT value] doubleValue];
        }
    }
    return (income - outcome);
}

- (void) setValueSum:(double)value {
    
}
@end
