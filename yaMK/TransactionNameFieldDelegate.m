//
//  TransactionNameFieldDelegate.m
//  iCash
//
//  Created by Vitaly Merenkov on 08.12.12.

//

#import "TransactionNameFieldDelegate.h"
#import "AutoCompitionFinder.h"
#import "BasicTrsansactionController.h"

@implementation TransactionNameFieldDelegate

-(NSArray *)control:(NSControl *)control
           textView:(NSTextView *)textView
        completions:(NSArray *)words
forPartialWordRange:(NSRange)charRange
indexOfSelectedItem:(NSInteger *)index {
    
    NSLog(@"text = %@", [control stringValue]);
    NSLog(@"recipientName = %@", _recipientName);
     
    NSString *nameStartsWith = [control stringValue];
        
    NSMutableArray *predicates = [NSMutableArray array];

    [predicates addObject:[NSPredicate predicateWithFormat:@"name BEGINSWITH[c] %@" argumentArray:[NSArray arrayWithObject:nameStartsWith]]];
    if (_recipientName) {
        [predicates addObject:[NSPredicate predicateWithFormat:@"recipient.name == %@" argumentArray:[NSArray arrayWithObject:_recipientName]]];
    }
    NSPredicate *andPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Transaction"];
    [fetchRequest setPredicate:andPredicate];
    *index = [[NSNumber numberWithInt:-1] integerValue];
    return [AutoCompitionFinder findByFetchRequest:fetchRequest startWith:nameStartsWith];
}

-(void)controlTextDidEndEditing:(NSNotification *)obj {
    [_basicTransCntrl setDefaultValues];
}

@end
