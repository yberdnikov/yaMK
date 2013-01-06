//
//  AllAccountsDatasource.m
//  iCash
//
//  Created by Vitaly Merenkov on 06.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "AllAccountsDatasource.h"
#import "AccountFinder.h"
#import "Account.h"

@implementation AllAccountsDatasource

-(NSDictionary *)getData {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    AccountFinder *af = [[AccountFinder alloc] init];
    NSArray *accounts = [af findAccounts:Outcome];
    NSLog(@"accounts = %@", accounts);
    double sum = 0;
    for (Account *account in accounts) {
        if (![account parent]) {
            sum = [account valueSum];
        }
    }
    for (Account *account in accounts) {
        if (![[account parent] parent] && [account parent]) {
            double percentVal = [account valueSum] / sum;
            [result setObject:[NSNumber numberWithDouble: percentVal] forKey:[account name]];
        }
    }
    return result;
}

@end
