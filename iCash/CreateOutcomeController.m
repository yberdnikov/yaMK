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
        NSLog(@"source account = %@", [sourceAccount name]);
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
    [self clearTransactionFields];
    [self computeFilterPredicate:[_date dateValue]];
}

- (BOOL)isInputFieldsCorrect {
    NSLog(@"name = %@", [_name stringValue]);
    NSLog(@"amount = %f", [_amount doubleValue]);
    NSLog(@"price = %f", [_price doubleValue]);
    NSLog(@"date = %@", [_date dateValue]);
    NSLog(@"source = %@", [_sourceAccount stringValue]);
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
    [_placeOfSpendig setStringValue:@""];
    [_sourceAccount setStringValue:@""];
    [_addButton setKeyEquivalent:@"\r"];
        
    [self computeFilterPredicate:[_date dateValue]];
}

- (void) clearTransactionFields {
    [_amount setStringValue:@""];
    [_volume setStringValue:@""];
    [_name setStringValue:@""];
    [_price setStringValue:@""];
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
    NSLog(@"********************************************************************");
    NSLog(@"sourceAccount = %@", [[transaction source] name]);
    NSLog(@"recipientAccount = %@", [[transaction recipient] name]);
    
}

- (void)computeFilterPredicate:(NSDate *) ddate {
    NSMutableArray *predicates = [NSMutableArray arrayWithObject:[NSPredicate predicateWithFormat:@"recipient.name == %@" argumentArray:[NSArray arrayWithObject:[_recipientAccount name]]]];
    if (ddate) {
        NSCalendar *cal = [NSCalendar currentCalendar];
        unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
        NSDateComponents *dateComps = [cal components:unitFlags fromDate:ddate];
        NSLog(@"add date to predicate %@", [cal dateFromComponents:dateComps]);
        [predicates addObject:[NSPredicate predicateWithFormat:@"date == %@" argumentArray:[NSArray arrayWithObject:[cal dateFromComponents:dateComps]]]];
    }
    [_otaController setFetchPredicate: [NSCompoundPredicate andPredicateWithSubpredicates:predicates]];
}

- (void) datePickerCell:(NSDatePickerCell *)aDatePickerCell validateProposedDateValue:(NSDate *__autoreleasing *)proposedDateValue timeInterval:(NSTimeInterval *)proposedTimeInterval {
    [self computeFilterPredicate:*proposedDateValue];
}
@end
