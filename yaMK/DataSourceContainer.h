//
//  AccountDataSourceContainer.h
//  iCash
//
//  Created by Vitaly Merenkov on 06.01.13.

//

#import <Foundation/Foundation.h>

@interface DataSourceContainer : NSObject

-(DataSourceContainer *)initWithName:(NSString *)name;
-(DataSourceContainer *)initWithName:(NSString *)name
                               value:(double)value
                               color:(NSColor *)color;


@property NSString *name;
@property double value;
@property NSInteger intValue;
@property NSColor *color;
@property NSArray *subData;

@end
