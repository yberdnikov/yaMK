//
//  AutoCompitionFinder.m
//  iCash
//
//  Created by Vitaly Merenkov on 08.12.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import "AutoCompitionFinder.h"

@implementation AutoCompitionFinder
+ (NSArray *) findByFetchRequest:(NSFetchRequest *)request {
    NSManagedObjectContext *moc = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectContext];
    
    NSError *error;
    NSArray *foundTransactions = [moc executeFetchRequest:request error:&error];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSLog(@"found transactions = %lu", [foundTransactions count]);
    
    for (uint i = 0; i < [foundTransactions count]; i++) {
        NSString *transactionName = [[foundTransactions objectAtIndex:i] name];
        NSLog(@"name = %@", transactionName);
        if (transactionName != nil && ![result containsObject:transactionName]) {
            [result addObject:transactionName];
        }
    }
    return result;
}
@end
