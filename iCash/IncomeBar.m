//
//  IncomeBar.m
//  iCash
//
//  Created by Vitaly Merenkov on 13.02.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "IncomeBar.h"

@implementation IncomeBar

-(NSDictionary *)data {
    if (![self cacheData]) {
        [self fillDataWithType:Income];
    }
    return [self cacheData];
}

@end
