//
//  Account.h
//  iCash
//
//  Created by Vitaly Merenkov on 31.10.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category, Transaction;

@interface Account : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) Category *category;
@property (nonatomic, retain) NSSet *recipientTransaction;
@property (nonatomic, retain) NSSet *sourceTransaction;
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

@end
