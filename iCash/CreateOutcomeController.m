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
#import "TransactionNameFieldDelegate.h"

@implementation CreateOutcomeController

- (IBAction)createTransaction:(id)sender {
    if ([self showErrorWindow]) {
        return;
    }
    Account *sourceAccount = [_accountFinder findAccount:[_sourceAccount stringValue] type:Balance];
    NSLog(@"source account = %@", [sourceAccount name]);
    if ([_amount intValue]) {
        for (int i = 0; i < [_amount intValue]; i++) {
            [self createTransactionWithAccount:sourceAccount];
        }
    } else {
        [self createTransactionWithAccount:sourceAccount];
    }

    [self resetFields];
    [self computeFilterPredicate:[_date dateValue]];
    [[_name window] makeFirstResponder:_name];
}

- (NSArray *)outcomeTransactionsSortDescriptors {
    return [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
}

- (void) setOutcomeTransactionsSortDescriptors:(NSArray *)outcomeTransactionsSortDescriptors {
    
}

- (NSString *)getErrorMessage {
    NSMutableString *errorInfo = [[NSMutableString alloc] init];
    if ([[[_name stringValue] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        [errorInfo appendString: NSLocalizedStringFromTable(@"Description is not set! Please type some description.",
                                                            @"ErrorMessages",
                                                            @"Description is not set! Please type some description.")];
        [errorInfo appendString:@"\n"];
    }
    if (![_accountFinder findAccount:[_sourceAccount stringValue] type:Balance]) {
        [errorInfo appendString: NSLocalizedStringFromTable(@"Source account is not set! Please choose the appropriate one.",
                                                            @"ErrorMessages",
                                                            @"Source account is not set! Please choose the appropriate one.")];
        [errorInfo appendString:@"\n"];
    }
    if ([_price doubleValue] <= 0) {
        [errorInfo appendString: NSLocalizedStringFromTable(@"Price is not set! Please set some positive price.",
                                                            @"ErrorMessages",
                                                            @"Price is not set! Please set some positive price.")];
        [errorInfo appendString:@"\n"];
    }
    if (![_date dateValue]) {
        [errorInfo appendString: NSLocalizedStringFromTable(@"Date is not set! Please choose a date of spending.",
                                                            @"ErrorMessages",
                                                            @"Date is not set! Please choose a date of spending.")];
        [errorInfo appendString:@"\n"];
    }
    if ([_amount intValue] <= 0 && !([[[_amount stringValue] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)) {
        [errorInfo appendString: NSLocalizedStringFromTable(@"Amount should be positive integer! You may live it empty, this is the same as 1.",
                                                            @"ErrorMessages",
                                                            @"Amount should be positive integer! You may live it empty, this is the same as 1.")];
        [errorInfo appendString:@"\n"];
    }
    if ([_volume doubleValue] <= 0 && !([[[_volume stringValue] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)) {
        [errorInfo appendString: NSLocalizedStringFromTable(@"Volume should be positive! You may live it empty, this is the same as 1.",
                                                            @"ErrorMessages",
                                                            @"Volume should be positive! You may live it empty, this is the same as 1.")];
    }
    return errorInfo;
}

- (PlaceOfSpending *) findOrCreatePlaceOfSpending:(NSString *) name {
    NSFetchRequest *findPlaceByName = [_mom fetchRequestFromTemplateWithName:@"findPlaceOfSpendingByName" substitutionVariables:@{@"NAME" : name}];
    NSError *error;
    NSArray *foundPlaces = [_moc executeFetchRequest:findPlaceByName error:&error];
    PlaceOfSpending *place;
    if ([foundPlaces count] > 0) {
        place = foundPlaces[0];
    } else {
        place = [[PlaceOfSpending alloc] initWithEntity:[[_mom entitiesByName] objectForKey:@"PlaceOfSpending"] insertIntoManagedObjectContext:_moc];
        [place setName:name];
    }
    return place;
}

- (void) prepareCreation {
    NSLog(@"prepareCreation Begin");
    [self setMom:[[[NSDocumentController sharedDocumentController] currentDocument] managedObjectModel]];
    [self setMoc:[[[NSDocumentController sharedDocumentController] currentDocument] managedObjectContext]];
    
    [_date setDateValue:[NSDate date]];
    [_placeOfSpendig setStringValue:@""];
    [_sourceAccount setStringValue:@""];
    [_addButton setKeyEquivalent:@"\r"];
        
    [self computeFilterPredicate:[_date dateValue]];
    [_nameFieldDelegate setRecipientName:[_recipientAccount name]];
    [_balanceAccountsAC rearrangeObjects];
    [[_placeOfSpendig window] makeFirstResponder:_placeOfSpendig];
    [self resetFields];
    NSLog(@"prepareCreation End");
}

- (void) resetFields {
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
    [transaction setValue:[NSDecimalNumber decimalNumberWithDecimal:[[[self nf] numberFromString:[_price stringValue]] decimalValue]]];
    if ([_placeOfSpendig stringValue]) {
        [transaction setPlaceOfSpending:[self findOrCreatePlaceOfSpending:[_placeOfSpendig stringValue]]];
    }
    NSLog(@"********************************************************************");
    NSLog(@"sourceAccount = %@", [[transaction source] name]);
    NSLog(@"recipientAccount = %@", [[transaction recipient] name]);
    
}

- (void)computeFilterPredicate:(NSDate *) ddate {
    NSLog(@"computeFilterPredicate Begin");
    NSMutableArray *predicates = [NSMutableArray arrayWithObject:[NSPredicate predicateWithFormat:@"recipient.name == %@" argumentArray:[NSArray arrayWithObject:[_recipientAccount name]]]];
    if (ddate) {
        NSCalendar *cal = [NSCalendar currentCalendar];
        unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
        NSDateComponents *dateComps = [cal components:unitFlags fromDate:ddate];
        NSLog(@"add date to predicate %@", [cal dateFromComponents:dateComps]);
        [predicates addObject:[NSPredicate predicateWithFormat:@"date == %@" argumentArray:[NSArray arrayWithObject:[cal dateFromComponents:dateComps]]]];
    }
    [_otaController setFetchPredicate: [NSCompoundPredicate andPredicateWithSubpredicates:predicates]];
        NSLog(@"computeFilterPredicate End");
}

- (void) datePickerCell:(NSDatePickerCell *)aDatePickerCell validateProposedDateValue:(NSDate *__autoreleasing *)proposedDateValue timeInterval:(NSTimeInterval *)proposedTimeInterval {
    [self computeFilterPredicate:*proposedDateValue];
}

-(void)setDefaultValuesFromTrsansaction:(Transaction *)t {
   
    if ([_volume doubleValue] <= 0) {
        [_volume setDoubleValue:[[t amount] doubleValue]];
       
        [_price setStringValue:[[self nf] stringFromNumber:[t value]]];
    } else {
        [_price setDoubleValue:([[t value] doubleValue] / [[t amount] doubleValue] * [_volume doubleValue])];
    }
    
}
@end
