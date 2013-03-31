//
//  ModifyController.h
//  iCash
//
//  Created by Vitaly Merenkov on 19.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Transaction.h"
#import "BasicTrsansactionController.h"

@interface ModifyController : BasicTrsansactionController<NSComboBoxDelegate>

@property Transaction *transaction;
@property (weak) IBOutlet NSTableView *allTransactionsTable;
@property (weak) IBOutlet NSArrayController *allTransactionAC;
@property (weak) IBOutlet NSPopover *popover;
@property (weak) IBOutlet NSArrayController *sourceAccountAC;
@property (weak) IBOutlet NSArrayController *recipientAccountAC;
@property (weak) IBOutlet NSArrayController *transactionForSelectedAccount;
@property (weak) IBOutlet NSComboBox *sourceCB;
@property (weak) IBOutlet NSComboBox *recipientCB;
@property (weak) IBOutlet NSTextField *name;
@property (weak) IBOutlet NSDatePicker *date;
@property (weak) IBOutlet NSTextField *placeOfSpending;
@property (weak) IBOutlet NSTextField *amount;
@property (weak) IBOutlet NSTextField *price;
@property (weak) IBOutlet NSButton *button;

-(IBAction)modify:(id)sender;

-(void)showPopOver;

@end
