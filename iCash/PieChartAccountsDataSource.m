//
//  AccountsPieChartDataSource.m
//  iCash
//
//  Created by Vitaly Merenkov on 13.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "PieChartAccountsDataSource.h"
#import "AccountFinder.h"
#import "DataSourceContainer.h"

@implementation PieChartAccountsDataSource

-(NSDictionary *)getData {
    return nil;
    
}

-(NSDictionary *)getData:(AccountType)at {
    if (_data) {
        return _data;
    } else {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        AccountFinder *af = [[AccountFinder alloc] init];
        NSArray *accounts = [af findAccounts:at];
        NSLog(@"accounts = %@", accounts);
        double sum = 0;
        for (Account *account in accounts) {
            if (![account parent]) {
                sum = [account valueSum];
            }
        }
        for (Account *account in accounts) {
            if (![[account parent] parent] && [account parent]) {
                NSInteger valueSum = [account valueSum];
                if (valueSum != 0) {
                    double percentVal = valueSum / sum;
                    DataSourceContainer *cont = [[DataSourceContainer alloc] init];
                    [cont setColor:[account color]];
                    [cont setValue:percentVal];
                    [result setObject:cont forKey:[account name]];
                }
            }
        }
        [self setData:result];
        return result;
    }
}

@end
