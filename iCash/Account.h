//
//  Account.h
//  iCash
//
//  Created by Vitaly Merenkov on 05.11.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Account, Transaction;

@interface Account : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) Account *parent;
@property (nonatomic, retain) NSSet *recipientTransaction;
@property (nonatomic, retain) NSSet *sourceTransaction;
@property (nonatomic, retain) NSSet *subAccounts;
@end

@interface Account (CoreDataGeneratedAccessors)

- (void)addRecipientTransactionObject:(Transaction *)value;
- (void)removeRecipientTransactionObject:(Transaction *)value;
- (void)addRecipientTransaction:(NSSet *)values;
- (void)removeRecipientTransaction:(NSSet *)values;

- (void)addSourceTransactionObject:(Transaction *)value;
- (void)removeSourceTransactionObject:(Transaction *)value;
- (void)addSourceTransaction:(NSSet *)values;
- (void)removeSourceTransaction:(NSSet *)values;

- (void)addSubAccountsObject:(Account *)value;
- (void)removeSubAccountsObject:(Account *)value;
- (void)addSubAccounts:(NSSet *)values;
- (void)removeSubAccounts:(NSSet *)values;

- (NSImage *) typeImage;
- (void) setTypeImage:(NSImage *)image;
- (double) valueSum;
- (void) setValueSum:(double)value;
- (NSArray *)viewedTransactions;

@end

typedef enum {
    Income = 1,
    Outcome = 2,
    Balance = 3
} AccountType;