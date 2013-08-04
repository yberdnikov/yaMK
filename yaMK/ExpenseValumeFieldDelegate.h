//
//  ExpenseValumeFieldDelegate.h
//  iCash
//
//  Created by Vitaly Merenkov on 10.12.12.

//

#import <Foundation/Foundation.h>

@class  CreateExpenseController;

@interface ExpenseValumeFieldDelegate : NSObject<NSControlTextEditingDelegate>

@property (weak) IBOutlet CreateExpenseController *coc;

@end
