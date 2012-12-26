//
//  TransactionNameFieldDelegate.h
//  iCash
//
//  Created by Vitaly Merenkov on 08.12.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BasicTrsansactionController;

@interface TransactionNameFieldDelegate : NSObject<NSControlTextEditingDelegate>

@property (weak) NSString *recipientName;
@property (weak) IBOutlet BasicTrsansactionController *basicTransCntrl;

@end
