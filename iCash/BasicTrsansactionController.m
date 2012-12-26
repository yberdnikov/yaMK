//
//  BasicTrsansactionController.m
//  iCash
//
//  Created by Vitaly Merenkov on 26.12.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import "BasicTrsansactionController.h"
#import "Transaction.h"

@implementation BasicTrsansactionController

-(void)setDefaultValues {
    NSManagedObjectModel *mom = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectModel];
    NSManagedObjectContext *moc = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectContext];
    Transaction *foundTransaction;
    NSString *name = [[self valueForKey:@"name"] stringValue];
    NSFetchRequest *findAccountByNameType = [mom fetchRequestFromTemplateWithName:@"findTransactionByName" substitutionVariables:@{@"NAME" : name}];
    [findAccountByNameType setSortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO]]];
    NSError *error;
    NSArray *foundTransactions = [moc executeFetchRequest:findAccountByNameType error:&error];
    if ([foundTransactions count] > 0) {
        foundTransaction = foundTransactions[0];
    }
    if (foundTransaction) {
        [self setDefaultValuesFromTrsansaction: foundTransaction];
    }
}

-(void)setDefaultValuesFromTrsansaction:(Transaction *)transaction {
    NSLog(@"default implementation, nothing was done!");
}

@end
