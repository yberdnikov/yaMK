//
//  TransactionFinder.m
//  iCash
//
//  Created by Vitaly Merenkov on 27.01.13.

//

#import "TransactionFinder.h"
#import "Account.h"

@implementation TransactionFinder

+(NSArray *)findTransactionsBetweenStartDate:(NSDate *)startDate
                                     endDate:(NSDate *)endDate
                                   recipientType:(AccountType)recipientType
                                      sourceType:(AccountType)sourceType{
    NSMutableArray *predicates = [[NSMutableArray alloc] init];
    if (startDate) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"date >= %@" argumentArray:[NSArray arrayWithObject:startDate]]];
    }
    if (endDate) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"date < %@" argumentArray:[NSArray arrayWithObject:endDate]]];
    }
    [predicates addObject:[NSPredicate predicateWithFormat:@"recipient.type = %@" argumentArray:[NSArray arrayWithObject:[NSNumber numberWithInt:recipientType]]]];
    [predicates addObject:[NSPredicate predicateWithFormat:@"source.type = %@" argumentArray:[NSArray arrayWithObject:[NSNumber numberWithInt:sourceType]]]];
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
    return [TransactionFinder findTransactionsUsingPredicate:predicate];
}

+(NSArray *)findTransactionsUsingPredicate:(NSPredicate *)predicate {
    NSManagedObjectContext *moc = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Transaction"];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *result = [moc executeFetchRequest:request error:&error];
    return result;
}

@end
