//
//  AddIncomeWC.m
//  iCash
//
//  Created by Vitaly Merenkov on 11.11.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import "AddIncomeWC.h"
#import "Account.h"
#import "Transaction.h"

@implementation AddIncomeWC

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
        _mom = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectModel];
        _moc = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectContext];
        NSFetchRequest *findIncomeAccountsR = [_mom fetchRequestTemplateForName:@"findIncomeAccounts"];
        NSError *error;
        [self setIncomeAccounts:[_moc executeFetchRequest:findIncomeAccountsR error:&error]];
        NSLog(@"found %lu income accounts", [_incomeAccounts count]);
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    [_createButton setKeyEquivalent:@"\r"];
}

- (IBAction)createIncome:(id)sender {
    NSString *selectedAccountName = [_incomeAccountsCB objectValueOfSelectedItem];
    NSFetchRequest *findAccountByNameType = [_mom fetchRequestFromTemplateWithName:@"findAccountByNameType" substitutionVariables:@{@"NAME" : selectedAccountName, @"TYPE" : [NSNumber numberWithInt:Income]}];
    NSError *error;
    NSArray *selectedAccounts = [_moc executeFetchRequest:findAccountByNameType error:&error];
    Account *selectdeAccount;
    if ([selectedAccounts count] > 0) {
        selectdeAccount = selectedAccounts[0];
    }
    NSLog(@"selectedAccount = %@", [selectdeAccount name]);
    NSEntityDescription *transactionEntity = [[_mom entitiesByName] objectForKey:@"Transaction"];
    Transaction *income = [[Transaction alloc] initWithEntity:transactionEntity insertIntoManagedObjectContext:_moc];
    [income setSource:selectdeAccount];
    [income setValue:[NSNumber numberWithInt:[_transactionValue intValue]]];
    [income setName:[_transactionDescription stringValue]];
    [income setRecipient:[self recipientAccount]];
    
    [self close];
}
@end
