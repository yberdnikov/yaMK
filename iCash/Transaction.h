//
//  Transaction.h
//  iCash
//
//  Created by Vitaly Merenkov on 05.11.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Account, Currency, PlaceOfSpending;

@interface Transaction : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * amount;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * typeOfAmount;
@property (nonatomic, retain) NSNumber * value;
@property (nonatomic, retain) Currency *currency;
@property (nonatomic, retain) PlaceOfSpending *placeOfSpending;
@property (nonatomic, retain) Account *recipient;
@property (nonatomic, retain) Account *source;

@end
