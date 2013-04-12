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
@class MainWindowToolbarController;

@interface AccountTreeController : NSTreeController 

- (IBAction)addIncomeAccount:(id)sender;
- (IBAction)addOutcomeAccount:(id)sender;
- (IBAction)addBalanceAccount:(id)sender;
- (void)addAccount:(id)sender
              type:(AccountType)t;
- (IBAction)removeAccount:(id)sender;
- (Account *)selectedAccount;
- (void)selectionDidChange:(NSNotification *)notification;
- (NSArray *)transactionPredicate;
- (void)setTransactionPredicate:(NSArray *)arr;

@property (weak) IBOutlet MainWindowToolbarController *toolbarActionCO;
@property (weak) IBOutlet CreateIncomeController *createIncomeCO;
@property (weak) IBOutlet NSOutlineView *outlineView;
@property (weak) IBOutlet NSArrayController *selectedAccountArrC;
@property (weak) NSArray *transactionsSortDescriptors;

@end
