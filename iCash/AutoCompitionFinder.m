//
//  AutoCompitionFinder.m
//  iCash
//
//  Created by Vitaly Merenkov on 08.12.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import "AutoCompitionFinder.h"

@implementation AutoCompitionFinder
+ (NSArray *) findByFetchRequest:(NSFetchRequest *)request
                       startWith:(NSString *)sw{
    NSManagedObjectContext *moc = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectContext];
    
    NSError *error;
    NSArray *foundTransactions = [moc executeFetchRequest:request error:&error];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSLog(@"found transactions = %lu", [foundTransactions count]);
    
    for (uint i = 0; i < [foundTransactions count]; i++) {
        NSString *transactionName = [[foundTransactions objectAtIndex:i] name];
        if ([sw rangeOfString:@" "].location != NSNotFound) {
            NSLog(@"name = %@", [transactionName substringToIndex:[sw length] - 1]);
            NSLog(@"last space position = %lu", [sw  rangeOfString:@" " options:NSBackwardsSearch].location + 1);
            NSString *lastWord = [transactionName substringFromIndex:[sw  rangeOfString:@" " options:NSBackwardsSearch].location + 1];//[transactionName substringFromIndex:(lastSpacePosition + 1)];
            NSLog(@"lastWord = %@", lastWord);
            if (lastWord != nil && ![result containsObject:lastWord] && [transactionName substringFromIndex:[sw length]] > 0) {
                [result addObject:lastWord];
            }
        } else {
            NSLog(@"name = %@", transactionName);
            if (transactionName != nil && ![result containsObject:transactionName]) {
                
                [result addObject:transactionName];
            }
        }
    }
    return result;
}
@end
