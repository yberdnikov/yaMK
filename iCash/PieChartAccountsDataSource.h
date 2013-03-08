//
//  AccountsPieChartDataSource.h
//  iCash
//
//  Created by Vitaly Merenkov on 13.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Datasource.h"
#import "Account.h"

@interface PieChartAccountsDataSource : NSObject<DataSource>

@property NSArray *cacheData;

-(NSArray *)data:(AccountType)at;

@end
