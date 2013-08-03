//
//  BarChartAccountsDataSource.h
//  iCash
//
//  Created by Vitaly Merenkov on 27.01.13.

//

#import <Foundation/Foundation.h>
#import "DataSource.h"
#import "Account.h"

@interface BarChartAccountsDataSource : NSObject<DataSource>

@property NSArray *cacheData;
@property BOOL recalculate;

-(void)fillDataWithType:(AccountType)accountType;
-(void)fillDataWithType:(AccountType)accountType
            usingFilter:(NSPredicate *)predicate;

@end
