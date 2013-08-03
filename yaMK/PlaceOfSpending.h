//
//  PlaceOfSpending.h
//  iCash
//
//  Created by Vitaly Merenkov on 04.11.12.

//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Transaction;

@interface PlaceOfSpending : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *transaction;
@end

@interface PlaceOfSpending (CoreDataGeneratedAccessors)

- (void)addTransactionObject:(Transaction *)value;
- (void)removeTransactionObject:(Transaction *)value;
- (void)addTransaction:(NSSet *)values;
- (void)removeTransaction:(NSSet *)values;

@end
