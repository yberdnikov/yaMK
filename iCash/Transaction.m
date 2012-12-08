//
//  Transaction.m
//  iCash
//
//  Created by Vitaly Merenkov on 05.11.12.
//  Copyright (c) 2012 Vitaly Merenkov. All rights reserved.
//

#import "Transaction.h"
#import "Account.h"
#import "Currency.h"
#import "PlaceOfSpending.h"


@implementation Transaction

@dynamic amount;
@dynamic name;
@dynamic date;
@dynamic value;
@dynamic currency;
@dynamic placeOfSpending;
@dynamic recipient;
@dynamic source;

- (void) setDate:(NSDate *)date {
    [self willChangeValueForKey:@"date"];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *dateComps = [cal components:unitFlags fromDate:date];
    [self setPrimitiveValue:[cal dateFromComponents:dateComps] forKey:@"date"];
    [self didChangeValueForKey:@"date"];
}

- (void) setName:(NSString *)name {
    [self setPrimitiveValue:[name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"name"];
    [self didChangeValueForKey:@"name"];
}


@end
