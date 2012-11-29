//
//  AccountTreeController.h
//  iCash
//
//  Created by Vitaly Merenkov on 07.11.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Account.h"

@class CreateIncomeController;
@class CreateOutcomeController;

@interface AccountTreeController : NSTreeController 

- (IBAction)addIncomeAccount:(id)sender;
- (IBAction)addOutcomeAccount:(id)sender;
- (IBAction)addBalanceAccount:(id)sender;
- (void)addAccount:(id)sender
              type:(AccountType)t;
- (IBAction)removeAccount:(id)sender;
- (IBAction)showAddIncome:(id)sender;
- (IBAction)showAddOutcome:(id)sender;
- (Account *)selectedAccount;
- (void)selectionDidChange:(NSNotification *)notification;

@property (weak) IBOutlet CreateIncomeController *createIncomeCO;
@property (weak) IBOutlet CreateOutcomeController *createOutcomeCO;
@property (weak) IBOutlet NSOutlineView *outlineView;
@property (weak) IBOutlet NSPopover *incomePopover;
@property (weak) IBOutlet NSPopover *outcomePopover;
@property (weak) IBOutlet NSArrayController *selectedAccountArrC;
@property (weak) NSArray *transactionsSortDescriptors;
@end
