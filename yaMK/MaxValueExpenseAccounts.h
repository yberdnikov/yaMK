//
//  MaxValueExpenseAccounts.h
//  iCash
//
//  Created by Vitaly Merenkov on 12.01.13.

//

#import <Foundation/Foundation.h>
#import "Datasource.h"

@interface MaxValueExpenseAccounts : NSObject<DataSource>

@property NSArray *cacheData;
@property BOOL recalculate;

@end
