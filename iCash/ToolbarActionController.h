//
//  ToolbarActionController.h
//  iCash
//
//  Created by Vitaly Merenkov on 13.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CreateMoveController;
@class CreateIncomeController;
@class CreateOutcomeController;
@class Account;

@interface ToolbarActionController : NSObject

- (IBAction)showCreateMove:(id)sender;
- (IBAction)showAddTransaction:(id)sender;
@property (weak) IBOutlet CreateMoveController *createMoveCO;
@property (weak) IBOutlet CreateIncomeController *createIncomeCO;
@property (weak) IBOutlet CreateOutcomeController *createOutcomeCO;
@property (strong) IBOutlet NSPanel *movePanel;
@property (strong) IBOutlet NSPanel *incomePanel;
@property (strong) IBOutlet NSPanel *outcomePanel;

@property Account *selectedAccount;

@end
