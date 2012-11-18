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
#import "AccountFinder.h"

@implementation CreateIncomeController

- (IBAction)createIncome:(id)sender {
    NSLog(@"createIncome");
    
    NSString *selectedAccountName = [_incomeAccountsCB stringValue];
       
    NSLog(@"recipientAccount name = %@", [[self recipientAccount] name]);
    NSEntityDescription *transactionEntity = [[_mom entitiesByName] objectForKey:@"Transaction"];
    
    NSLog(@"value = %d", [_transactionValue intValue]);
    if ([_transactionValue intValue] <= 0) {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"Value is not set or negative, please use only positive number for this field."];
        [alert setAlertStyle:NSWarningAlertStyle];
        [alert runModal];
        return;
    }
    
    Transaction *income = [[Transaction alloc] initWithEntity:transactionEntity insertIntoManagedObjectContext:_moc];
    if (_consider) {
        Account *selectedAccount = [_accountFinder findAccount:selectedAccountName type:Income];
        if (selectedAccount) {
            [income setSource:selectedAccount];
            [income setName:[_transactionDescription stringValue]];
        } else {
            NSAlert *alert = [[NSAlert alloc] init];
            NSString *error = [NSString stringWithFormat:@"Account with name '%@' is not found.", selectedAccountName];
            [alert setMessageText:error];
            [alert setAlertStyle:NSWarningAlertStyle];
            [alert runModal];
            return;
        }
    }
    [income setRecipient:[self recipientAccount]];
    [income setDate:[_transactionDate dateValue]];
    [income setValue:[NSNumber numberWithInt:[_transactionValue intValue]]];
    [self resetFields];
    
}

- (void)resetFields {
    [_transactionDescription setStringValue:@""];
    [_incomeAccountsCB deselectItemAtIndex:[_incomeAccountsCB indexOfSelectedItem]];
    [_transactionValue setStringValue:@""];
}

-(void)popoverWillShow:(NSNotification *)notification {
    _mom = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectModel];
    _moc = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectContext];
    
    [self setConsider:YES];
    [_transactionDate setDateValue:[NSDate date]];
    [_createButton setKeyEquivalent:@"\r"];
}
@end
