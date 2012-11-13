//
//  AddIncomeWC.m
//  iCash
//
//  Created by Vitaly Merenkov on 11.11.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import "CreateIncomeController.h"
#import "Account.h"
#import "Transaction.h"

@implementation CreateIncomeController

//- (id)init
//{
//    self = [super init];
//    if (self) {
//        // Initialization code here.
//        [self setMom:[[[NSDocumentController sharedDocumentController] currentDocument] managedObjectModel]];
//        [self setMoc:[[[NSDocumentController sharedDocumentController] currentDocument] managedObjectContext] ];
//    }
//    return self;
//}

- (IBAction)createIncome:(id)sender {
    NSLog(@"createIncome");
    NSManagedObjectModel *_mom = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectModel];
    NSManagedObjectContext *_moc = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectContext];
    NSString *selectedAccountName = [_incomeAccountsCB objectValueOfSelectedItem];
    NSFetchRequest *findAccountByNameType = [_mom fetchRequestFromTemplateWithName:@"findAccountByNameType" substitutionVariables:@{@"NAME" : selectedAccountName, @"TYPE" : [NSNumber numberWithInt:Income]}];
    NSError *error;
    NSArray *selectedAccounts = [_moc executeFetchRequest:findAccountByNameType error:&error];
    Account *selectdeAccount;
    if ([selectedAccounts count] > 0) {
        selectdeAccount = selectedAccounts[0];
    }
    NSLog(@"sourceAccount = %@", [selectdeAccount name]);
    NSLog(@"recipientAccount name = %@", [[self recipientAccount] name]);
    NSEntityDescription *transactionEntity = [[_mom entitiesByName] objectForKey:@"Transaction"];
    Transaction *income = [[Transaction alloc] initWithEntity:transactionEntity insertIntoManagedObjectContext:_moc];
    [income setSource:selectdeAccount];
    [income setValue:[NSNumber numberWithInt:[_transactionValue intValue]]];
    [income setName:[_transactionDescription stringValue]];
    [income setRecipient:[self recipientAccount]];
    
}
@end
