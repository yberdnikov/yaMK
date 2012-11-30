//
//  CreateMoveController.m
//  iCash
//
//  Created by Vitaly Merenkov on 29.11.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import "CreateMoveController.h"
#import "AccountFinder.h"
#import "Account.h"
#import "Transaction.h"

@implementation CreateMoveController

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setDate:[NSDate date]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/mm/YYYY"];
    [self setDateString:[formatter stringFromDate:[self date]]];
}

- (IBAction)createMoveTransaction:(id)sender {
    if ([self isInputFieldsCorrect]) {
        Account *source = [_accountFinder findAccount:[_sourceAccount stringValue] type:Balance];
        Account *recipient = [_accountFinder findAccount:[_recipientAccount stringValue] type:Balance];
        NSLog(@"source account = %@", [source name]);
        NSLog(@"source account = %@", [recipient name]);
        if (source && recipient) {
            NSEntityDescription *transactionEntity = [[_mom entitiesByName] objectForKey:@"Transaction"];
            Transaction *transaction = [[Transaction alloc] initWithEntity:transactionEntity insertIntoManagedObjectContext:_moc];
            [transaction setRecipient:recipient];
            [transaction setSource:source];
            [transaction setName:@"-->"];
            [transaction setDate:[_datePicker dateValue]];
            [transaction setValue:[NSNumber numberWithDouble:[_value doubleValue]]];
        } else {
            //TODO show error
            return;
        }
    } else {
        //TODO show error
        return;
    }
    [self clearTransactionFields];
    [[_sourceAccount window] makeFirstResponder:_sourceAccount];
}

- (void) clearTransactionFields {
    [self setDate:[NSDate date]];
    [_sourceAccount setStringValue:@""];
    [_recipientAccount setStringValue:@""];
    [_value setStringValue:@""];
    [[_sourceAccount window] makeFirstResponder:_sourceAccount];
}

- (BOOL)isInputFieldsCorrect {
    NSLog(@"value = %f", [_value doubleValue]);
    NSLog(@"date = %@", [_datePicker dateValue]);
    NSLog(@"source = %@", [_sourceAccount stringValue]);
    NSLog(@"recipient = %@", [_recipientAccount stringValue]);
    if ([_value doubleValue] >=0 && [_datePicker dateValue] && [_sourceAccount stringValue] && [_recipientAccount stringValue]) {
        return YES;
    } else {
        return NO;
    }
}

- (void) popoverWillShow:(NSNotification *)notification {
    [self setMom:[[[NSDocumentController sharedDocumentController] currentDocument] managedObjectModel]];
    [self setMoc:[[[NSDocumentController sharedDocumentController] currentDocument] managedObjectContext]];
    [_sourceAccount setStringValue:@""];
    [_recipientAccount setStringValue:@""];
    [_value setStringValue:@""];
    [[_sourceAccount window] makeFirstResponder:_sourceAccount];
    [_moveButton setKeyEquivalent:@"\r"];
    [_datePicker setDateValue:[NSDate date]];
}
@end
