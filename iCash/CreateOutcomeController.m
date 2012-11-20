//
//  CreateOutcomeController.m
//  iCash
//
//  Created by Vitaly Merenkov on 18.11.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import "CreateOutcomeController.h"
#import "Account.h"
#import "Transaction.h"
#import "AccountFinder.h"
#import "PlaceOfSpending.h"

@implementation CreateOutcomeController

- (IBAction)createTransaction:(id)sender {
    if ([self isInputFieldsCorrect]) {
        Account *sourceAccount = [_accountFinder findAccount:[_sourceAccount stringValue] type:Balance];
        NSLog(@"recipient account = %@", [sourceAccount name]);
        if (sourceAccount) {
            if ([_amount intValue]) {
                for (int i = 0; i < [_amount intValue]; i++) {
                    [self createTransactionWithAccount:sourceAccount];
                }
            } else {
                [self createTransactionWithAccount:sourceAccount];
            }
        } else {
            //TODO show error
            return;
        }
    } else {
        //TODO show error
        return;
    }
}

- (BOOL)isInputFieldsCorrect {
    NSLog(@"name = %@", [_name stringValue]);
    NSLog(@"amount = %f", [_amount doubleValue]);
    NSLog(@"price = %f", [_price doubleValue]);
    NSLog(@"date = %@", [_date dateValue]);
    NSLog(@"recipient = %@", [_sourceAccount stringValue]);
    if ([_name stringValue] && [_price doubleValue] >=0
        &&[_date dateValue] && [_sourceAccount stringValue]) {
        return YES;
    } else {
        return NO;
    }
}

- (PlaceOfSpending *) findOrCreatePlaceOfSpending:(NSString *) name {
    NSFetchRequest *findPlaceByName = [_mom fetchRequestFromTemplateWithName:@"findPlaceOfSpendingByName" substitutionVariables:@{@"NAME" : name}];
    NSError *error;
    NSArray *foundPlaces = [_moc executeFetchRequest:findPlaceByName error:&error];
    PlaceOfSpending *place;
    if ([foundPlaces count] > 0) {
        place = foundPlaces[0];
    }
    return place;
}

- (void) popoverWillShow:(NSNotification *)notification {
    [self setMom:[[[NSDocumentController sharedDocumentController] currentDocument] managedObjectModel]];
    [self setMoc:[[[NSDocumentController sharedDocumentController] currentDocument] managedObjectContext]];
    
    [_date setDateValue:[NSDate date]];
}

- (void) createTransactionWithAccount:(Account *)sourceAccount {
    NSEntityDescription *transactionEntity = [[_mom entitiesByName] objectForKey:@"Transaction"];
    Transaction *transaction = [[Transaction alloc] initWithEntity:transactionEntity insertIntoManagedObjectContext:_moc];
    [transaction setRecipient:_recipientAccount];
    [transaction setSource:sourceAccount];
    [transaction setName:[_name stringValue]];
    [transaction setDate:[_date dateValue]];
    if ([_volume doubleValue]) {
        [transaction setAmount:[NSNumber numberWithDouble:[_volume doubleValue]]];
    } else {
        [transaction setAmount:[NSNumber numberWithInt:1]];
    }
    [transaction setValue:[NSNumber numberWithDouble:[_price doubleValue]]];
    if ([_placeOfSpendig stringValue]) {
        [transaction setPlaceOfSpending:[self findOrCreatePlaceOfSpending:[_placeOfSpendig stringValue]]];
    }
}
@end
