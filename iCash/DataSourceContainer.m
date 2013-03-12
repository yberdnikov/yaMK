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

-(DataSourceContainer *)initWithName:(NSString *)name
                            intValue:(NSInteger)intValue
                               color:(NSColor *)color {
    self = [super init];
    if (self) {
        [self setName:name];
        [self setIntValue:intValue];
        [self setValue:(double)intValue / 100.0];
        [self setColor:color];
    }
    return self;
}

-(NSString *)description {
    NSMutableString *result = [[NSMutableString alloc] init];
    [result appendFormat:@"DataSrcCont [name = %@, value = %f, intValue = %lu, subData = %@]", _name, _value, _intValue, _subData];
    return result;
}

@end
