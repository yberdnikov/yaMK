//
//  AccountDataSourceContainer.m
//  iCash
//
//  Created by Vitaly Merenkov on 06.01.13.

//

#import "DataSourceContainer.h"

@implementation DataSourceContainer

-(DataSourceContainer *)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

-(DataSourceContainer *)initWithName:(NSString *)name
                               value:(double)value
                               color:(NSColor *)color {
    self = [super init];
    if (self) {
        _name = name;
        _value = value;
        _color = color;
    }
    return self;
}

-(NSString *)description {
    NSMutableString *result = [[NSMutableString alloc] init];
    [result appendFormat:@"DataSrcCont [name = %@, value = %f, intValue = %lu, subData = %@]", _name, _value, _intValue, _subData];
    return result;
}

@end
