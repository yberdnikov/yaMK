//
//  ToolbarActionController.m
//  iCash
//
//  Created by Vitaly Merenkov on 13.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "ToolbarActionController.h"
#import "CreateMoveController.h"
#import "CreateOutcomeController.h"
#import "CreateIncomeController.h"
#import "Account.h"

@implementation ToolbarActionController

- (IBAction)showCreateMove:(id)sender {
    [_movePanel makeKeyAndOrderFront:sender];
    [_createMoveCO prepareCreation];
}

- (IBAction)showAddTransaction:(id)sender {
    if ([[[self selectedAccount] type] intValue] == Outcome) {
        [_outcomePanel makeKeyAndOrderFront:sender];
        [_createOutcomeCO setRecipientAccount:_selectedAccount];
        [_createOutcomeCO prepareCreation];
    } else if ([[[self selectedAccount] type] intValue] == Balance) {
        [_incomePanel makeKeyAndOrderFront:sender];
        [_createIncomeCO setRecipientAccount:_selectedAccount];
        [_createIncomeCO prepareCreation];
    }
}

@end
