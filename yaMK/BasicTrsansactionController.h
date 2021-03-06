//
//  BasicTrsansactionController.h
//  iCash
//
//  Created by Vitaly Merenkov on 26.12.12.

//

#import <Foundation/Foundation.h>
#import "TransactionController.h"

@class Transaction;

@interface BasicTrsansactionController : NSObject<TransactionController>

@property (weak) IBOutlet NSNumberFormatter *nf;

-(void)setDefaultValuesFromTrsansaction:(Transaction *)transaction;
-(void)prepareCreation;
-(BOOL)showErrorWindow;
-(NSString *)getErrorMessage;

@end
