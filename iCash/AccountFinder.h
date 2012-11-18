//
//  AccountFinder.h
//  iCash
//
//  Created by Vitaly Merenkov on 18.11.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface AccountFinder : NSObject

- (Account *) findAccount:(NSString *)name
                     type:(AccountType)type;

@end
