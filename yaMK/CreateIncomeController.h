//
//  AddIncomeWC.h
//  iCash
//
//  Created by Vitaly Merenkov on 11.11.12.

//

#import <Cocoa/Cocoa.h>
#import "TransactionController.h"
#import "BasicTrsansactionController.h"

@class Transaction;
@class Account;
@class AccountFinder;

@interface CreateIncomeController : BasicTrsansactionController<TransactionController>

@property (strong) Account *recipientAccount;
@property NSArray *incomeAccounts;
@property (weak) IBOutlet NSComboBox *incomeAccountsCB;
@property (weak) IBOutlet NSButton *createButton;
@property (strong) IBOutlet NSArrayController *incomeAccountsAC;
@property (weak) IBOutlet NSTextField *name;
@property (weak) IBOutlet NSTextField *transactionValue;
@property (weak) IBOutlet NSDatePicker *transactionDate;
@property BOOL consider;
@property (weak) IBOutlet AccountFinder *accountFinder;

@property (weak) NSManagedObjectContext *moc;
@property (weak) NSManagedObjectModel *mom;

- (IBAction)createIncome:(id)sender;

@end
