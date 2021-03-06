//
//  MaxValueExpenseAccounts.m
//  iCash
//
//  Created by Vitaly Merenkov on 12.01.13.

//

#import "MaxValueExpenseAccounts.h"
#import "Account.h"
#import "DataSourceContainer.h"
#import "AccountFinder.h"

@implementation MaxValueExpenseAccounts

-(NSArray *)data {
    if (_cacheData) {
        return _cacheData;
    } else {
        NSMutableArray *result = [NSMutableArray array];
//        AccountFinder *af = [[AccountFinder alloc] init];
//        NSArray *accounts = [af findAccounts:Expense];
//        NSLog(@"accounts = %@", accounts);
//        double sum = 0;
//        for (Account *account in accounts) {
//            if (![account parent]) {
//                sum = [account valueSum];
//            }
//        }
//        [accounts sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"valueSum" ascending:NO]]];
//        char showAccounts = 8;
//        char foundAccounts = 0;
//        double othersPercent = 0;
//        for (Account *account in accounts) {
//            if (![[account parent] parent] && [account parent] && foundAccounts < showAccounts) {
//                double percentVal = [account valueSum] / sum;
//                DataSourceContainer *cont = [[DataSourceContainer alloc] init];
//                [cont setColor:[account color]];
//                [cont setValue:percentVal];
//                [result setObject:cont forKey:[account name]];
//                foundAccounts++;
//            } else if (![[account parent] parent] && [account parent] && foundAccounts >= showAccounts) {
//                othersPercent += ([account valueSum] / sum);
//            }
//        }
//        DataSourceContainer *cont = [[DataSourceContainer alloc] init];
//        [cont setColor:[NSColor grayColor]];
//        [cont setValue:othersPercent];
//        [result setObject:cont forKey:@"Others"];
//        [self setCacheData:result];
        return result;
    }
}

-(NSArray *)dataUsingFilter:(NSPredicate *)predicate {
    return nil;
}

@end
