//
//  BasicTrsansactionController.h
//  iCash
//
//  Created by Vitaly Merenkov on 26.12.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TransactionController.h"

@class Transaction;

@interface BasicTrsansactionController : NSObject<TransactionController>

-(void)setDefaultValuesFromTrsansaction:(Transaction *)transaction;
-(void)prepareCreation;
-(BOOL)showErrorWindow;
-(NSString *)getErrorMessage;

@end
