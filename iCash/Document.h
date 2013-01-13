//
//  Document.h
//  iCash
//
//  Created by Vitaly Merenkov on 25.10.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Account.h"

@class CreateMoveController;

@interface Document : NSPersistentDocument

- (IBAction)showCreateMove:(id)sender;
@property (weak) IBOutlet NSPopover *movePopover;
@property (weak) IBOutlet CreateMoveController *createMoveCO;
@property (strong) IBOutlet NSPanel *movePanel;

@end
