//
//  Document.h
//  iCash
//
//  Created by Vitaly Merenkov on 25.10.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Account.h"

@interface Document : NSPersistentDocument
{
@private
    IBOutlet NSOutlineView *_outlineView;
    NSSortDescriptor *_sortDesc;
}

- (IBAction)generateDummyData:(id)sender;

- (IBAction)addIncomeAccount:(id)sender;
- (IBAction)addOutcomeAccount:(id)sender;
- (IBAction)addBalanceAccount:(id)sender;
- (void)addAccount:(id)sender
              type:(AccountType)t;
- (IBAction)removeAccount:(id)sender;
- (NSSortDescriptor *)sortDesc;
@end
