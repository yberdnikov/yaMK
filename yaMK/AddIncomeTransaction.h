//
//  WindowController.h
//  iCash
//
//  Created by Vitaly Merenkov on 11.11.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Transaction;

@interface AddIncomeTransaction : NSWindowController

@property Transaction *incomeTransaction;

@end
