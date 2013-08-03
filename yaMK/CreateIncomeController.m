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
    if ([self showErrorWindow]) {
        return;
    }
    NSString *selectedAccountName = [_incomeAccountsCB stringValue];
       
    NSLog(@"recipientAccount name = %@", [[self recipientAccount] name]);
    NSEntityDescription *transactionEntity = [[_mom entitiesByName] objectForKey:@"Transaction"];

    Transaction *income = [[Transaction alloc] initWithEntity:transactionEntity insertIntoManagedObjectContext:_moc];
    if (_consider) {
        Account *selectedAccount = [_accountFinder findAccount:selectedAccountName type:Income];
        [income setSource:selectedAccount];
        [income setName:[_name stringValue]];
        
    }
    [income setRecipient:[self recipientAccount]];
    [income setDate:[_transactionDate dateValue]];
    [income setValue:[NSDecimalNumber decimalNumberWithDecimal:[[[self nf] numberFromString:[_transactionValue stringValue]] decimalValue]]];
    [self resetFields];
    
}

- (NSString *)getErrorMessage {
    NSMutableString *errorInfo = [[NSMutableString alloc] init];
    if (_consider) {
        if ([[[_name stringValue] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
            [errorInfo appendString: NSLocalizedStringFromTable(@"Description is not set! Please type some description.",
                                                                @"ErrorMessages",
                                                                @"Description is not set! Please type some description.")];
            [errorInfo appendString:@"\n"];
        }
        if (![_accountFinder findAccount:[_incomeAccountsCB stringValue] type:Income]) {
            [errorInfo appendString: NSLocalizedStringFromTable(@"Source account is not set! Please choose the appropriate one.",
                                                                @"ErrorMessages",
                                                                @"Source account is not set! Please choose the appropriate one.")];
            [errorInfo appendString:@"\n"];
        }
    }
    if ([_transactionValue doubleValue] <= 0) {
        [errorInfo appendString: NSLocalizedStringFromTable(@"Value is not set! Please set some positive value.",
                                                            @"ErrorMessages",
                                                            @"Value is not set! Please set some positive value.")];
        [errorInfo appendString:@"\n"];
    }
    if (![_transactionDate dateValue]) {
        [errorInfo appendString: NSLocalizedStringFromTable(@"Date is not set! Please choose a date of spending.",
                                                            @"ErrorMessages",
                                                            @"Date is not set! Please choose a date of spending.")];
    }
    return errorInfo;
}

- (void)resetFields {
    [_name setStringValue:@""];
    [_incomeAccountsCB deselectItemAtIndex:[_incomeAccountsCB indexOfSelectedItem]];
    [_transactionValue setStringValue:@""];
}

-(void)prepareCreation {
    _mom = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectModel];
    _moc = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectContext];
    
    [self setConsider:YES];
    [_transactionDate setDateValue:[NSDate date]];
    [_createButton setKeyEquivalent:@"\r"];
    [_incomeAccountsAC rearrangeObjects];
    [[_incomeAccountsCB window] makeFirstResponder:_incomeAccountsCB];
    [self resetFields];
}

-(void)setDefaultValuesFromTrsansaction:(Transaction *)t {
    [_transactionValue setStringValue:[[self nf] stringFromNumber:[t value]]];
}
@end
