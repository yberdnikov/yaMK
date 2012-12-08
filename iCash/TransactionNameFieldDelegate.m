//
//  TransactionNameFieldDelegate.m
//  iCash
//
//  Created by Vitaly Merenkov on 08.12.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import "TransactionNameFieldDelegate.h"
#import "AutoCompitionFinder.h"

@implementation TransactionNameFieldDelegate

-(NSArray *)control:(NSControl *)control
           textView:(NSTextView *)textView
        completions:(NSArray *)words
forPartialWordRange:(NSRange)charRange
indexOfSelectedItem:(NSInteger *)index {
    
    NSLog(@"text = %@", [control stringValue]);
    NSString *nameStartsWith = [control stringValue];
    
    NSManagedObjectModel *mom = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectModel];
    
    NSFetchRequest *fetchRequest = [mom fetchRequestFromTemplateWithName:@"findTransactionStartsWithName" substitutionVariables:@{@"NAME" : nameStartsWith}];
    return [AutoCompitionFinder findByFetchRequest:fetchRequest];
}

@end
