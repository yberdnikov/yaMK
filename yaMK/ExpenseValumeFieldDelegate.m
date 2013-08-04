//
//  ExpenseValumeFieldDelegate.m
//  iCash
//
//  Created by Vitaly Merenkov on 10.12.12.

//

#import "ExpenseValumeFieldDelegate.h"
#import "CreateExpenseController.h"

@implementation ExpenseValumeFieldDelegate

-(void)controlTextDidEndEditing:(NSNotification *)obj {
    [_coc setDefaultValues];
}

@end
