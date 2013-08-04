//
//  ToolbarActionController.m
//  iCash
//
//  Created by Vitaly Merenkov on 13.01.13.

//

#import "MainWindowToolbarController.h"
#import "CreateMoveController.h"
#import "CreateExpenseController.h"
#import "CreateIncomeController.h"
#import "Account.h"

@implementation MainWindowToolbarController

- (IBAction)showCreateMove:(id)sender {
    [_movePanel makeKeyAndOrderFront:sender];
    [_createMoveCO prepareCreation];
}

- (IBAction)showAddTransaction:(id)sender {
    if ([[[self selectedAccount] type] intValue] == Expense) {
        [_expensePanel makeKeyAndOrderFront:sender];
        [_createExpenseCO prepareCreation];
    } else if ([[[self selectedAccount] type] intValue] == Balance) {
        [_incomePanel makeKeyAndOrderFront:sender];
        [_createIncomeCO setRecipientAccount:_selectedAccount];
        [_createIncomeCO prepareCreation];
    }
}

@end
