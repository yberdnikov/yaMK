//
//  AccountTreeController.h
//  iCash
//
//  Created by Vitaly Merenkov on 07.11.12.

//

#import <Cocoa/Cocoa.h>
#import "Account.h"

@class CreateIncomeController;
@class MainWindowToolbarController;

@interface AccountTreeController : NSTreeController 

- (IBAction)addIncomeAccount:(id)sender;
- (IBAction)addExpenseAccount:(id)sender;
- (IBAction)addBalanceAccount:(id)sender;
- (IBAction)removeAccount:(id)sender;
- (IBAction)searchFilter:(id)sender;

- (void)addAccount:(id)sender
              type:(AccountType)t;
- (Account *)selectedAccount;
- (void)selectionDidChange:(NSNotification *)notification;
- (NSArray *)transactionPredicate;
- (void)setTransactionPredicate:(NSArray *)arr;

@property (weak) IBOutlet MainWindowToolbarController *toolbarActionCO;
@property (weak) IBOutlet CreateIncomeController *createIncomeCO;
@property (weak) IBOutlet NSOutlineView *outlineView;
@property (weak) IBOutlet NSArrayController *selectedAccountArrC;
@property (weak) IBOutlet NSSearchField *searchField;
@property (weak) NSArray *transactionsSortDescriptors;
@property (strong) NSString *transactionNameForSearch;

@end
