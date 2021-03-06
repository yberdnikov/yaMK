//
//  PlaceOfSpending.m
//  iCash
//
//  Created by Vitaly Merenkov on 04.11.12.

//

#import "PlaceOfSpending.h"
#import "Transaction.h"


@implementation PlaceOfSpending

@dynamic name;
@dynamic transaction;

- (void) setName:(NSString *)name {
    [self setPrimitiveValue:[name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"name"];
    [self didChangeValueForKey:@"name"];
}

@end
