//
//  MaxValueOutcomeAccounts.h
//  iCash
//
//  Created by Vitaly Merenkov on 12.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PieChartDatasource.h"

@interface MaxValueOutcomeAccounts : NSObject<PieChartDatasource>

@property NSDictionary *data;

@end
