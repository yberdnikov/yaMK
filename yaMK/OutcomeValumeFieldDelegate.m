//
//  OutcomeValumeFieldDelegate.m
//  iCash
//
//  Created by Vitaly Merenkov on 10.12.12.

//

#import "OutcomeValumeFieldDelegate.h"
#import "CreateOutcomeController.h"

@implementation OutcomeValumeFieldDelegate

-(void)controlTextDidEndEditing:(NSNotification *)obj {
    [_coc setDefaultValues];
}

@end
