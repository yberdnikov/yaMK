//
//  AddIncomeWC.h
//  iCash
//
//  Created by Vitaly Merenkov on 11.11.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Transaction;
@class Account;

@interface CreateIncomeController : NSObject {
    @private
    
}
@property (strong) Account *recipientAccount;
@property NSArray *incomeAccounts;
//@property (weak) NSManagedObjectContext *moc;
//@property (weak) NSManagedObjectModel *mom;
@property (weak) IBOutlet NSComboBox *incomeAccountsCB;
@property (weak) IBOutlet NSButton *createButton;
@property (strong) IBOutlet NSArrayController *incomeAccountsAC;
@property (weak) IBOutlet NSTextField *transactionDescription;
@property (weak) IBOutlet NSTextField *transactionValue;
@property (weak) IBOutlet NSDatePicker *transactionDate;

- (IBAction)createIncome:(id)sender;

@end
