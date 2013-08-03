//
//  MaxValueOutcomeAccounts.h
//  iCash
//
//  Created by Vitaly Merenkov on 12.01.13.

//

#import <Foundation/Foundation.h>
#import "Datasource.h"

@interface MaxValueOutcomeAccounts : NSObject<DataSource>

@property NSArray *cacheData;
@property BOOL recalculate;

@end
