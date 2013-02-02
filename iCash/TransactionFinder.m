//
//  TransactionFinder.m
//  iCash
//
//  Created by Vitaly Merenkov on 27.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "TransactionFinder.h"
#import "Account.h"

@implementation TransactionFinder

+(NSArray *)findTransactionsBetweenStartDate:(NSDate *)startDate
                                     endDate:(NSDate *)endDate
                                   recipientType:(AccountType)recipientType
                                      sourceType:(AccountType)sourceType{
    NSManagedObjectContext *_moc = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectContext];
    NSMutableArray *predicates = [[NSMutableArray alloc] init];
    if (startDate) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"date >= %@" argumentArray:[NSArray arrayWithObject:startDate]]];
    }
    if (endDate) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"date < %@" argumentArray:[NSArray arrayWithObject:endDate]]];
    }
    [predicates addObject:[NSPredicate predicateWithFormat:@"recipient.type = %@" argumentArray:[NSArray arrayWithObject:[NSNumber numberWithInt:recipientType]]]];
    [predicates addObject:[NSPredicate predicateWithFormat:@"source.type = %@" argumentArray:[NSArray arrayWithObject:[NSNumber numberWithInt:sourceType]]]];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Transaction"];
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *result = [_moc executeFetchRequest:request error:&error];
    return result;
}

@end
