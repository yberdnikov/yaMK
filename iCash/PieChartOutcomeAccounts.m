//
//  AllAccountsDatasource.m
//  iCash
//
//  Created by Vitaly Merenkov on 06.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "PieChartOutcomeAccounts.h"

@implementation PieChartOutcomeAccounts

-(NSDictionary *)getData {
    if ([self data]) {
        return [self data];
    } else {
        return [self getData:Outcome];
    }
}

@end