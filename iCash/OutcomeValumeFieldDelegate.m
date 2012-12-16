//
//  OutcomeValumeFieldDelegate.m
//  iCash
//
//  Created by Vitaly Merenkov on 10.12.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import "OutcomeValumeFieldDelegate.h"
#import "CreateOutcomeController.h"

@implementation OutcomeValumeFieldDelegate

-(void)controlTextDidEndEditing:(NSNotification *)obj {
    [_coc setDefaultValues];
}

@end
