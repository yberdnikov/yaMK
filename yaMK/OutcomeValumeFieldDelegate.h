//
//  OutcomeValumeFieldDelegate.h
//  iCash
//
//  Created by Vitaly Merenkov on 10.12.12.

//

#import <Foundation/Foundation.h>

@class  CreateOutcomeController;

@interface OutcomeValumeFieldDelegate : NSObject<NSControlTextEditingDelegate>

@property (weak) IBOutlet CreateOutcomeController *coc;

@end
