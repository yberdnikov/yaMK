//
//  Statistics.h
//  iCash
//
//  Created by Vitaly Merenkov on 10.03.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Account.h"

@interface Statistics : NSObject

-(NSDecimalNumber *)thisMonth;
-(void)setThisMonth:(NSDecimalNumber *)val;
-(NSDecimal)computeValueUsingFilter:(NSPredicate *)predicate accounts:(NSArray *)accounts;
-(NSDecimal)sumValueOfType:(AccountType)type
               forMonth:(NSInteger)month
                   year:(NSInteger)year;

+(NSPredicate *)predicateByFromDate:(NSDate *)fromDate
                             toDate:(NSDate *)toDate;

@property (strong) NSTimer *timer;

@end
