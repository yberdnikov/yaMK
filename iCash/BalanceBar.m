//
//  BalanceBar.m
//  iCash
//
//  Created by Vitaly Merenkov on 13.02.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "BalanceBar.h"

@implementation BalanceBar

-(NSArray *)data {
    if (![self cacheData]) {
        [self fillDataWithType:Balance];
    }
    return [self cacheData];
}

@end
