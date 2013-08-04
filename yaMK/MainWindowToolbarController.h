//
//  ToolbarActionController.h
//  iCash
//
//  Created by Vitaly Merenkov on 13.01.13.

//

#import <Cocoa/Cocoa.h>

@class CreateMoveController;
@class CreateIncomeController;
@class CreateExpenseController;
@class Account;

@interface MainWindowToolbarController : NSObject

- (IBAction)showCreateMove:(id)sender;
- (IBAction)showAddTransaction:(id)sender;
@property (weak) IBOutlet CreateMoveController *createMoveCO;
@property (weak) IBOutlet CreateIncomeController *createIncomeCO;
@property (weak) IBOutlet CreateExpenseController *createExpenseCO;
@property (strong) IBOutlet NSPanel *movePanel;
@property (strong) IBOutlet NSPanel *incomePanel;
@property (strong) IBOutlet NSPanel *expensePanel;

@property Account *selectedAccount;

@end
