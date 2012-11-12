//
//  AccountTreeController.h
//  iCash
//
//  Created by Vitaly Merenkov on 07.11.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Account.h"

@class AddIncomeWC;

@interface AccountTreeController : NSTreeController 

- (IBAction)addIncomeAccount:(id)sender;
- (IBAction)addOutcomeAccount:(id)sender;
- (IBAction)addBalanceAccount:(id)sender;
- (void)addAccount:(id)sender
              type:(AccountType)t;
- (IBAction)removeAccount:(id)sender;
- (IBAction)showAddIncomeWindow:(id)sender;
- (Account *)selectedAccount;

@property AddIncomeWC *aiwc;
@property (weak) IBOutlet NSOutlineView *outlineView;
@end
