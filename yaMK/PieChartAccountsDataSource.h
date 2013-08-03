//
//  AccountsPieChartDataSource.h
//  iCash
//
//  Created by Vitaly Merenkov on 13.01.13.

//

#import <Foundation/Foundation.h>
#import "Datasource.h"
#import "Account.h"

@interface PieChartAccountsDataSource : NSObject<DataSource>

@property NSArray *cacheData;
@property BOOL recalculate;

-(NSArray *)data:(AccountType)at
     usingFilter:(NSPredicate *)predicate;

@end
