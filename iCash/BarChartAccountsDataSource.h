//
//  BarChartAccountsDataSource.h
//  iCash
//
//  Created by Vitaly Merenkov on 27.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSource.h"
#import "Account.h"

@interface BarChartAccountsDataSource : NSObject<DataSource>

@property NSDictionary *cacheData;

-(void)fillDataWithType:(AccountType)accountType;

@end