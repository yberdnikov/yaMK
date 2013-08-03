//
//  TransactionIntegerToDecimal.m
//  iCash
//
//  Created by Vitaly Merenkov on 27.03.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "TransactionIntegerToDecimal.h"

@implementation TransactionIntegerToDecimal

- (BOOL)createDestinationInstancesForSourceInstance:(NSManagedObject *)inSourceInstance
                                      entityMapping:(NSEntityMapping *)inMapping
                                            manager:(NSMigrationManager *)inManager
                                              error:(NSError **)outError
{
    NSManagedObject *newObject;
    NSEntityDescription *sourceInstanceEntity = [inSourceInstance entity];
    if ( [[sourceInstanceEntity name] isEqualToString:@"Transaction"] )
    {
        newObject = [NSEntityDescription insertNewObjectForEntityForName:@"Transaction"
                                                  inManagedObjectContext:[inManager destinationContext]];
        
        
        NSDictionary *keyValDict = [inSourceInstance committedValuesForKeys:nil];
        NSArray *allKeys = [[[inSourceInstance entity] attributesByName] allKeys];
        NSInteger i, max;
        max = [allKeys count];
        for (i=0 ; i< max ; i++)
        {
            // Get key and value
            NSString *key = [allKeys objectAtIndex:i];
            id value = [keyValDict objectForKey:key];
            if ([key isEqualToString:@"name"]) {
                if ([value isKindOfClass:[NSNull class]]) {
                    [newObject setValue:@"-" forKey:key];
                } else {
                    [newObject setValue:value forKey:key];
                }
            } else {
                [newObject setValue:value forKey:key];
            }
        }
        NSDecimalNumber *newValue = [NSDecimalNumber decimalNumberWithMantissa:[[keyValDict objectForKey:@"value"] integerValue] exponent:-2 isNegative:NO];
        [newObject setValue:newValue forKey:@"value"];
    }
    
    [inManager associateSourceInstance:inSourceInstance
               withDestinationInstance:newObject
                      forEntityMapping:inMapping];
    
    return YES;
}

@end
