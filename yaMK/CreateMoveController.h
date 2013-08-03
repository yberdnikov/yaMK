//
//  CreateMoveController.h
//  iCash
//
//  Created by Vitaly Merenkov on 29.11.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicTrsansactionController.h"
#import "TransactionController.h"

@class AccountFinder;

@interface CreateMoveController : BasicTrsansactionController<TransactionController>

@property (weak) IBOutlet NSComboBox *sourceAccount;
@property (weak) IBOutlet NSComboBox *recipientAccount;
@property (weak) NSDate *date;
@property (weak) NSString *dateString;
@property (weak) IBOutlet NSTextField *value;
@property (weak) IBOutlet NSButton *moveButton;
@property (weak) IBOutlet AccountFinder *accountFinder;
@property (weak) IBOutlet NSDatePicker *datePicker;
@property (weak) IBOutlet NSArrayController *balanceAccountsAC;

@property (weak) NSManagedObjectContext *moc;
@property (weak) NSManagedObjectModel *mom;

- (IBAction)createMoveTransaction:(id)sender;
@end
