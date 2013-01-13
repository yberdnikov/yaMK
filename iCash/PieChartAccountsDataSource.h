//
//  AccountsPieChartDataSource.h
//  iCash
//
//  Created by Vitaly Merenkov on 13.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PieChartDatasource.h"
#import "Account.h"

@interface PieChartAccountsDataSource : NSObject<PieChartDatasource>

@property NSDictionary *data;

-(NSDictionary *)getData:(AccountType)at;

@end
