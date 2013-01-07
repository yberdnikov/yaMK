//
//  PriceValueTransformer.m
//  iCash
//
//  Created by Vitaly Merenkov on 07.01.13.
//  Copyright (c) 2013 Vitaly Merenkov. All rights reserved.
//

#import "PriceValueTransformer.h"

@implementation PriceValueTransformer

+ (Class)transformedValueClass
{
    return [NSNumber class];
}

+ (BOOL)allowsReverseTransformation
{
    return YES;
}

- (id) transformedValue:(id)value
{
    double result = 0;
    result = [value doubleValue] / 100;
    return [NSNumber numberWithDouble:result];
}

- (id) reverseTransformedValue:(id)value {
    int result = 0;
    result = [value doubleValue] * 100;
    return [NSNumber numberWithInt:result];
}

@end
