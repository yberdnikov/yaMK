//
//  ModifyController.m
//  iCash
//
//  Created by Vitaly Merenkov on 19.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "ModifyController.h"
#import "Account.h"
#import "PlaceOfSpending.h"

@implementation ModifyController

-(void)awakeFromNib {
    [_allTransactionsTable setDoubleAction:@selector(showPopOver)];
    [_allTransactionsTable setTarget:self];
}

-(void)showPopOver {
    [self setTransaction:[[_allTransactionAC selectedObjects] objectAtIndex:0]];
    [_popover showRelativeToRect:[_allTransactionsTable rectOfRow:[_allTransactionsTable selectedRow]] ofView:_allTransactionsTable preferredEdge:NSMaxYEdge];
    [_sourceAccountAC setFilterPredicate:[NSPredicate predicateWithFormat:@"type = %@" argumentArray:[NSArray arrayWithObject:[[_transaction source] type]]]];
    [_recipientAccountAC setFilterPredicate:[NSPredicate predicateWithFormat:@"type = %@" argumentArray:[NSArray arrayWithObject:[[_transaction recipient] type]]]];
    [_sourceAccountAC rearrangeObjects];
    [_recipientAccountAC rearrangeObjects];
    
    [self setFieldsValues];
    [_button setKeyEquivalent:@"\r"];
}

-(IBAction)modify:(id)sender {
    [_transaction setName:[_name stringValue]];
    [_transaction setAmount:[NSNumber numberWithDouble:[_amount doubleValue]]];
    [_transaction setValue:[NSNumber numberWithInt:([_price doubleValue] * 100)]];
    [_transaction setDate:[_date dateValue]];
    if ([_sourceCB indexOfSelectedItem] >= 0) {
        [_transaction setSource:[[_sourceAccountAC arrangedObjects] objectAtIndex:[_sourceCB indexOfSelectedItem]]];
    }
    if ([_recipientCB indexOfSelectedItem] >= 0) {
        [_transaction setRecipient:[[_recipientAccountAC arrangedObjects] objectAtIndex:[_recipientCB indexOfSelectedItem]]];
    }
    [_transaction setPlaceOfSpending:[self findOrCreatePlaceOfSpending:[_placeOfSpending stringValue]]];
    [_transactionForSelectedAccount rearrangeObjects];
    [_popover close];
 }

-(void)setFieldsValues {
    NSLog(@"transaction = %@", _transaction);
    [_name setStringValue:[_transaction name]];
    [_date setDateValue:[_transaction date]];
    if ([_transaction placeOfSpending]) {
        [_placeOfSpending setStringValue:[[_transaction placeOfSpending] name]];
    }
    [_amount setDoubleValue:[[_transaction amount] doubleValue]];
    [_price setDoubleValue:([[_transaction value] integerValue]/100.0)];
    [_sourceCB selectItemAtIndex:[[_sourceAccountAC arrangedObjects] indexOfObject:[_transaction source]]];
    [_sourceCB setObjectValue:[_sourceCB objectValueOfSelectedItem]];
    [_recipientCB selectItemAtIndex:[[_recipientAccountAC arrangedObjects] indexOfObject:[_transaction recipient]]];
    [_recipientCB setObjectValue:[_recipientCB objectValueOfSelectedItem]];
}

- (PlaceOfSpending *) findOrCreatePlaceOfSpending:(NSString *) name {
    NSManagedObjectModel *mom = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectModel];
    NSManagedObjectContext *moc = [[[NSDocumentController sharedDocumentController] currentDocument] managedObjectContext];
    NSFetchRequest *findPlaceByName = [mom fetchRequestFromTemplateWithName:@"findPlaceOfSpendingByName" substitutionVariables:@{@"NAME" : name}];
    NSError *error;
    NSArray *foundPlaces = [moc executeFetchRequest:findPlaceByName error:&error];
    PlaceOfSpending *place;
    if ([foundPlaces count] > 0) {
        place = foundPlaces[0];
    } else {
        place = [[PlaceOfSpending alloc] initWithEntity:[[mom entitiesByName] objectForKey:@"PlaceOfSpending"] insertIntoManagedObjectContext:moc];
        [place setName:name];
    }
    return place;
}

@end
