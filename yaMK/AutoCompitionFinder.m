//
//  AutoCompitionFinder.m
//  iCash
//
//  Created by Vitaly Merenkov on 08.12.12.

//

#import "AutoCompitionFinder.h"

@implementation AutoCompitionFinder
+ (NSArray *) findByFetchRequest:(NSFetchRequest *)request
                       startWith:(NSString *)sw{
    NSManagedObjectContext *moc = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectContext];
    
    NSError *error;
    NSArray *foundTransactions = [moc executeFetchRequest:request error:&error];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (uint i = 0; i < [foundTransactions count]; i++) {
        NSString *transactionName = [[foundTransactions objectAtIndex:i] name];
        if ([sw rangeOfString:@" "].location != NSNotFound) {
            NSString *lastWord = [transactionName substringFromIndex:[sw  rangeOfString:@" " options:NSBackwardsSearch].location + 1];
            if (lastWord != nil && ![result containsObject:lastWord] && [transactionName substringFromIndex:[sw length]] > 0) {
                [result addObject:lastWord];
            }
        } else {
            if (transactionName != nil && ![result containsObject:transactionName]) {
                
                [result addObject:transactionName];
            }
        }
    }
    return result;
}
@end
