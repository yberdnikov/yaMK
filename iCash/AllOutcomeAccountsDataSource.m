//
//  AllAccountsDatasource.m
//  iCash
//
//  Created by Vitaly Merenkov on 06.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "AllOutcomeAccountsDataSource.h"
#import "AccountFinder.h"
#import "Account.h"
#import "DataSourceContainer.h"

@implementation AllOutcomeAccountsDataSource

-(NSDictionary *)getData {
    if (_data) {
        return _data;
    } else {
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
                DataSourceContainer *cont = [[DataSourceContainer alloc] init];
                [cont setColor:[account color]];
                [cont setValue:percentVal];
                [result setObject:cont forKey:[account name]];
            }
        }
        [self setData:result];
        return result;
    }
}

@end
