//
//  Currency.h
//  iCash
//
//  Created by Vitaly Merenkov on 31.10.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Transaction;

@interface Currency : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * sign;
@property (nonatomic, retain) NSSet *transaction;
@end

@interface Currency (CoreDataGeneratedAccessors)

- (void)addTransactionObject:(Transaction *)value;
- (void)removeTransactionObject:(Transaction *)value;
- (void)addTransaction:(NSSet *)values;
- (void)removeTransaction:(NSSet *)values;

@end
