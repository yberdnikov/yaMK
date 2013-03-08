//
//  AccountDataSourceContainer.m
//  iCash
//
//  Created by Vitaly Merenkov on 06.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "DataSourceContainer.h"

@implementation DataSourceContainer

-(DataSourceContainer *)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        [self setName:name];
    }
    return self;
}

-(NSString *)description {
    NSMutableString *result = [[NSMutableString alloc] init];
    [result appendFormat:@"DataSrcCont [value = %f, intValue = %lu]", _value, _intValue];
    return result;
}

@end
