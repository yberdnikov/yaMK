//
//  TransactionFinder.h
//  iCash
//
//  Created by Vitaly Merenkov on 27.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface TransactionFinder : NSObject

+(NSArray *)findTransactionsBetweenStartDate:(NSDate *)startDate
                                     endDate:(NSDate *)endDate
                                   recipientType:(AccountType)recipientType
                                      sourceType:(AccountType)sourceType;

@end
