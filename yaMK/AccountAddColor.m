//
//  AccountAddColor.m
//  iCash
//
//  Created by Vitaly Merenkov on 06.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "AccountAddColor.h"

@implementation AccountAddColor

- (BOOL)createDestinationInstancesForSourceInstance:(NSManagedObject *)inSourceInstance
                                      entityMapping:(NSEntityMapping *)inMapping
                                            manager:(NSMigrationManager *)inManager
                                              error:(NSError **)outError
{
    NSManagedObject *newObject;
    NSEntityDescription *sourceInstanceEntity = [inSourceInstance entity];
    NSLog(@"createDestinationInstancesForSourceInstance");
    if ( [[sourceInstanceEntity name] isEqualToString:@"Account"] )
    {
        NSLog(@"Account");
        newObject = [NSEntityDescription insertNewObjectForEntityForName:@"Account"
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
            [newObject setValue:value forKey:key];
        }
        double color_red = ((double)arc4random() / 0x100000000);
        [newObject setValue:[NSNumber numberWithDouble:color_red] forKey:@"colorRed"];
        double color_green = ((double)arc4random() / 0x100000000);
        [newObject setValue:[NSNumber numberWithDouble:color_green] forKey:@"colorGreen"];
        double color_blue = ((double)arc4random() / 0x100000000);
        [newObject setValue:[NSNumber numberWithDouble:color_blue] forKey:@"colorBlue"];
    }
    
    [inManager associateSourceInstance:inSourceInstance
               withDestinationInstance:newObject
                      forEntityMapping:inMapping];
    
    return YES;
}

@end
