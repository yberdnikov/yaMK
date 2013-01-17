//
//  CreateOutcomeController.h
//  iCash
//
//  Created by Vitaly Merenkov on 18.11.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransactionController.h"
#import "BasicTrsansactionController.h"

@class AccountFinder;
@class Account;
@class TransactionNameFieldDelegate;

@interface CreateOutcomeController : BasicTrsansactionController<NSDatePickerCellDelegate, TransactionController>

@property (weak) IBOutlet NSTextField *placeOfSpendig;
@property (weak) IBOutlet NSDatePicker *date;
@property (weak) IBOutlet NSComboBox *sourceAccount;
@property (weak) IBOutlet NSTextField *name;
@property (weak) IBOutlet NSTextField *amount;
@property (weak) IBOutlet NSTextField *volume;
@property (weak) IBOutlet NSTextField *price;
@property (weak) IBOutlet NSButton *addButton;
@property (weak) IBOutlet AccountFinder *accountFinder;
@property (weak) Account *recipientAccount;
@property (weak) IBOutlet NSArrayController *otaController;
@property (weak) IBOutlet NSTableView *outcomeTransactions;
@property (weak) IBOutlet TransactionNameFieldDelegate *nameFieldDelegate;
@property (weak) IBOutlet NSArrayController *balanceAccountsAC;

@property (weak) NSManagedObjectContext *moc;
@property (weak) NSManagedObjectModel *mom;

@property (weak) NSArray *outcomeTransactionsSortDescriptors;

- (IBAction)createTransaction:(id)sender;

@end
